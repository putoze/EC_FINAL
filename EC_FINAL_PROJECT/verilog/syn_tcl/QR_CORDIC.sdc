# operating conditions and boundary conditions #

set clk_period 12.0
create_clock -name "clk" -period $clk_period clk 

set_dont_touch_network      [all_clocks]
set_fix_hold                [all_clocks]
set_clock_uncertainty  0.1  [all_clocks]
set_clock_latency      0.5  [all_clocks]
#set_ideal_network           [get_ports CLK]

set_input_delay  [ expr $clk_period*0.5 ] -clock clk [all_inputs]
set_output_delay [ expr $clk_period*0.5 ] -clock clk [all_outputs]
set_input_delay 0 -clock clk rst_n

set_load 1 [all_outputs]
set_drive        0.1   [all_inputs]

set_operating_conditions -max_library slow -max slow
set_wire_load_model -name tsmc13_wl10 -library slow                        
set_max_fanout 20 [all_inputs]
set_max_delay $clk_period -from [all_inputs] -to [all_outputs]

