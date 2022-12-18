source synopsys_dc.setup

set DESIGN "QR_CORDIC"

#Read All Files
analyze -library WORK -format verilog {/home/rain/QR_CORDIC/QR_CORDIC.v}
elaborate QR_CORDIC -architecture verilog -library DEFAULT

current_design QR_CORDIC
link

#Setting Clock Constraints
source -echo -verbose syn_tcl/$DESIGN\.sdc
check_design
set high_fanout_net_threshold 0
uniquify
set_fix_multiple_port_nets -all -buffer_constants [get_designs *]

#Synthesis all design
#compile -map_effort high -area_effort high
#compile -map_effort high -area_effort high -inc
compile_ultra -area

write -format ddc     -hierarchy -output "Netlist/QR_CORDIC_SYN.ddc"
write -format verilog -hierarchy -output Netlist/$DESIGN\_SYN.v
write_sdf -version 3.0 -context verilog -load_delay cell Netlist/$DESIGN\_SYN.sdf -significant_digits 6
#write_sdf -version 2.1  Netlist/QR_CORDIC_SYN.sdf
write_sdc -version 2.0 Netlist/$DESIGN\_SYN.sdc

report_timing >  Report/$DESIGN\.timing
report_area >  Report/$DESIGN\.area
report_power >  Report/$DESIGN\.power
report_resource >  Report/$DESIGN\.resource
