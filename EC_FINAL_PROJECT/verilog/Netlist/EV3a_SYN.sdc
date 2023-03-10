###################################################################

# Created by write_sdc on Fri Dec 16 21:47:45 2022

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_operating_conditions slow -library slow
set_wire_load_model -name tsmc13_wl10 -library slow
set_load -pin_load 1 [get_ports {Min_fit_o[9]}]
set_load -pin_load 1 [get_ports {Min_fit_o[8]}]
set_load -pin_load 1 [get_ports {Min_fit_o[7]}]
set_load -pin_load 1 [get_ports {Min_fit_o[6]}]
set_load -pin_load 1 [get_ports {Min_fit_o[5]}]
set_load -pin_load 1 [get_ports {Min_fit_o[4]}]
set_load -pin_load 1 [get_ports {Min_fit_o[3]}]
set_load -pin_load 1 [get_ports {Min_fit_o[2]}]
set_load -pin_load 1 [get_ports {Min_fit_o[1]}]
set_load -pin_load 1 [get_ports {Min_fit_o[0]}]
set_load -pin_load 1 [get_ports out_valid]
set_load -pin_load 1 [get_ports {Best_ind_state_o[21]}]
set_load -pin_load 1 [get_ports {Best_ind_state_o[20]}]
set_load -pin_load 1 [get_ports {Best_ind_state_o[19]}]
set_load -pin_load 1 [get_ports {Best_ind_state_o[18]}]
set_load -pin_load 1 [get_ports {Best_ind_state_o[17]}]
set_load -pin_load 1 [get_ports {Best_ind_state_o[16]}]
set_load -pin_load 1 [get_ports {Best_ind_state_o[15]}]
set_load -pin_load 1 [get_ports {Best_ind_state_o[14]}]
set_load -pin_load 1 [get_ports {Best_ind_state_o[13]}]
set_load -pin_load 1 [get_ports {Best_ind_state_o[12]}]
set_load -pin_load 1 [get_ports {Best_ind_state_o[11]}]
set_load -pin_load 1 [get_ports {Best_ind_state_o[10]}]
set_load -pin_load 1 [get_ports {Best_ind_state_o[9]}]
set_load -pin_load 1 [get_ports {Best_ind_state_o[8]}]
set_load -pin_load 1 [get_ports {Best_ind_state_o[7]}]
set_load -pin_load 1 [get_ports {Best_ind_state_o[6]}]
set_load -pin_load 1 [get_ports {Best_ind_state_o[5]}]
set_load -pin_load 1 [get_ports {Best_ind_state_o[4]}]
set_load -pin_load 1 [get_ports {Best_ind_state_o[3]}]
set_load -pin_load 1 [get_ports {Best_ind_state_o[2]}]
set_load -pin_load 1 [get_ports {Best_ind_state_o[1]}]
set_load -pin_load 1 [get_ports {Best_ind_state_o[0]}]
set_load -pin_load 1 [get_ports {Best_ind_mut_o[7]}]
set_load -pin_load 1 [get_ports {Best_ind_mut_o[6]}]
set_load -pin_load 1 [get_ports {Best_ind_mut_o[5]}]
set_load -pin_load 1 [get_ports {Best_ind_mut_o[4]}]
set_load -pin_load 1 [get_ports {Best_ind_mut_o[3]}]
set_load -pin_load 1 [get_ports {Best_ind_mut_o[2]}]
set_load -pin_load 1 [get_ports {Best_ind_mut_o[1]}]
set_load -pin_load 1 [get_ports {Best_ind_mut_o[0]}]
set_max_fanout 20 [get_ports clk]
set_max_fanout 20 [get_ports rst_n]
set_max_fanout 20 [get_ports {self_energy_in[3]}]
set_max_fanout 20 [get_ports {self_energy_in[2]}]
set_max_fanout 20 [get_ports {self_energy_in[1]}]
set_max_fanout 20 [get_ports {self_energy_in[0]}]
set_max_fanout 20 [get_ports {interact_energy_in[3]}]
set_max_fanout 20 [get_ports {interact_energy_in[2]}]
set_max_fanout 20 [get_ports {interact_energy_in[1]}]
set_max_fanout 20 [get_ports {interact_energy_in[0]}]
set_max_fanout 20 [get_ports {Mutate_rate_in[7]}]
set_max_fanout 20 [get_ports {Mutate_rate_in[6]}]
set_max_fanout 20 [get_ports {Mutate_rate_in[5]}]
set_max_fanout 20 [get_ports {Mutate_rate_in[4]}]
set_max_fanout 20 [get_ports {Mutate_rate_in[3]}]
set_max_fanout 20 [get_ports {Mutate_rate_in[2]}]
set_max_fanout 20 [get_ports {Mutate_rate_in[1]}]
set_max_fanout 20 [get_ports {Mutate_rate_in[0]}]
set_max_fanout 20 [get_ports {ind_state_in[21]}]
set_max_fanout 20 [get_ports {ind_state_in[20]}]
set_max_fanout 20 [get_ports {ind_state_in[19]}]
set_max_fanout 20 [get_ports {ind_state_in[18]}]
set_max_fanout 20 [get_ports {ind_state_in[17]}]
set_max_fanout 20 [get_ports {ind_state_in[16]}]
set_max_fanout 20 [get_ports {ind_state_in[15]}]
set_max_fanout 20 [get_ports {ind_state_in[14]}]
set_max_fanout 20 [get_ports {ind_state_in[13]}]
set_max_fanout 20 [get_ports {ind_state_in[12]}]
set_max_fanout 20 [get_ports {ind_state_in[11]}]
set_max_fanout 20 [get_ports {ind_state_in[10]}]
set_max_fanout 20 [get_ports {ind_state_in[9]}]
set_max_fanout 20 [get_ports {ind_state_in[8]}]
set_max_fanout 20 [get_ports {ind_state_in[7]}]
set_max_fanout 20 [get_ports {ind_state_in[6]}]
set_max_fanout 20 [get_ports {ind_state_in[5]}]
set_max_fanout 20 [get_ports {ind_state_in[4]}]
set_max_fanout 20 [get_ports {ind_state_in[3]}]
set_max_fanout 20 [get_ports {ind_state_in[2]}]
set_max_fanout 20 [get_ports {ind_state_in[1]}]
set_max_fanout 20 [get_ports {ind_state_in[0]}]
set_max_fanout 20 [get_ports {ind_fit_in[9]}]
set_max_fanout 20 [get_ports {ind_fit_in[8]}]
set_max_fanout 20 [get_ports {ind_fit_in[7]}]
set_max_fanout 20 [get_ports {ind_fit_in[6]}]
set_max_fanout 20 [get_ports {ind_fit_in[5]}]
set_max_fanout 20 [get_ports {ind_fit_in[4]}]
set_max_fanout 20 [get_ports {ind_fit_in[3]}]
set_max_fanout 20 [get_ports {ind_fit_in[2]}]
set_max_fanout 20 [get_ports {ind_fit_in[1]}]
set_max_fanout 20 [get_ports {ind_fit_in[0]}]
set_max_fanout 20 [get_ports in_valid_ind]
set_max_fanout 20 [get_ports in_valid_self]
set_max_fanout 20 [get_ports in_valid_interact]
set_ideal_network [get_ports clk]
create_clock [get_ports clk]  -period 6  -waveform {0 3}
set_clock_latency 0.5  [get_clocks clk]
set_clock_uncertainty 0.1  [get_clocks clk]
set_max_delay 6  -from [list [get_ports clk] [get_ports rst_n] [get_ports {self_energy_in[3]}] \
[get_ports {self_energy_in[2]}] [get_ports {self_energy_in[1]}] [get_ports     \
{self_energy_in[0]}] [get_ports {interact_energy_in[3]}] [get_ports            \
{interact_energy_in[2]}] [get_ports {interact_energy_in[1]}] [get_ports        \
{interact_energy_in[0]}] [get_ports {Mutate_rate_in[7]}] [get_ports            \
{Mutate_rate_in[6]}] [get_ports {Mutate_rate_in[5]}] [get_ports                \
{Mutate_rate_in[4]}] [get_ports {Mutate_rate_in[3]}] [get_ports                \
{Mutate_rate_in[2]}] [get_ports {Mutate_rate_in[1]}] [get_ports                \
{Mutate_rate_in[0]}] [get_ports {ind_state_in[21]}] [get_ports                 \
{ind_state_in[20]}] [get_ports {ind_state_in[19]}] [get_ports                  \
{ind_state_in[18]}] [get_ports {ind_state_in[17]}] [get_ports                  \
{ind_state_in[16]}] [get_ports {ind_state_in[15]}] [get_ports                  \
{ind_state_in[14]}] [get_ports {ind_state_in[13]}] [get_ports                  \
{ind_state_in[12]}] [get_ports {ind_state_in[11]}] [get_ports                  \
{ind_state_in[10]}] [get_ports {ind_state_in[9]}] [get_ports                   \
{ind_state_in[8]}] [get_ports {ind_state_in[7]}] [get_ports {ind_state_in[6]}] \
[get_ports {ind_state_in[5]}] [get_ports {ind_state_in[4]}] [get_ports         \
{ind_state_in[3]}] [get_ports {ind_state_in[2]}] [get_ports {ind_state_in[1]}] \
[get_ports {ind_state_in[0]}] [get_ports {ind_fit_in[9]}] [get_ports           \
{ind_fit_in[8]}] [get_ports {ind_fit_in[7]}] [get_ports {ind_fit_in[6]}]       \
[get_ports {ind_fit_in[5]}] [get_ports {ind_fit_in[4]}] [get_ports             \
{ind_fit_in[3]}] [get_ports {ind_fit_in[2]}] [get_ports {ind_fit_in[1]}]       \
[get_ports {ind_fit_in[0]}] [get_ports in_valid_ind] [get_ports in_valid_self] \
[get_ports in_valid_interact]]  -to [list [get_ports {Min_fit_o[9]}] [get_ports {Min_fit_o[8]}] [get_ports    \
{Min_fit_o[7]}] [get_ports {Min_fit_o[6]}] [get_ports {Min_fit_o[5]}]          \
[get_ports {Min_fit_o[4]}] [get_ports {Min_fit_o[3]}] [get_ports               \
{Min_fit_o[2]}] [get_ports {Min_fit_o[1]}] [get_ports {Min_fit_o[0]}]          \
[get_ports out_valid] [get_ports {Best_ind_state_o[21]}] [get_ports            \
{Best_ind_state_o[20]}] [get_ports {Best_ind_state_o[19]}] [get_ports          \
{Best_ind_state_o[18]}] [get_ports {Best_ind_state_o[17]}] [get_ports          \
{Best_ind_state_o[16]}] [get_ports {Best_ind_state_o[15]}] [get_ports          \
{Best_ind_state_o[14]}] [get_ports {Best_ind_state_o[13]}] [get_ports          \
{Best_ind_state_o[12]}] [get_ports {Best_ind_state_o[11]}] [get_ports          \
{Best_ind_state_o[10]}] [get_ports {Best_ind_state_o[9]}] [get_ports           \
{Best_ind_state_o[8]}] [get_ports {Best_ind_state_o[7]}] [get_ports            \
{Best_ind_state_o[6]}] [get_ports {Best_ind_state_o[5]}] [get_ports            \
{Best_ind_state_o[4]}] [get_ports {Best_ind_state_o[3]}] [get_ports            \
{Best_ind_state_o[2]}] [get_ports {Best_ind_state_o[1]}] [get_ports            \
{Best_ind_state_o[0]}] [get_ports {Best_ind_mut_o[7]}] [get_ports              \
{Best_ind_mut_o[6]}] [get_ports {Best_ind_mut_o[5]}] [get_ports                \
{Best_ind_mut_o[4]}] [get_ports {Best_ind_mut_o[3]}] [get_ports                \
{Best_ind_mut_o[2]}] [get_ports {Best_ind_mut_o[1]}] [get_ports                \
{Best_ind_mut_o[0]}]]
set_input_delay -clock clk  3  [get_ports clk]
set_input_delay -clock clk  0  [get_ports rst_n]
set_input_delay -clock clk  3  [get_ports {self_energy_in[3]}]
set_input_delay -clock clk  3  [get_ports {self_energy_in[2]}]
set_input_delay -clock clk  3  [get_ports {self_energy_in[1]}]
set_input_delay -clock clk  3  [get_ports {self_energy_in[0]}]
set_input_delay -clock clk  3  [get_ports {interact_energy_in[3]}]
set_input_delay -clock clk  3  [get_ports {interact_energy_in[2]}]
set_input_delay -clock clk  3  [get_ports {interact_energy_in[1]}]
set_input_delay -clock clk  3  [get_ports {interact_energy_in[0]}]
set_input_delay -clock clk  3  [get_ports {Mutate_rate_in[7]}]
set_input_delay -clock clk  3  [get_ports {Mutate_rate_in[6]}]
set_input_delay -clock clk  3  [get_ports {Mutate_rate_in[5]}]
set_input_delay -clock clk  3  [get_ports {Mutate_rate_in[4]}]
set_input_delay -clock clk  3  [get_ports {Mutate_rate_in[3]}]
set_input_delay -clock clk  3  [get_ports {Mutate_rate_in[2]}]
set_input_delay -clock clk  3  [get_ports {Mutate_rate_in[1]}]
set_input_delay -clock clk  3  [get_ports {Mutate_rate_in[0]}]
set_input_delay -clock clk  3  [get_ports {ind_state_in[21]}]
set_input_delay -clock clk  3  [get_ports {ind_state_in[20]}]
set_input_delay -clock clk  3  [get_ports {ind_state_in[19]}]
set_input_delay -clock clk  3  [get_ports {ind_state_in[18]}]
set_input_delay -clock clk  3  [get_ports {ind_state_in[17]}]
set_input_delay -clock clk  3  [get_ports {ind_state_in[16]}]
set_input_delay -clock clk  3  [get_ports {ind_state_in[15]}]
set_input_delay -clock clk  3  [get_ports {ind_state_in[14]}]
set_input_delay -clock clk  3  [get_ports {ind_state_in[13]}]
set_input_delay -clock clk  3  [get_ports {ind_state_in[12]}]
set_input_delay -clock clk  3  [get_ports {ind_state_in[11]}]
set_input_delay -clock clk  3  [get_ports {ind_state_in[10]}]
set_input_delay -clock clk  3  [get_ports {ind_state_in[9]}]
set_input_delay -clock clk  3  [get_ports {ind_state_in[8]}]
set_input_delay -clock clk  3  [get_ports {ind_state_in[7]}]
set_input_delay -clock clk  3  [get_ports {ind_state_in[6]}]
set_input_delay -clock clk  3  [get_ports {ind_state_in[5]}]
set_input_delay -clock clk  3  [get_ports {ind_state_in[4]}]
set_input_delay -clock clk  3  [get_ports {ind_state_in[3]}]
set_input_delay -clock clk  3  [get_ports {ind_state_in[2]}]
set_input_delay -clock clk  3  [get_ports {ind_state_in[1]}]
set_input_delay -clock clk  3  [get_ports {ind_state_in[0]}]
set_input_delay -clock clk  3  [get_ports {ind_fit_in[9]}]
set_input_delay -clock clk  3  [get_ports {ind_fit_in[8]}]
set_input_delay -clock clk  3  [get_ports {ind_fit_in[7]}]
set_input_delay -clock clk  3  [get_ports {ind_fit_in[6]}]
set_input_delay -clock clk  3  [get_ports {ind_fit_in[5]}]
set_input_delay -clock clk  3  [get_ports {ind_fit_in[4]}]
set_input_delay -clock clk  3  [get_ports {ind_fit_in[3]}]
set_input_delay -clock clk  3  [get_ports {ind_fit_in[2]}]
set_input_delay -clock clk  3  [get_ports {ind_fit_in[1]}]
set_input_delay -clock clk  3  [get_ports {ind_fit_in[0]}]
set_input_delay -clock clk  3  [get_ports in_valid_ind]
set_input_delay -clock clk  3  [get_ports in_valid_self]
set_input_delay -clock clk  3  [get_ports in_valid_interact]
set_output_delay -clock clk  3  [get_ports {Min_fit_o[9]}]
set_output_delay -clock clk  3  [get_ports {Min_fit_o[8]}]
set_output_delay -clock clk  3  [get_ports {Min_fit_o[7]}]
set_output_delay -clock clk  3  [get_ports {Min_fit_o[6]}]
set_output_delay -clock clk  3  [get_ports {Min_fit_o[5]}]
set_output_delay -clock clk  3  [get_ports {Min_fit_o[4]}]
set_output_delay -clock clk  3  [get_ports {Min_fit_o[3]}]
set_output_delay -clock clk  3  [get_ports {Min_fit_o[2]}]
set_output_delay -clock clk  3  [get_ports {Min_fit_o[1]}]
set_output_delay -clock clk  3  [get_ports {Min_fit_o[0]}]
set_output_delay -clock clk  3  [get_ports out_valid]
set_output_delay -clock clk  3  [get_ports {Best_ind_state_o[21]}]
set_output_delay -clock clk  3  [get_ports {Best_ind_state_o[20]}]
set_output_delay -clock clk  3  [get_ports {Best_ind_state_o[19]}]
set_output_delay -clock clk  3  [get_ports {Best_ind_state_o[18]}]
set_output_delay -clock clk  3  [get_ports {Best_ind_state_o[17]}]
set_output_delay -clock clk  3  [get_ports {Best_ind_state_o[16]}]
set_output_delay -clock clk  3  [get_ports {Best_ind_state_o[15]}]
set_output_delay -clock clk  3  [get_ports {Best_ind_state_o[14]}]
set_output_delay -clock clk  3  [get_ports {Best_ind_state_o[13]}]
set_output_delay -clock clk  3  [get_ports {Best_ind_state_o[12]}]
set_output_delay -clock clk  3  [get_ports {Best_ind_state_o[11]}]
set_output_delay -clock clk  3  [get_ports {Best_ind_state_o[10]}]
set_output_delay -clock clk  3  [get_ports {Best_ind_state_o[9]}]
set_output_delay -clock clk  3  [get_ports {Best_ind_state_o[8]}]
set_output_delay -clock clk  3  [get_ports {Best_ind_state_o[7]}]
set_output_delay -clock clk  3  [get_ports {Best_ind_state_o[6]}]
set_output_delay -clock clk  3  [get_ports {Best_ind_state_o[5]}]
set_output_delay -clock clk  3  [get_ports {Best_ind_state_o[4]}]
set_output_delay -clock clk  3  [get_ports {Best_ind_state_o[3]}]
set_output_delay -clock clk  3  [get_ports {Best_ind_state_o[2]}]
set_output_delay -clock clk  3  [get_ports {Best_ind_state_o[1]}]
set_output_delay -clock clk  3  [get_ports {Best_ind_state_o[0]}]
set_output_delay -clock clk  3  [get_ports {Best_ind_mut_o[7]}]
set_output_delay -clock clk  3  [get_ports {Best_ind_mut_o[6]}]
set_output_delay -clock clk  3  [get_ports {Best_ind_mut_o[5]}]
set_output_delay -clock clk  3  [get_ports {Best_ind_mut_o[4]}]
set_output_delay -clock clk  3  [get_ports {Best_ind_mut_o[3]}]
set_output_delay -clock clk  3  [get_ports {Best_ind_mut_o[2]}]
set_output_delay -clock clk  3  [get_ports {Best_ind_mut_o[1]}]
set_output_delay -clock clk  3  [get_ports {Best_ind_mut_o[0]}]
set_drive 0.1  [get_ports clk]
set_drive 0.1  [get_ports rst_n]
set_drive 0.1  [get_ports {self_energy_in[3]}]
set_drive 0.1  [get_ports {self_energy_in[2]}]
set_drive 0.1  [get_ports {self_energy_in[1]}]
set_drive 0.1  [get_ports {self_energy_in[0]}]
set_drive 0.1  [get_ports {interact_energy_in[3]}]
set_drive 0.1  [get_ports {interact_energy_in[2]}]
set_drive 0.1  [get_ports {interact_energy_in[1]}]
set_drive 0.1  [get_ports {interact_energy_in[0]}]
set_drive 0.1  [get_ports {Mutate_rate_in[7]}]
set_drive 0.1  [get_ports {Mutate_rate_in[6]}]
set_drive 0.1  [get_ports {Mutate_rate_in[5]}]
set_drive 0.1  [get_ports {Mutate_rate_in[4]}]
set_drive 0.1  [get_ports {Mutate_rate_in[3]}]
set_drive 0.1  [get_ports {Mutate_rate_in[2]}]
set_drive 0.1  [get_ports {Mutate_rate_in[1]}]
set_drive 0.1  [get_ports {Mutate_rate_in[0]}]
set_drive 0.1  [get_ports {ind_state_in[21]}]
set_drive 0.1  [get_ports {ind_state_in[20]}]
set_drive 0.1  [get_ports {ind_state_in[19]}]
set_drive 0.1  [get_ports {ind_state_in[18]}]
set_drive 0.1  [get_ports {ind_state_in[17]}]
set_drive 0.1  [get_ports {ind_state_in[16]}]
set_drive 0.1  [get_ports {ind_state_in[15]}]
set_drive 0.1  [get_ports {ind_state_in[14]}]
set_drive 0.1  [get_ports {ind_state_in[13]}]
set_drive 0.1  [get_ports {ind_state_in[12]}]
set_drive 0.1  [get_ports {ind_state_in[11]}]
set_drive 0.1  [get_ports {ind_state_in[10]}]
set_drive 0.1  [get_ports {ind_state_in[9]}]
set_drive 0.1  [get_ports {ind_state_in[8]}]
set_drive 0.1  [get_ports {ind_state_in[7]}]
set_drive 0.1  [get_ports {ind_state_in[6]}]
set_drive 0.1  [get_ports {ind_state_in[5]}]
set_drive 0.1  [get_ports {ind_state_in[4]}]
set_drive 0.1  [get_ports {ind_state_in[3]}]
set_drive 0.1  [get_ports {ind_state_in[2]}]
set_drive 0.1  [get_ports {ind_state_in[1]}]
set_drive 0.1  [get_ports {ind_state_in[0]}]
set_drive 0.1  [get_ports {ind_fit_in[9]}]
set_drive 0.1  [get_ports {ind_fit_in[8]}]
set_drive 0.1  [get_ports {ind_fit_in[7]}]
set_drive 0.1  [get_ports {ind_fit_in[6]}]
set_drive 0.1  [get_ports {ind_fit_in[5]}]
set_drive 0.1  [get_ports {ind_fit_in[4]}]
set_drive 0.1  [get_ports {ind_fit_in[3]}]
set_drive 0.1  [get_ports {ind_fit_in[2]}]
set_drive 0.1  [get_ports {ind_fit_in[1]}]
set_drive 0.1  [get_ports {ind_fit_in[0]}]
set_drive 0.1  [get_ports in_valid_ind]
set_drive 0.1  [get_ports in_valid_self]
set_drive 0.1  [get_ports in_valid_interact]
