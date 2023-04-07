source /usr/cad/Design_Kit/synopsys_dc.setup
set DESIGN "EV3a"

read_file -format ddc ./File/$DESIGN\_SYN.ddc
read_saif -input $DESIGN.fsdb.saif -instance_name TESTBED/inst_$DESIGN
#read_saif -input $DESIGN\.fsdb.saif -instance_name TESTBED/inst_$DESIGN
current_design $DESIGN
link
report_power > Report/$DESIGN\_POWER 

exit
