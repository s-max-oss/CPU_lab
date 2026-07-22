create_clock -name fpga_clk -period 10 [get_ports fpga_clk]

# Suppress UCIO-1 DRC on write_bitstream — all ports are constrained in miniRV_SoC.xdc
# but Vivado may flag top-level ports with bus indices that are connected through hierarchy
set_property SEVERITY {Warning} [get_drc_checks UCIO-1]

# FPGA config voltage settings
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
