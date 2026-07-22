# ============================================================================
# create_ips.tcl -- Batch generate Vivado IPs for miniRV_basic_soc
# ============================================================================
# Usage (from miniRV_basic_soc directory):
#   vivado -mode batch -source src/ip/create_ips.tcl
# ============================================================================

set ip_dir [file normalize [file dirname [info script]]]

# ---------------------------------------------------------------------------
# 0. Create or open Vivado project
# ---------------------------------------------------------------------------
set project_name "miniRV_basic_soc_ip"
set project_dir  [file normalize "$ip_dir/../.."]

if {[file exists "$project_dir/$project_name.xpr"]} {
    open_project "$project_dir/$project_name.xpr"
} else {
    create_project -force $project_name $project_dir -part xc7a100tfgg484-2
}
set_property target_language Verilog [current_project]

# ---------------------------------------------------------------------------
# 1-5. AXI GPIO / AXI Uartlite IPs
# ---------------------------------------------------------------------------
create_ip -name axi_gpio -vendor xilinx.com -library ip -version 2.0 \
    -module_name axi_gpio_0 -dir $ip_dir
set_property -dict {
    CONFIG.C_GPIO_WIDTH {32}
    CONFIG.C_GPIO2_WIDTH {32}
    CONFIG.C_IS_DUAL {1}
    CONFIG.C_ALL_INPUTS {1}
    CONFIG.C_ALL_OUTPUTS {0}
    CONFIG.C_INTERRUPT_PRESENT {0}
} [get_ips axi_gpio_0]

create_ip -name axi_gpio -vendor xilinx.com -library ip -version 2.0 \
    -module_name axi_gpio_1 -dir $ip_dir
set_property -dict {
    CONFIG.C_GPIO_WIDTH {16}
    CONFIG.C_IS_DUAL {0}
    CONFIG.C_ALL_INPUTS {1}
    CONFIG.C_ALL_OUTPUTS {0}
    CONFIG.C_INTERRUPT_PRESENT {0}
} [get_ips axi_gpio_1]

create_ip -name axi_gpio -vendor xilinx.com -library ip -version 2.0 \
    -module_name axi_gpio_2 -dir $ip_dir
set_property -dict {
    CONFIG.C_GPIO_WIDTH {16}
    CONFIG.C_IS_DUAL {0}
    CONFIG.C_ALL_INPUTS {0}
    CONFIG.C_ALL_OUTPUTS {1}
    CONFIG.C_INTERRUPT_PRESENT {0}
} [get_ips axi_gpio_2]

create_ip -name axi_gpio -vendor xilinx.com -library ip -version 2.0 \
    -module_name axi_gpio_3 -dir $ip_dir
set_property -dict {
    CONFIG.C_GPIO_WIDTH {8}
    CONFIG.C_GPIO2_WIDTH {8}
    CONFIG.C_IS_DUAL {1}
    CONFIG.C_ALL_INPUTS {0}
    CONFIG.C_ALL_OUTPUTS {1}
    CONFIG.C_INTERRUPT_PRESENT {0}
} [get_ips axi_gpio_3]

create_ip -name axi_uartlite -vendor xilinx.com -library ip -version 2.0 \
    -module_name axi_uartlite_0 -dir $ip_dir
set_property -dict {
    CONFIG.C_BAUDRATE {115200}
    CONFIG.C_DATA_BITS {8}
    CONFIG.C_ODD_PARITY {0}
    CONFIG.C_USE_PARITY {0}
} [get_ips axi_uartlite_0]

# ---------------------------------------------------------------------------
# 6. AXI Protocol Converter -- 5 converters
# ---------------------------------------------------------------------------
for {set i 0} {$i < 5} {incr i} {
    create_ip -name axi_protocol_converter -vendor xilinx.com -library ip -version 2.1 \
        -module_name "axi_protocol_converter_$i" -dir $ip_dir
}

