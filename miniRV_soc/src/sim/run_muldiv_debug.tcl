set script_dir [file dirname [info script]]
set rtl_dir   [file normalize "$script_dir/../rtl"]
set sim_dir   [file normalize "$script_dir"]
set xsim_dir  [file normalize "$script_dir/../xsim_sim"]
file mkdir $xsim_dir
cd $xsim_dir

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

set tb_file "$sim_dir/pipeline_muldiv_tb.v"

set xvlog_cmd "xvlog -i $rtl_dir"
foreach f $rtl_files {
    append xvlog_cmd " [list $f]"
}
append xvlog_cmd " [list $tb_file]"

puts "Compiling..."
if {[catch {eval exec $xvlog_cmd} err]} {
    puts "COMPILE FAILED: $err"
    exit 1
}

puts "Elaborating..."
if {[catch {exec xelab pipeline_muldiv_tb -s sim_pipeline_muldiv -L xil_defaultlib} err]} {
    puts "ELAB FAILED: $err"
    exit 1
}

puts "Simulating..."
if {[catch {exec xsim sim_pipeline_muldiv --runall} output]} {
    puts "SIM FAILED: $output"
    exit 1
}

puts "Output: $output"
