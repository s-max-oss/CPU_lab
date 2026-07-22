# ============================================================================
# run_all_sim.tcl — miniRV_soc 模块级仿真批量运行脚本
# ============================================================================
# 用法:
#   vivado -mode batch -source src/sim/run_all_sim.tcl
#
# 每个 testbench 编译仿真并检查输出中的 PASSED/FAILED
# ============================================================================

set script_dir [file dirname [info script]]
set rtl_dir   [file normalize "$script_dir/../rtl"]
set sim_dir   [file normalize "$script_dir"]
set xsim_dir  [file normalize "$script_dir/../xsim_sim"]
file mkdir $xsim_dir
cd $xsim_dir

set defines_vh $rtl_dir/defines.vh

# ---------------------------------------------------------------------------
# RTL 源文件列表（按依赖顺序）
# ---------------------------------------------------------------------------
set rtl_files [list \
    $rtl_dir/defines.vh \
    $rtl_dir/Controller.v \
    $rtl_dir/multiplier.v \
    $rtl_dir/divider.v \
    $rtl_dir/ALU.v \
    $rtl_dir/RF.v \
    $rtl_dir/SEXT.v \
    $rtl_dir/NPC.v \
    $rtl_dir/PC.v \
    $rtl_dir/MEXT.v \
    $rtl_dir/MREQ.v \
    $rtl_dir/IF_ID_Reg.v \
    $rtl_dir/ID_EX_Reg.v \
    $rtl_dir/EX_MEM_Reg.v \
    $rtl_dir/MEM_WB_Reg.v \
    $rtl_dir/cpu_core.v]

# ---------------------------------------------------------------------------
# Testbench 列表和对应的额外 RTL 文件
# ---------------------------------------------------------------------------
proc run_tb {name extra_rtl defines} {
    global rtl_files rtl_dir sim_dir

    puts ""
    puts "============================================"
    puts " Running: $name"
    puts "============================================"

    set tb_file "$sim_dir/${name}.v"

    # Compile
    set xvlog_cmd "xvlog -i $rtl_dir"
    foreach d $defines {
        append xvlog_cmd " -d $d"
    }
    foreach f [concat $rtl_files $extra_rtl] {
        append xvlog_cmd " [list $f]"
    }
    append xvlog_cmd " [list $tb_file]"

    if {[catch {eval exec $xvlog_cmd} err]} {
        puts "  COMPILE FAILED: $err"
        return 0
    }

    # Elaborate
    set top "${name}"
    if {[catch {exec xelab $top -s sim_${name} -L xil_defaultlib} err]} {
        puts "  ELAB FAILED: $err"
        return 0
    }

    # Simulate
    if {[catch {exec xsim sim_${name} --runall} output]} {
        puts "  SIM FAILED: $output"
        return 0
    }

    # Check result
    if {[string match "*PASSED*" $output]} {
        puts "  -> PASSED"
        return 1
    } else {
        puts "  -> FAILED"
        puts "  Output: $output"
        return 0
    }
}

# ---------------------------------------------------------------------------
# 运行全部 testbench（不做 SoC 级测试，那需要在 RUN_TRACE 下）
# ---------------------------------------------------------------------------
set passed 0
set total 0

# 1. full_decode_tb — 纯组合逻辑，Controller 解码测试（44条指令）
incr total
if {[run_tb "full_decode_tb" {} {}]} { incr passed }

# 2. basic_rtype_tb — Controller + ALU，R-type 运算测试
incr total
if {[run_tb "basic_rtype_tb" {} {}]} { incr passed }

# 3. datapath_units_tb — SEXT + NPC + ALU + MREQ + MEXT 综合测试
incr total
if {[run_tb "datapath_units_tb" {} {}]} { incr passed }

# 4. pipeline_hazard_tb — 流水线冒险（转发+阻塞+冲刷）
incr total
if {[run_tb "pipeline_hazard_tb" {} {}]} { incr passed }

# 5. pipeline_control_mem_tb — 控制信号传播 + 字节/半字访存
incr total
if {[run_tb "pipeline_control_mem_tb" {} {}]} { incr passed }

# 6. pipeline_muldiv_tb — M-extension 乘除法流水线测试
incr total
if {[run_tb "pipeline_muldiv_tb" {} {}]} { incr passed }

# ---------------------------------------------------------------------------
# 结果汇总
# ---------------------------------------------------------------------------
puts ""
puts "============================================"
puts " Result: $passed / $total passed"
puts "============================================"

if {$passed != $total} {
    exit 1
}
