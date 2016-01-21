# Create clock
create_clock -name clk -period 20.000 -waveform {0 10} [get_ports {CLOCK_50}]
derive_clock_uncertainty

#Creating false path
set_false_path -to [get_ports {LED[4] LED[3] LED[2] LED[1] LED[0]}]
set_input_delay -clock {CLOCK_50} 2 [get_ports {RESET_n}]
