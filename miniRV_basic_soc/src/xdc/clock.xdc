# ============================================================================
# 单周期 CPU FPGA 时钟约束
# ============================================================================
# 架构: 单周期 CPU + ICache + DCache + AXI Crossbar + 6 Slaves
# 时钟: fpga_clk = 100MHz (板上晶振), RUN_TRACE 模式直接使用
#
# 注意: 手写 Booth 乘法器 + 恢复余数除法器为纯组合逻辑 (ALU 内部函数),
# M-extension 路径约 97.9ns (306 逻辑级), 单周期无法在 25MHz+ 下收敛。
# FPGA I/O 测试程序不使用 M 指令, 基础指令路径可满足 25MHz。
# M-extension 通过 Verilator trace 仿真 (45/45 passed) 验证。
# ============================================================================

# 主时钟: 100MHz (板上晶振) → 目标系统时钟 25MHz (40ns)
create_clock -name fpga_clk -period 10.000 [get_ports fpga_clk]

# ============================================================================
# FPGA 配置
# ============================================================================
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

# UCIO-1: 允许未约束端口生成比特流（部分开发板引脚不需要全部连接）
set_property SEVERITY {Warning} [get_drc_checks UCIO-1]
