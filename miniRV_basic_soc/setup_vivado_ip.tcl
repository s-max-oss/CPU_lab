# ============================================================================
# setup_vivado_ip.tcl — miniRV_basic_soc synthesis + impl (Vivado IP version)
# ============================================================================
# Usage:
#   vivado -mode batch -source src/ip/create_ips.tcl      # step 1: generate IPs
#   vivado -mode batch -source setup_vivado_ip.tcl         # step 2: synthesize
# ============================================================================

set project_dir  [file dirname [info script]]
set src_dir      "$project_dir/src"
set ip_dir       "$src_dir/ip"

# Verify IP files exist
if {![file exists "$ip_dir/axi_crossbar_0/axi_crossbar_0.xci"]} {
    puts "ERROR: IP files not found."
    puts "Run: vivado -mode batch -source $ip_dir/create_ips.tcl first"
    exit 1
}

# Open existing IP project (created by create_ips.tcl)
set project_name "miniRV_basic_soc_ip"
set prj_path "$project_dir/$project_name.xpr"
if {![file exists $prj_path]} {
    puts "ERROR: Project $prj_path not found. Run create_ips.tcl first."
    exit 1
}
open_project $prj_path

# ---------------------------------------------------------------------------
# 1. Verilog defines
# ---------------------------------------------------------------------------
# USE_AXI_IP:  启用 Vivado IP Crossbar + 5 外设 wrapper
# RUN_TRACE:   绕过 PLL (综合时使用 fpga_clk 直接作为系统时钟)
set_property verilog_define {USE_AXI_IP RUN_TRACE} [current_fileset]

# ---------------------------------------------------------------------------
# 2. Add RTL source files
# ---------------------------------------------------------------------------
set rtl_dir "$src_dir/rtl"

# Add all .v and .vh files
add_files -norecurse [glob $rtl_dir/*.v]
add_files -norecurse [glob $rtl_dir/*.vh]

# Mark defines.vh as global include
set_property is_global_include true [get_files "$rtl_dir/defines.vh"]

# Add program.hex for $readmemh in bram_axi_synth
set hex_file "$project_dir/program.hex"
if {[file exists $hex_file]} {
    add_files -norecurse $hex_file
    puts "Added program.hex to project"
} else {
    puts "WARNING: program.hex not found at $hex_file"
}

# Disable files not used in IP mode:
# - bram_axi.v (simulation-only, $fopen/$fread)
foreach f {
    $rtl_dir/bram_axi.v
} {
    set fid [get_files -quiet $f]
    if {$fid ne ""} {
        set_property used_in_synthesis false $fid
        set_property used_in_simulation false $fid
    }
}

# Mark all other .v files for synthesis
set_property used_in_synthesis true [get_files -filter {FILE_TYPE == "Verilog"}]

# ---------------------------------------------------------------------------
# 3. Add constraint files
# ---------------------------------------------------------------------------
set xdc_dir "$src_dir/xdc"
if {[file exists "$xdc_dir/miniRV_SoC.xdc"]} {
    add_files -fileset constrs_1 -norecurse "$xdc_dir/miniRV_SoC.xdc"
}
if {[file exists "$xdc_dir/clock.xdc"]} {
    add_files -fileset constrs_1 -norecurse "$xdc_dir/clock.xdc"
}

# ---------------------------------------------------------------------------
# 4. Set top module (IP version: miniRV_SoC_fpga)
# ---------------------------------------------------------------------------
set_property top miniRV_SoC_fpga [current_fileset]

# ---------------------------------------------------------------------------
# 5. Synthesis
# ---------------------------------------------------------------------------
puts ""
puts "============================================"
puts " Starting synthesis for miniRV_basic_soc (IP mode)"
puts " Top: miniRV_SoC_fpga"
puts "============================================"

update_compile_order -fileset sources_1
launch_runs synth_1 -jobs 4
wait_on_run synth_1

set synth_status [get_property STATUS [get_runs synth_1]]
puts ""
puts "============================================"
puts " Synthesis status: $synth_status"
puts "============================================"

if {$synth_status ne "synth_design Complete!"} {
    puts "Synthesis FAILED."
    puts "Check: $project_dir/miniRV_basic_soc_ip.runs/synth_1/runme.log"
    exit 1
}

puts "Synthesis PASSED!"
puts ""

# ---------------------------------------------------------------------------
# 6. Implementation
# ---------------------------------------------------------------------------
open_run synth_1 -name synth_1
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets -hier -regex {.*fpga_clk.*IBUF.*}]

puts "Running implementation..."
launch_runs impl_1 -jobs 4
wait_on_run impl_1

set impl_status [get_property STATUS [get_runs impl_1]]
puts "Implementation status: $impl_status"

if {[string match "*route_design Complete*" $impl_status]} {
    open_run impl_1 -name impl_1
    set_property SEVERITY {Warning} [get_drc_checks UCIO-1]
    write_bitstream -force miniRV_SoC_fpga.bit
    puts "Bitstream generation complete!"
} else {
    puts "Implementation FAILED."
    puts "Check: $project_dir/miniRV_basic_soc_ip.runs/impl_1/runme.log"
}

close_project
