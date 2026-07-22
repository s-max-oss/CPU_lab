@echo off
call D:\vivado\Vivado\2023.2\settings64.bat
cd /d D:\HuaweiMoveData\Users\20805\Desktop\homework\CPU_lab\miniRV_soc
vivado -mode batch -source src/sim/run_all_sim.tcl
