# ============================================================================
# vivado_lint_waivers.tcl — Vivado Linter 信息性警告抑制
# ============================================================================
# 用法: 在 Vivado Tcl Console 中执行: source src/xdc/vivado_lint_waivers.tcl
#
# 说明:
#   以下规则对应的警告均为"设计意图"（by design），已全部验证不是 bug：
#   - ASSIGN-10: AXI 端口部分位未读 — 简易外设/BRAM 不需要所有 AXI 字段
#   - ASSIGN-6:  内部信号未读 — debug 信号(verilator public) + 流水线冗余字段
#   - ASSIGN-1:  算术精度 — Booth 64→32 位截断是有意的
#   - RESET-2:   无异步复位 — 同步复位是 Xilinx FPGA 推荐设计方法
#   - INFER-2:   已在 MREQ.v 中修复（添加 default case）
#
#   降级为 INFO: 消息仍然可见，但不显示为 Error/Warning
# ============================================================================

set_msg_config -id {ASSIGN-1}  -new_severity {INFO}
set_msg_config -id {ASSIGN-6}  -new_severity {INFO}
set_msg_config -id {ASSIGN-10} -new_severity {INFO}
set_msg_config -id {RESET-2}  -new_severity {INFO}

puts "INFO: Vivado lint waivers loaded"
puts "INFO: ASSIGN-1/6/10 + RESET-2 downgraded to INFO (by design, not bugs)"
puts "INFO: INFER-2 was fixed in RTL (MREQ.v default case added)"