# ---------------------------------------------------------------------------
# 7. AXI Crossbar -- 1 Master to 6 Slaves
# ---------------------------------------------------------------------------
create_ip -name axi_crossbar -vendor xilinx.com -library ip -version 2.1 \
    -module_name axi_crossbar_0 -dir $ip_dir

set crossbar_props [dict create \
    NUM_MI 6 \
    NUM_SI 1 \
    STRATEGY 0 \
    M00_A00_ADDR_WIDTH 28 \
    M00_A00_BASE_ADDR  0x0000000000000000 \
    M01_A00_ADDR_WIDTH 12 \
    M01_A00_BASE_ADDR  0x00000000FFFF0000 \
    M02_A00_ADDR_WIDTH 12 \
    M02_A00_BASE_ADDR  0x00000000FFFF1000 \
    M03_A00_ADDR_WIDTH 12 \
    M03_A00_BASE_ADDR  0x00000000FFFF2000 \
    M04_A00_ADDR_WIDTH 12 \
    M04_A00_BASE_ADDR  0x00000000FFFF3000 \
    M05_A00_ADDR_WIDTH 12 \
    M05_A00_BASE_ADDR  0x00000000FFFF4000 \
    M00_S00_READ_CONNECTIVITY  1 \
    M00_S00_WRITE_CONNECTIVITY 1 \
    M01_S00_READ_CONNECTIVITY  1 \
    M01_S00_WRITE_CONNECTIVITY 1 \
    M02_S00_READ_CONNECTIVITY  1 \
    M02_S00_WRITE_CONNECTIVITY 1 \
    M03_S00_READ_CONNECTIVITY  1 \
    M03_S00_WRITE_CONNECTIVITY 1 \
    M04_S00_READ_CONNECTIVITY  1 \
    M04_S00_WRITE_CONNECTIVITY 1 \
    M05_S00_READ_CONNECTIVITY  1 \
    M05_S00_WRITE_CONNECTIVITY 1 \
]

set prop_dict [list]
dict for {k v} $crossbar_props {
    lappend prop_dict "CONFIG.${k}" $v
}
set_property -dict $prop_dict [get_ips axi_crossbar_0]

# ---------------------------------------------------------------------------
# 8. Generate wrappers (.veo) - IPs are already in project from create_ip
# ---------------------------------------------------------------------------
puts ""
puts "Generating IP wrappers..."
foreach ip [get_ips] {
    set ip_name [get_property NAME $ip]
    set veo_file "$ip_dir/${ip_name}/${ip_name}.veo"
    puts "  Generating $ip_name..."
    # generate_target all <ip> generates .veo and adds to fileset
    generate_target all $ip
}

# ---------------------------------------------------------------------------
# 10. Close and save project
# ---------------------------------------------------------------------------
close_project

# ---------------------------------------------------------------------------
# 11. Report
# ---------------------------------------------------------------------------
puts ""
puts "============================================"
puts " IP Generation Complete"
puts "============================================"
set ip_list [glob -directory $ip_dir -type d "*"]
foreach d [lsort $ip_list] {
    set name [file tail $d]
    if {[string match "axi_*" $name]} {
        puts "  - $name"
    }
}
puts ""
puts "Crossbar address map:"
puts "  0x00000000 (256MB) -> Slave 0 (memory)"
puts "  0xFFFF0000 (  4KB) -> Slave 1 (switch)"
puts "  0xFFFF1000 (  4KB) -> Slave 2 (led)"
puts "  0xFFFF2000 (  4KB) -> Slave 3 (digled)"
puts "  0xFFFF3000 (  4KB) -> Slave 4 (uart)"
puts "  0xFFFF4000 (  4KB) -> Slave 5 (timer)"
puts ""
puts "Veo files check:"
foreach d [lsort $ip_list] {
    set name [file tail $d]
    if {[string match "axi_*" $name]} {
        set veo_file "$d/${name}.veo"
        if {[file exists $veo_file]} {
            puts "  $name: OK"
        } else {
            puts "  $name: MISSING"
        }
    }
}
