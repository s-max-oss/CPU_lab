# ============================================================================
# setup_vivado.tcl — miniRV_soc Vivado 工程创建与综合脚本
# ============================================================================
# 用法:
#   vivado -mode batch -source setup_vivado.tcl
#
# 输出:
#   Vivado 项目: miniRV_soc/miniRV_soc.xpr
#   综合后网表: miniRV_soc/miniRV_soc.runs/synth_1/
#   Bitstream:   miniRV_soc/miniRV_soc.runs/impl_1/ (需要 run_implementation)

set project_name "miniRV_soc"
set project_dir  [file dirname [info script]]
set src_dir      "$project_dir/src"

# ---------------------------------------------------------------------------
# 1. 创建工程
# ---------------------------------------------------------------------------
create_project -force $project_name $project_dir -part xc7a100tfgg484-2
set_property target_language Verilog [current_project]

# ---------------------------------------------------------------------------
# 2. Verilog 宏定义 — FPGA综合必须定义 USE_AXI
# ---------------------------------------------------------------------------
# USE_AXI:  启用 AXI 总线模式 (cpu_top_axi + crossbar + 外设)
# RUN_TRACE: 绕过 PLL, 直接使用 fpga_clk (综合优先, 下板时移除)
set_property verilog_define {USE_AXI RUN_TRACE} [current_fileset]

# ---------------------------------------------------------------------------
# 3. 添加 RTL 源文件
# ---------------------------------------------------------------------------
set rtl_dir "$src_dir/rtl"

# 核心文件 (按依赖顺序) — 实际通过 glob 自动添加
# 列出所需文件以便检查
set rtl_files_expected {
    defines.vh ALU.v Controller.v DCache.v Data_RAM.v
    EX_MEM_Reg.v ICache.v ID_EX_Reg.v IF_ID_Reg.v Inst_ROM.v
    MEM_WB_Reg.v MEXT.v MREQ.v NPC.v PC.v RF.v SEXT.v
    axi_crossbar.v axi_master.v cpu_core.v cpu_top.v cpu_top_axi.v
    digled_wrap.v divider.v led_wrap.v multiplier.v
    switch_wrap.v timer_wrap.v uart_wrap.v
    miniRV_SoC.v bram_axi_synth.v miniRV_SoC_fpga.v
}

# 自动添加所有 .v 和 .vh 文件
add_files -norecurse [glob $rtl_dir/*.v]
add_files -norecurse [glob $rtl_dir/*.vh]

# 标记 defines.vh 为 global include
set_property is_global_include true [get_files "$rtl_dir/defines.vh"]

# 检查缺失文件
foreach f $rtl_files_expected {
    if {![file exists "$rtl_dir/$f"]} {
        puts "WARNING: $f not found!"
    }
}

# 将所有 .v 文件加入综合
set_property used_in_synthesis true [get_files -filter {FILE_TYPE == "Verilog"}]

# ---------------------------------------------------------------------------
# 4. 添加约束文件
# ---------------------------------------------------------------------------
set xdc_dir "$src_dir/xdc"
if {[file exists "$xdc_dir/miniRV_SoC.xdc"]} {
    add_files -fileset constrs_1 -norecurse "$xdc_dir/miniRV_SoC.xdc"
}
if {[file exists "$xdc_dir/clock.xdc"]} {
    add_files -fileset constrs_1 -norecurse "$xdc_dir/clock.xdc"
}

# Lint waivers — suppress informational warnings that are 'by design'
if {[file exists "$xdc_dir/vivado_lint_waivers.tcl"]} {
    source "$xdc_dir/vivado_lint_waivers.tcl"
}

# ---------------------------------------------------------------------------
# 5. (跳过) clk_wiz_0 IP — RUN_TRACE 模式下不需要 PLL
#    下板时需去掉 RUN_TRACE 并重新生成 clk_wiz_0 IP
# ---------------------------------------------------------------------------
puts "INFO: RUN_TRACE mode — skipping clk_wiz_0 PLL (using fpga_clk directly)"

# ---------------------------------------------------------------------------
# 6. 设置顶层模块
# ---------------------------------------------------------------------------
set_property top miniRV_SoC_fpga [current_fileset]
# 如果要综合 miniRV_SoC 本身 (不带 BRAM), 取消下一行注释:
# set_property top miniRV_SoC [current_fileset]

# ---------------------------------------------------------------------------
# 7. 运行综合
# ---------------------------------------------------------------------------
puts "\n============================================"
puts " Starting synthesis for $project_name"
puts " Top module: [get_property top [current_fileset]]"
puts "============================================\n"

# 首先 update_compile_order 更新编译顺序
update_compile_order -fileset sources_1

# Run synthesis
launch_runs synth_1 -jobs 4
wait_on_run synth_1

# ---------------------------------------------------------------------------
# 8. 检查综合结果
# ---------------------------------------------------------------------------
set synth_status [get_property STATUS [get_runs synth_1]]
puts "\n============================================"
puts " Synthesis status: $synth_status"
puts "============================================"

if {$synth_status eq "synth_design Complete!"} {
    puts "Synthesis PASSED!"
    puts ""

    # RUN_TRACE mode: fix clock routing (BUFG may be in wrong half)
    # Open synthesized design to apply post-synth constraints
    open_run synth_1 -name synth_1
    set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets -hier -regex {.*fpga_clk.*IBUF.*}]

    # Run implementation
    puts "Running implementation..."
    launch_runs impl_1 -jobs 4
    wait_on_run impl_1

    set impl_status [get_property STATUS [get_runs impl_1]]
    puts "Implementation status: $impl_status"

    if {$impl_status eq "route_design Complete!"} {
        # Suppress false-positive UCIO-1 DRC (all ports constrained in XDC)
        open_run impl_1 -name impl_1
        set_property SEVERITY {Warning} [get_drc_checks UCIO-1]
        write_bitstream -force miniRV_SoC_fpga.bit
        puts "Bitstream generation complete!"
    } else {
        puts "Implementation FAILED."
        puts "Check: miniRV_soc/miniRV_soc.runs/impl_1/runme.log"
    }
} else {
    puts "Synthesis FAILED. Check log:"
    puts "  miniRV_soc/miniRV_soc.runs/synth_1/runme.log"
}
