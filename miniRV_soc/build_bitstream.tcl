# ============================================================================
# build_bitstream.tcl — miniRV_soc 迭代构建脚本
# ============================================================================
# 用法:
#   vivado -mode batch -source build_bitstream.tcl -tclargs <program>
#
#   例: vivado -mode batch -source build_bitstream.tcl -tclargs ctest0
#       vivado -mode batch -source build_bitstream.tcl -tclargs ctest1_formatio
#
# 前提:
#   1. 先运行 setup_vivado.tcl 或 setup_vivado_ip.tcl 创建工程
#   2. RUN_TRACE 模式: 将对应的 .hex 文件复制为 program.hex
#      IP 模式:       将对应的 .coe 文件复制为 src/coe/program.coe
#
# 功能:
#   - 打开已有工程
#   - 综合 → 实现 → 生成 bitstream
#   - 提取时序报告 (WNS/WHS)
#   - 按程序名重命名 bitstream
# ============================================================================

set project_dir  [file dirname [info script]]
set result_dir   "$project_dir/results"
file mkdir $result_dir

# ---------------------------------------------------------------------------
# 1. 解析程序名参数
# ---------------------------------------------------------------------------
set program_name "program"
if {[llength $argv] > 0} {
    set program_name [lindex $argv 0]
}
# 安全检查: 只允许字母数字和下划线
if {![regexp {^[A-Za-z0-9_-]+$} $program_name]} {
    puts "ERROR: Invalid program name: $program_name"
    exit 1
}
puts "BUILD_PROGRAM=$program_name"

# ---------------------------------------------------------------------------
# 2. 检测并打开工程
# ---------------------------------------------------------------------------
# 优先使用 IP 模式工程，否则使用基础工程
set prj_ip   "$project_dir/miniRV_soc_ip.xpr"
set prj_base "$project_dir/miniRV_soc.xpr"

if {[file exists $prj_ip]} {
    set prj_path $prj_ip
    set prj_mode "IP"
} elseif {[file exists $prj_base]} {
    set prj_path $prj_base
    set prj_mode "RUN_TRACE"
} else {
    puts "ERROR: No project found. Run setup_vivado.tcl or setup_vivado_ip.tcl first."
    puts "  Checked: $prj_ip"
    puts "  Checked: $prj_base"
    exit 1
}

puts "BUILD_MODE=$prj_mode"
open_project $prj_path

# ---------------------------------------------------------------------------
# 3. RUN_TRACE 模式: 不需要重新生成 IP（使用 bram_axi_synth.v + program.hex）
#    IP 模式: 重新生成 bram_axi IP（COE 文件更新后需要）
# ---------------------------------------------------------------------------
if {$prj_mode eq "IP"} {
    # 查找 BRAM IP 并强制重新生成
    set bram_ips [get_ips -quiet -filter {NAME =~ "*bram*"}]
    if {[llength $bram_ips] > 0} {
        puts "Regenerating BRAM IP..."
        foreach ip $bram_ips {
            reset_target all [get_files [get_property IP_FILE $ip]]
            generate_target all [get_files [get_property IP_FILE $ip]]
        }
        # 重置综合 run 以使用新 IP
        set bram_runs [get_runs -quiet -filter {NAME =~ "*bram*"}]
        foreach r $bram_runs {
            reset_run $r
        }
    }
}

# ---------------------------------------------------------------------------
# 4. 综合
# ---------------------------------------------------------------------------
puts ""
puts "============================================"
puts " Synthesizing ($prj_mode mode)..."
puts "============================================"

reset_run synth_1
launch_runs synth_1 -jobs 4
wait_on_run synth_1

set synth_status [get_property STATUS [get_runs synth_1]]
puts "Synthesis: $synth_status"

if {[string first "Complete" $synth_status] < 0} {
    puts "BUILD_SYNTH_FAILED"
    exit 1
}

# ---------------------------------------------------------------------------
# 5. 实现
# ---------------------------------------------------------------------------
puts ""
puts "============================================"
puts " Implementing..."
puts "============================================"

launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1

set impl_status [get_property STATUS [get_runs impl_1]]
puts "Implementation: $impl_status"

if {[string first "Complete" $impl_status] < 0} {
    puts "BUILD_IMPL_FAILED"
    puts "Check: $prj_path.runs/impl_1/runme.log"
    exit 2
}

# ---------------------------------------------------------------------------
# 6. 结果提取
# ---------------------------------------------------------------------------
open_run impl_1 -name impl_1

# 时序报告
report_timing_summary -delay_type min_max -report_unconstrained \
    -check_timing_verbose -max_paths 20 \
    -file "$result_dir/timing_${program_name}.rpt"
report_utilization -file "$result_dir/utilization_${program_name}.rpt"

set wns [get_property STATS.WNS [get_runs impl_1]]
set whs [get_property STATS.WHS [get_runs impl_1]]
puts "BUILD_WNS=$wns"
puts "BUILD_WHS=$whs"

if {$wns < 0 || $whs < 0} {
    puts "BUILD_TIMING_FAILED (WNS=$wns, WHS=$whs)"
    # 不退出 — 时序违例时仍生成 bitstream 以供分析
}

# ---------------------------------------------------------------------------
# 7. Bitstream 复制和重命名
# ---------------------------------------------------------------------------
set bit_file [get_property DIRECTORY [get_runs impl_1]]/miniRV_SoC_fpga.bit
set result_bit "$result_dir/miniRV_SoC_${program_name}.bit"

if {[file exists $bit_file]} {
    file copy -force $bit_file $result_bit
    puts "BUILD_BITSTREAM=$result_bit"
    puts "BUILD_PASSED"
} else {
    puts "BUILD_BITSTREAM_NOT_FOUND: $bit_file"
    exit 3
}

close_project
