#!/bin/bash
echo ""
echo "Starting the Automation Script to ease synthesis using the Cadence Suite"
sleep 2
echo ""
echo "Enter the name of the Verilog File:"
read FileName
echo "Enter the Top Module Name:"
read ModuleName
csh
source /home/installs/cshrc
genus
read_libs /home/installs/FOUNDRY/digital/45nm/dig/lib/typical.lib
read_hdl $FileName.v
elaborate $ModuleName.v
read_sdc ${FileName}_Constraints_Input.sdc
set_db syn_generic_effort medium
set_db syn_map_effort medium
set_db syn_opt_effort medium
syn_generic
syn_map
syn_opt
report_power > ${FileName}_Power.rpt
report_area > ${FileName}_Area.rpt
report_timing > ${FileName}_Timing.rpt
write_hdl > ${FileName}_Netlist.v
write_sdc > ${FileName}_Constraints_Output.sdc
gui_show