create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list clkgen2/inst/clk_out1]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 12 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {m/c/ether/w_send_buf_addr[0]} {m/c/ether/w_send_buf_addr[1]} {m/c/ether/w_send_buf_addr[2]} {m/c/ether/w_send_buf_addr[3]} {m/c/ether/w_send_buf_addr[4]} {m/c/ether/w_send_buf_addr[5]} {m/c/ether/w_send_buf_addr[6]} {m/c/ether/w_send_buf_addr[7]} {m/c/ether/w_send_buf_addr[8]} {m/c/ether/w_send_buf_addr[9]} {m/c/ether/w_send_buf_addr[10]} {m/c/ether/w_send_buf_addr[11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 8 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {m/c/ether/send_buf_data[0]} {m/c/ether/send_buf_data[1]} {m/c/ether/send_buf_data[2]} {m/c/ether/send_buf_data[3]} {m/c/ether/send_buf_data[4]} {m/c/ether/send_buf_data[5]} {m/c/ether/send_buf_data[6]} {m/c/ether/send_buf_data[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 8 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {m/c/ether/recv_buf_wdata[0]} {m/c/ether/recv_buf_wdata[1]} {m/c/ether/recv_buf_wdata[2]} {m/c/ether/recv_buf_wdata[3]} {m/c/ether/recv_buf_wdata[4]} {m/c/ether/recv_buf_wdata[5]} {m/c/ether/recv_buf_wdata[6]} {m/c/ether/recv_buf_wdata[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 12 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {m/c/ether/recv_addr[0]} {m/c/ether/recv_addr[1]} {m/c/ether/recv_addr[2]} {m/c/ether/recv_addr[3]} {m/c/ether/recv_addr[4]} {m/c/ether/recv_addr[5]} {m/c/ether/recv_addr[6]} {m/c/ether/recv_addr[7]} {m/c/ether/recv_addr[8]} {m/c/ether/recv_addr[9]} {m/c/ether/recv_addr[10]} {m/c/ether/recv_addr[11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 5 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {m/c/sdcram_0/sdi/sdc/state[0]} {m/c/sdcram_0/sdi/sdc/state[1]} {m/c/sdcram_0/sdi/sdc/state[2]} {m/c/sdcram_0/sdi/sdc/state[3]} {m/c/sdcram_0/sdi/sdc/state[4]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 8 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {m/c/ether/es0/buf_data[0]} {m/c/ether/es0/buf_data[1]} {m/c/ether/es0/buf_data[2]} {m/c/ether/es0/buf_data[3]} {m/c/ether/es0/buf_data[4]} {m/c/ether/es0/buf_data[5]} {m/c/ether/es0/buf_data[6]} {m/c/ether/es0/buf_data[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 2 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {m/c/ether/es0/txd_phy[0]} {m/c/ether/es0/txd_phy[1]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 8 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {m/c/ether/er0/data[0]} {m/c/ether/er0/data[1]} {m/c/ether/er0/data[2]} {m/c/ether/er0/data[3]} {m/c/ether/er0/data[4]} {m/c/ether/er0/data[5]} {m/c/ether/er0/data[6]} {m/c/ether/er0/data[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 2 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {m/c/ether/er0/p_0_in[0]} {m/c/ether/er0/p_0_in[1]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 5 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {m/c/sdcram_0/sdi/sdc/return_state[0]} {m/c/sdcram_0/sdi/sdc/return_state[1]} {m/c/sdcram_0/sdi/sdc/return_state[2]} {m/c/sdcram_0/sdi/sdc/return_state[3]} {m/c/sdcram_0/sdi/sdc/return_state[4]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 8 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list {m/c/sdcram_0/sdi/sdc/recv_data[0]} {m/c/sdcram_0/sdi/sdc/recv_data[1]} {m/c/sdcram_0/sdi/sdc/recv_data[2]} {m/c/sdcram_0/sdi/sdc/recv_data[3]} {m/c/sdcram_0/sdi/sdc/recv_data[4]} {m/c/sdcram_0/sdi/sdc/recv_data[5]} {m/c/sdcram_0/sdi/sdc/recv_data[6]} {m/c/sdcram_0/sdi/sdc/recv_data[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 40 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list {m/c/sdcram_0/sdi/sdc/recv_data_R7[0]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[1]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[2]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[3]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[4]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[5]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[6]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[7]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[8]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[9]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[10]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[11]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[12]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[13]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[14]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[15]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[16]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[17]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[18]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[19]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[20]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[21]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[22]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[23]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[24]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[25]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[26]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[27]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[28]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[29]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[30]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[31]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[32]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[33]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[34]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[35]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[36]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[37]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[38]} {m/c/sdcram_0/sdi/sdc/recv_data_R7[39]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 27 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list {m/c/sdcram_0/sdi/sdc/boot_counter[0]} {m/c/sdcram_0/sdi/sdc/boot_counter[1]} {m/c/sdcram_0/sdi/sdc/boot_counter[2]} {m/c/sdcram_0/sdi/sdc/boot_counter[3]} {m/c/sdcram_0/sdi/sdc/boot_counter[4]} {m/c/sdcram_0/sdi/sdc/boot_counter[5]} {m/c/sdcram_0/sdi/sdc/boot_counter[6]} {m/c/sdcram_0/sdi/sdc/boot_counter[7]} {m/c/sdcram_0/sdi/sdc/boot_counter[8]} {m/c/sdcram_0/sdi/sdc/boot_counter[9]} {m/c/sdcram_0/sdi/sdc/boot_counter[10]} {m/c/sdcram_0/sdi/sdc/boot_counter[11]} {m/c/sdcram_0/sdi/sdc/boot_counter[12]} {m/c/sdcram_0/sdi/sdc/boot_counter[13]} {m/c/sdcram_0/sdi/sdc/boot_counter[14]} {m/c/sdcram_0/sdi/sdc/boot_counter[15]} {m/c/sdcram_0/sdi/sdc/boot_counter[16]} {m/c/sdcram_0/sdi/sdc/boot_counter[17]} {m/c/sdcram_0/sdi/sdc/boot_counter[18]} {m/c/sdcram_0/sdi/sdc/boot_counter[19]} {m/c/sdcram_0/sdi/sdc/boot_counter[20]} {m/c/sdcram_0/sdi/sdc/boot_counter[21]} {m/c/sdcram_0/sdi/sdc/boot_counter[22]} {m/c/sdcram_0/sdi/sdc/boot_counter[23]} {m/c/sdcram_0/sdi/sdc/boot_counter[24]} {m/c/sdcram_0/sdi/sdc/boot_counter[25]} {m/c/sdcram_0/sdi/sdc/boot_counter[26]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 8 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list {m/c/sdcram_0/sdi/sdc/dout[0]} {m/c/sdcram_0/sdi/sdc/dout[1]} {m/c/sdcram_0/sdi/sdc/dout[2]} {m/c/sdcram_0/sdi/sdc/dout[3]} {m/c/sdcram_0/sdi/sdc/dout[4]} {m/c/sdcram_0/sdi/sdc/dout[5]} {m/c/sdcram_0/sdi/sdc/dout[6]} {m/c/sdcram_0/sdi/sdc/dout[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 10 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list {m/c/sdcram_0/sdi/sdc/byte_counter[0]} {m/c/sdcram_0/sdi/sdc/byte_counter[1]} {m/c/sdcram_0/sdi/sdc/byte_counter[2]} {m/c/sdcram_0/sdi/sdc/byte_counter[3]} {m/c/sdcram_0/sdi/sdc/byte_counter[4]} {m/c/sdcram_0/sdi/sdc/byte_counter[5]} {m/c/sdcram_0/sdi/sdc/byte_counter[6]} {m/c/sdcram_0/sdi/sdc/byte_counter[7]} {m/c/sdcram_0/sdi/sdc/byte_counter[8]} {m/c/sdcram_0/sdi/sdc/byte_counter[9]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 8 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list {m/c/sdcram_0/sdi/sdc/data_sig[0]} {m/c/sdcram_0/sdi/sdc/data_sig[1]} {m/c/sdcram_0/sdi/sdc/data_sig[2]} {m/c/sdcram_0/sdi/sdc/data_sig[3]} {m/c/sdcram_0/sdi/sdc/data_sig[4]} {m/c/sdcram_0/sdi/sdc/data_sig[5]} {m/c/sdcram_0/sdi/sdc/data_sig[6]} {m/c/sdcram_0/sdi/sdc/data_sig[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
set_property port_width 56 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list {m/c/sdcram_0/sdi/sdc/cmd_out[0]} {m/c/sdcram_0/sdi/sdc/cmd_out[1]} {m/c/sdcram_0/sdi/sdc/cmd_out[2]} {m/c/sdcram_0/sdi/sdc/cmd_out[3]} {m/c/sdcram_0/sdi/sdc/cmd_out[4]} {m/c/sdcram_0/sdi/sdc/cmd_out[5]} {m/c/sdcram_0/sdi/sdc/cmd_out[6]} {m/c/sdcram_0/sdi/sdc/cmd_out[7]} {m/c/sdcram_0/sdi/sdc/cmd_out[8]} {m/c/sdcram_0/sdi/sdc/cmd_out[9]} {m/c/sdcram_0/sdi/sdc/cmd_out[10]} {m/c/sdcram_0/sdi/sdc/cmd_out[11]} {m/c/sdcram_0/sdi/sdc/cmd_out[12]} {m/c/sdcram_0/sdi/sdc/cmd_out[13]} {m/c/sdcram_0/sdi/sdc/cmd_out[14]} {m/c/sdcram_0/sdi/sdc/cmd_out[15]} {m/c/sdcram_0/sdi/sdc/cmd_out[16]} {m/c/sdcram_0/sdi/sdc/cmd_out[17]} {m/c/sdcram_0/sdi/sdc/cmd_out[18]} {m/c/sdcram_0/sdi/sdc/cmd_out[19]} {m/c/sdcram_0/sdi/sdc/cmd_out[20]} {m/c/sdcram_0/sdi/sdc/cmd_out[21]} {m/c/sdcram_0/sdi/sdc/cmd_out[22]} {m/c/sdcram_0/sdi/sdc/cmd_out[23]} {m/c/sdcram_0/sdi/sdc/cmd_out[24]} {m/c/sdcram_0/sdi/sdc/cmd_out[25]} {m/c/sdcram_0/sdi/sdc/cmd_out[26]} {m/c/sdcram_0/sdi/sdc/cmd_out[27]} {m/c/sdcram_0/sdi/sdc/cmd_out[28]} {m/c/sdcram_0/sdi/sdc/cmd_out[29]} {m/c/sdcram_0/sdi/sdc/cmd_out[30]} {m/c/sdcram_0/sdi/sdc/cmd_out[31]} {m/c/sdcram_0/sdi/sdc/cmd_out[32]} {m/c/sdcram_0/sdi/sdc/cmd_out[33]} {m/c/sdcram_0/sdi/sdc/cmd_out[34]} {m/c/sdcram_0/sdi/sdc/cmd_out[35]} {m/c/sdcram_0/sdi/sdc/cmd_out[36]} {m/c/sdcram_0/sdi/sdc/cmd_out[37]} {m/c/sdcram_0/sdi/sdc/cmd_out[38]} {m/c/sdcram_0/sdi/sdc/cmd_out[39]} {m/c/sdcram_0/sdi/sdc/cmd_out[40]} {m/c/sdcram_0/sdi/sdc/cmd_out[41]} {m/c/sdcram_0/sdi/sdc/cmd_out[42]} {m/c/sdcram_0/sdi/sdc/cmd_out[43]} {m/c/sdcram_0/sdi/sdc/cmd_out[44]} {m/c/sdcram_0/sdi/sdc/cmd_out[45]} {m/c/sdcram_0/sdi/sdc/cmd_out[46]} {m/c/sdcram_0/sdi/sdc/cmd_out[47]} {m/c/sdcram_0/sdi/sdc/cmd_out[48]} {m/c/sdcram_0/sdi/sdc/cmd_out[49]} {m/c/sdcram_0/sdi/sdc/cmd_out[50]} {m/c/sdcram_0/sdi/sdc/cmd_out[51]} {m/c/sdcram_0/sdi/sdc/cmd_out[52]} {m/c/sdcram_0/sdi/sdc/cmd_out[53]} {m/c/sdcram_0/sdi/sdc/cmd_out[54]} {m/c/sdcram_0/sdi/sdc/cmd_out[55]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
set_property port_width 32 [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list {m/c/sdcram_0/sdi/sdc/block_counter[0]} {m/c/sdcram_0/sdi/sdc/block_counter[1]} {m/c/sdcram_0/sdi/sdc/block_counter[2]} {m/c/sdcram_0/sdi/sdc/block_counter[3]} {m/c/sdcram_0/sdi/sdc/block_counter[4]} {m/c/sdcram_0/sdi/sdc/block_counter[5]} {m/c/sdcram_0/sdi/sdc/block_counter[6]} {m/c/sdcram_0/sdi/sdc/block_counter[7]} {m/c/sdcram_0/sdi/sdc/block_counter[8]} {m/c/sdcram_0/sdi/sdc/block_counter[9]} {m/c/sdcram_0/sdi/sdc/block_counter[10]} {m/c/sdcram_0/sdi/sdc/block_counter[11]} {m/c/sdcram_0/sdi/sdc/block_counter[12]} {m/c/sdcram_0/sdi/sdc/block_counter[13]} {m/c/sdcram_0/sdi/sdc/block_counter[14]} {m/c/sdcram_0/sdi/sdc/block_counter[15]} {m/c/sdcram_0/sdi/sdc/block_counter[16]} {m/c/sdcram_0/sdi/sdc/block_counter[17]} {m/c/sdcram_0/sdi/sdc/block_counter[18]} {m/c/sdcram_0/sdi/sdc/block_counter[19]} {m/c/sdcram_0/sdi/sdc/block_counter[20]} {m/c/sdcram_0/sdi/sdc/block_counter[21]} {m/c/sdcram_0/sdi/sdc/block_counter[22]} {m/c/sdcram_0/sdi/sdc/block_counter[23]} {m/c/sdcram_0/sdi/sdc/block_counter[24]} {m/c/sdcram_0/sdi/sdc/block_counter[25]} {m/c/sdcram_0/sdi/sdc/block_counter[26]} {m/c/sdcram_0/sdi/sdc/block_counter[27]} {m/c/sdcram_0/sdi/sdc/block_counter[28]} {m/c/sdcram_0/sdi/sdc/block_counter[29]} {m/c/sdcram_0/sdi/sdc/block_counter[30]} {m/c/sdcram_0/sdi/sdc/block_counter[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe18]
set_property port_width 14 [get_debug_ports u_ila_0/probe18]
connect_debug_port u_ila_0/probe18 [get_nets [list {m/c/sdcram_0/sdi/sdc/bit_counter[0]} {m/c/sdcram_0/sdi/sdc/bit_counter[1]} {m/c/sdcram_0/sdi/sdc/bit_counter[2]} {m/c/sdcram_0/sdi/sdc/bit_counter[3]} {m/c/sdcram_0/sdi/sdc/bit_counter[4]} {m/c/sdcram_0/sdi/sdc/bit_counter[5]} {m/c/sdcram_0/sdi/sdc/bit_counter[6]} {m/c/sdcram_0/sdi/sdc/bit_counter[7]} {m/c/sdcram_0/sdi/sdc/bit_counter[8]} {m/c/sdcram_0/sdi/sdc/bit_counter[9]} {m/c/sdcram_0/sdi/sdc/bit_counter[10]} {m/c/sdcram_0/sdi/sdc/bit_counter[11]} {m/c/sdcram_0/sdi/sdc/bit_counter[12]} {m/c/sdcram_0/sdi/sdc/bit_counter[13]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe19]
set_property port_width 12 [get_debug_ports u_ila_0/probe19]
connect_debug_port u_ila_0/probe19 [get_nets [list {m/c/ether/es0/buf_addr[0]} {m/c/ether/es0/buf_addr[1]} {m/c/ether/es0/buf_addr[2]} {m/c/ether/es0/buf_addr[3]} {m/c/ether/es0/buf_addr[4]} {m/c/ether/es0/buf_addr[5]} {m/c/ether/es0/buf_addr[6]} {m/c/ether/es0/buf_addr[7]} {m/c/ether/es0/buf_addr[8]} {m/c/ether/es0/buf_addr[9]} {m/c/ether/es0/buf_addr[10]} {m/c/ether/es0/buf_addr[11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe20]
set_property port_width 1 [get_debug_ports u_ila_0/probe20]
connect_debug_port u_ila_0/probe20 [get_nets [list m/c/sdcram_0/sdi/sdc/byte_available]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe21]
set_property port_width 1 [get_debug_ports u_ila_0/probe21]
connect_debug_port u_ila_0/probe21 [get_nets [list m/c/sdcram_0/sdi/sdc/cmd_mode]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe22]
set_property port_width 1 [get_debug_ports u_ila_0/probe22]
connect_debug_port u_ila_0/probe22 [get_nets [list m/c/sdcram_0/sdi/sdc/cs]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe23]
set_property port_width 1 [get_debug_ports u_ila_0/probe23]
connect_debug_port u_ila_0/probe23 [get_nets [list m/c/ether/er0/done]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe24]
set_property port_width 1 [get_debug_ports u_ila_0/probe24]
connect_debug_port u_ila_0/probe24 [get_nets [list m/c/ether/er0/dv]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe25]
set_property port_width 1 [get_debug_ports u_ila_0/probe25]
connect_debug_port u_ila_0/probe25 [get_nets [list m/c/sdcram_0/sdi/sdc/miso]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe26]
set_property port_width 1 [get_debug_ports u_ila_0/probe26]
connect_debug_port u_ila_0/probe26 [get_nets [list m/c/sdcram_0/sdi/sdc/mosi]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe27]
set_property port_width 1 [get_debug_ports u_ila_0/probe27]
connect_debug_port u_ila_0/probe27 [get_nets [list m/c/ether/es0/p_1_in]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe28]
set_property port_width 1 [get_debug_ports u_ila_0/probe28]
connect_debug_port u_ila_0/probe28 [get_nets [list m/c/ether/er0/p_1_in]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe29]
set_property port_width 1 [get_debug_ports u_ila_0/probe29]
connect_debug_port u_ila_0/probe29 [get_nets [list m/c/ether/es0/ready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe30]
set_property port_width 1 [get_debug_ports u_ila_0/probe30]
connect_debug_port u_ila_0/probe30 [get_nets [list m/c/sdcram_0/sdi/sdc/ready_for_next_byte]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe31]
set_property port_width 1 [get_debug_ports u_ila_0/probe31]
connect_debug_port u_ila_0/probe31 [get_nets [list m/c/ether/recv_buf_we]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe32]
set_property port_width 1 [get_debug_ports u_ila_0/probe32]
connect_debug_port u_ila_0/probe32 [get_nets [list m/c/sdcram_0/sdi/sdc/sclk]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe33]
set_property port_width 1 [get_debug_ports u_ila_0/probe33]
connect_debug_port u_ila_0/probe33 [get_nets [list m/c/sdcram_0/sdi/sdc/sclk_sig]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe34]
set_property port_width 1 [get_debug_ports u_ila_0/probe34]
connect_debug_port u_ila_0/probe34 [get_nets [list m/c/ether/es0/txen_mac]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe35]
set_property port_width 1 [get_debug_ports u_ila_0/probe35]
connect_debug_port u_ila_0/probe35 [get_nets [list m/c/ether/es0/txen_phy]]
create_debug_core u_ila_1 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_1]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_1]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_1]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_1]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_1]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_1]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_1]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_1]
set_property port_width 1 [get_debug_ports u_ila_1/clk]
connect_debug_port u_ila_1/clk [get_nets [list clkgen1/inst/clk_out1]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe0]
set_property port_width 2 [get_debug_ports u_ila_1/probe0]
connect_debug_port u_ila_1/probe0 [get_nets [list {m/c/sp/r_state[0]} {m/c/sp/r_state[1]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe1]
set_property port_width 2 [get_debug_ports u_ila_1/probe1]
connect_debug_port u_ila_1/probe1 [get_nets [list {m/c/dram_con/dram/dram/dram_con_without_cache/state[0]} {m/c/dram_con/dram/dram/dram_con_without_cache/state[1]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe2]
set_property port_width 32 [get_debug_ports u_ila_1/probe2]
connect_debug_port u_ila_1/probe2 [get_nets [list {m/c/sp/r_data[0]} {m/c/sp/r_data[1]} {m/c/sp/r_data[2]} {m/c/sp/r_data[3]} {m/c/sp/r_data[4]} {m/c/sp/r_data[5]} {m/c/sp/r_data[6]} {m/c/sp/r_data[7]} {m/c/sp/r_data[8]} {m/c/sp/r_data[9]} {m/c/sp/r_data[10]} {m/c/sp/r_data[11]} {m/c/sp/r_data[12]} {m/c/sp/r_data[13]} {m/c/sp/r_data[14]} {m/c/sp/r_data[15]} {m/c/sp/r_data[16]} {m/c/sp/r_data[17]} {m/c/sp/r_data[18]} {m/c/sp/r_data[19]} {m/c/sp/r_data[20]} {m/c/sp/r_data[21]} {m/c/sp/r_data[22]} {m/c/sp/r_data[23]} {m/c/sp/r_data[24]} {m/c/sp/r_data[25]} {m/c/sp/r_data[26]} {m/c/sp/r_data[27]} {m/c/sp/r_data[28]} {m/c/sp/r_data[29]} {m/c/sp/r_data[30]} {m/c/sp/r_data[31]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe3]
set_property port_width 32 [get_debug_ports u_ila_1/probe3]
connect_debug_port u_ila_1/probe3 [get_nets [list {m/c/sp/r_addr[0]} {m/c/sp/r_addr[1]} {m/c/sp/r_addr[2]} {m/c/sp/r_addr[3]} {m/c/sp/r_addr[4]} {m/c/sp/r_addr[5]} {m/c/sp/r_addr[6]} {m/c/sp/r_addr[7]} {m/c/sp/r_addr[8]} {m/c/sp/r_addr[9]} {m/c/sp/r_addr[10]} {m/c/sp/r_addr[11]} {m/c/sp/r_addr[12]} {m/c/sp/r_addr[13]} {m/c/sp/r_addr[14]} {m/c/sp/r_addr[15]} {m/c/sp/r_addr[16]} {m/c/sp/r_addr[17]} {m/c/sp/r_addr[18]} {m/c/sp/r_addr[19]} {m/c/sp/r_addr[20]} {m/c/sp/r_addr[21]} {m/c/sp/r_addr[22]} {m/c/sp/r_addr[23]} {m/c/sp/r_addr[24]} {m/c/sp/r_addr[25]} {m/c/sp/r_addr[26]} {m/c/sp/r_addr[27]} {m/c/sp/r_addr[28]} {m/c/sp/r_addr[29]} {m/c/sp/r_addr[30]} {m/c/sp/r_addr[31]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe4]
set_property port_width 8 [get_debug_ports u_ila_1/probe4]
connect_debug_port u_ila_1/probe4 [get_nets [list {m/c/ether/recv_buf_rdata[0]} {m/c/ether/recv_buf_rdata[1]} {m/c/ether/recv_buf_rdata[2]} {m/c/ether/recv_buf_rdata[3]} {m/c/ether/recv_buf_rdata[4]} {m/c/ether/recv_buf_rdata[5]} {m/c/ether/recv_buf_rdata[6]} {m/c/ether/recv_buf_rdata[7]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe5]
set_property port_width 3 [get_debug_ports u_ila_1/probe5]
connect_debug_port u_ila_1/probe5 [get_nets [list {m/c/r_init_state[0]} {m/c/r_init_state[1]} {m/c/r_init_state[2]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe6]
set_property port_width 32 [get_debug_ports u_ila_1/probe6]
connect_debug_port u_ila_1/probe6 [get_nets [list {m/c/r_initaddr[0]} {m/c/r_initaddr[1]} {m/c/r_initaddr[2]} {m/c/r_initaddr[3]} {m/c/r_initaddr[4]} {m/c/r_initaddr[5]} {m/c/r_initaddr[6]} {m/c/r_initaddr[7]} {m/c/r_initaddr[8]} {m/c/r_initaddr[9]} {m/c/r_initaddr[10]} {m/c/r_initaddr[11]} {m/c/r_initaddr[12]} {m/c/r_initaddr[13]} {m/c/r_initaddr[14]} {m/c/r_initaddr[15]} {m/c/r_initaddr[16]} {m/c/r_initaddr[17]} {m/c/r_initaddr[18]} {m/c/r_initaddr[19]} {m/c/r_initaddr[20]} {m/c/r_initaddr[21]} {m/c/r_initaddr[22]} {m/c/r_initaddr[23]} {m/c/r_initaddr[24]} {m/c/r_initaddr[25]} {m/c/r_initaddr[26]} {m/c/r_initaddr[27]} {m/c/r_initaddr[28]} {m/c/r_initaddr[29]} {m/c/r_initaddr[30]} {m/c/r_initaddr[31]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe7]
set_property port_width 32 [get_debug_ports u_ila_1/probe7]
connect_debug_port u_ila_1/probe7 [get_nets [list {m/c/r_initaddr3[0]} {m/c/r_initaddr3[1]} {m/c/r_initaddr3[2]} {m/c/r_initaddr3[3]} {m/c/r_initaddr3[4]} {m/c/r_initaddr3[5]} {m/c/r_initaddr3[6]} {m/c/r_initaddr3[7]} {m/c/r_initaddr3[8]} {m/c/r_initaddr3[9]} {m/c/r_initaddr3[10]} {m/c/r_initaddr3[11]} {m/c/r_initaddr3[12]} {m/c/r_initaddr3[13]} {m/c/r_initaddr3[14]} {m/c/r_initaddr3[15]} {m/c/r_initaddr3[16]} {m/c/r_initaddr3[17]} {m/c/r_initaddr3[18]} {m/c/r_initaddr3[19]} {m/c/r_initaddr3[20]} {m/c/r_initaddr3[21]} {m/c/r_initaddr3[22]} {m/c/r_initaddr3[23]} {m/c/r_initaddr3[24]} {m/c/r_initaddr3[25]} {m/c/r_initaddr3[26]} {m/c/r_initaddr3[27]} {m/c/r_initaddr3[28]} {m/c/r_initaddr3[29]} {m/c/r_initaddr3[30]} {m/c/r_initaddr3[31]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe8]
set_property port_width 32 [get_debug_ports u_ila_1/probe8]
connect_debug_port u_ila_1/probe8 [get_nets [list {m/c/loader_addr[0]} {m/c/loader_addr[1]} {m/c/loader_addr[2]} {m/c/loader_addr[3]} {m/c/loader_addr[4]} {m/c/loader_addr[5]} {m/c/loader_addr[6]} {m/c/loader_addr[7]} {m/c/loader_addr[8]} {m/c/loader_addr[9]} {m/c/loader_addr[10]} {m/c/loader_addr[11]} {m/c/loader_addr[12]} {m/c/loader_addr[13]} {m/c/loader_addr[14]} {m/c/loader_addr[15]} {m/c/loader_addr[16]} {m/c/loader_addr[17]} {m/c/loader_addr[18]} {m/c/loader_addr[19]} {m/c/loader_addr[20]} {m/c/loader_addr[21]} {m/c/loader_addr[22]} {m/c/loader_addr[23]} {m/c/loader_addr[24]} {m/c/loader_addr[25]} {m/c/loader_addr[26]} {m/c/loader_addr[27]} {m/c/loader_addr[28]} {m/c/loader_addr[29]} {m/c/loader_addr[30]} {m/c/loader_addr[31]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe9]
set_property port_width 32 [get_debug_ports u_ila_1/probe9]
connect_debug_port u_ila_1/probe9 [get_nets [list {m/c/loader_data[0]} {m/c/loader_data[1]} {m/c/loader_data[2]} {m/c/loader_data[3]} {m/c/loader_data[4]} {m/c/loader_data[5]} {m/c/loader_data[6]} {m/c/loader_data[7]} {m/c/loader_data[8]} {m/c/loader_data[9]} {m/c/loader_data[10]} {m/c/loader_data[11]} {m/c/loader_data[12]} {m/c/loader_data[13]} {m/c/loader_data[14]} {m/c/loader_data[15]} {m/c/loader_data[16]} {m/c/loader_data[17]} {m/c/loader_data[18]} {m/c/loader_data[19]} {m/c/loader_data[20]} {m/c/loader_data[21]} {m/c/loader_data[22]} {m/c/loader_data[23]} {m/c/loader_data[24]} {m/c/loader_data[25]} {m/c/loader_data[26]} {m/c/loader_data[27]} {m/c/loader_data[28]} {m/c/loader_data[29]} {m/c/loader_data[30]} {m/c/loader_data[31]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe10]
set_property port_width 3 [get_debug_ports u_ila_1/probe10]
connect_debug_port u_ila_1/probe10 [get_nets [list {m/c/sdcon/r_state_0[0]} {m/c/sdcon/r_state_0[1]} {m/c/sdcon/r_state_0[2]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe11]
set_property port_width 64 [get_debug_ports u_ila_1/probe11]
connect_debug_port u_ila_1/probe11 [get_nets [list {m/r_core_cnt[0]} {m/r_core_cnt[1]} {m/r_core_cnt[2]} {m/r_core_cnt[3]} {m/r_core_cnt[4]} {m/r_core_cnt[5]} {m/r_core_cnt[6]} {m/r_core_cnt[7]} {m/r_core_cnt[8]} {m/r_core_cnt[9]} {m/r_core_cnt[10]} {m/r_core_cnt[11]} {m/r_core_cnt[12]} {m/r_core_cnt[13]} {m/r_core_cnt[14]} {m/r_core_cnt[15]} {m/r_core_cnt[16]} {m/r_core_cnt[17]} {m/r_core_cnt[18]} {m/r_core_cnt[19]} {m/r_core_cnt[20]} {m/r_core_cnt[21]} {m/r_core_cnt[22]} {m/r_core_cnt[23]} {m/r_core_cnt[24]} {m/r_core_cnt[25]} {m/r_core_cnt[26]} {m/r_core_cnt[27]} {m/r_core_cnt[28]} {m/r_core_cnt[29]} {m/r_core_cnt[30]} {m/r_core_cnt[31]} {m/r_core_cnt[32]} {m/r_core_cnt[33]} {m/r_core_cnt[34]} {m/r_core_cnt[35]} {m/r_core_cnt[36]} {m/r_core_cnt[37]} {m/r_core_cnt[38]} {m/r_core_cnt[39]} {m/r_core_cnt[40]} {m/r_core_cnt[41]} {m/r_core_cnt[42]} {m/r_core_cnt[43]} {m/r_core_cnt[44]} {m/r_core_cnt[45]} {m/r_core_cnt[46]} {m/r_core_cnt[47]} {m/r_core_cnt[48]} {m/r_core_cnt[49]} {m/r_core_cnt[50]} {m/r_core_cnt[51]} {m/r_core_cnt[52]} {m/r_core_cnt[53]} {m/r_core_cnt[54]} {m/r_core_cnt[55]} {m/r_core_cnt[56]} {m/r_core_cnt[57]} {m/r_core_cnt[58]} {m/r_core_cnt[59]} {m/r_core_cnt[60]} {m/r_core_cnt[61]} {m/r_core_cnt[62]} {m/r_core_cnt[63]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe12]
set_property port_width 12 [get_debug_ports u_ila_1/probe12]
connect_debug_port u_ila_1/probe12 [get_nets [list {m/c/ether/es0/buf_len[0]} {m/c/ether/es0/buf_len[1]} {m/c/ether/es0/buf_len[2]} {m/c/ether/es0/buf_len[3]} {m/c/ether/es0/buf_len[4]} {m/c/ether/es0/buf_len[5]} {m/c/ether/es0/buf_len[6]} {m/c/ether/es0/buf_len[7]} {m/c/ether/es0/buf_len[8]} {m/c/ether/es0/buf_len[9]} {m/c/ether/es0/buf_len[10]} {m/c/ether/es0/buf_len[11]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe13]
set_property port_width 1 [get_debug_ports u_ila_1/probe13]
connect_debug_port u_ila_1/probe13 [get_nets [list calib_done]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe14]
set_property port_width 1 [get_debug_ports u_ila_1/probe14]
connect_debug_port u_ila_1/probe14 [get_nets [list m/c/loader_done]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe15]
set_property port_width 1 [get_debug_ports u_ila_1/probe15]
connect_debug_port u_ila_1/probe15 [get_nets [list m/c/loader_we]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe16]
set_property port_width 1 [get_debug_ports u_ila_1/probe16]
connect_debug_port u_ila_1/probe16 [get_nets [list m/c/r_bbl_done]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe17]
set_property port_width 1 [get_debug_ports u_ila_1/probe17]
connect_debug_port u_ila_1/probe17 [get_nets [list m/c/sp/r_done]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe18]
set_property port_width 1 [get_debug_ports u_ila_1/probe18]
connect_debug_port u_ila_1/probe18 [get_nets [list m/c/r_dtree_done]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe19]
set_property port_width 1 [get_debug_ports u_ila_1/probe19]
connect_debug_port u_ila_1/probe19 [get_nets [list m/c/sp/r_sd_ren]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe20]
set_property port_width 1 [get_debug_ports u_ila_1/probe20]
connect_debug_port u_ila_1/probe20 [get_nets [list m/r_stop]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe21]
set_property port_width 1 [get_debug_ports u_ila_1/probe21]
connect_debug_port u_ila_1/probe21 [get_nets [list m/c/sp/r_we]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe22]
set_property port_width 1 [get_debug_ports u_ila_1/probe22]
connect_debug_port u_ila_1/probe22 [get_nets [list m/w_finish]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe23]
set_property port_width 1 [get_debug_ports u_ila_1/probe23]
connect_debug_port u_ila_1/probe23 [get_nets [list m/w_init_done]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe24]
set_property port_width 1 [get_debug_ports u_ila_1/probe24]
connect_debug_port u_ila_1/probe24 [get_nets [list m/w_init_stage]]
create_debug_core u_ila_2 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_2]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_2]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_2]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_2]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_2]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_2]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_2]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_2]
set_property port_width 1 [get_debug_ports u_ila_2/clk]
connect_debug_port u_ila_2/clk [get_nets [list u_mig_7series_0/u_mig_7series_0_mig/u_ddr3_infrastructure/u_bufg_clkdiv0_0]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe0]
set_property port_width 3 [get_debug_ports u_ila_2/probe0]
connect_debug_port u_ila_2/probe0 [get_nets [list {m/c/dram_con/dram/dram/dram_con_without_cache/dc/state[0]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/state[1]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/state[2]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe1]
set_property port_width 16 [get_debug_ports u_ila_2/probe1]
connect_debug_port u_ila_2/probe1 [get_nets [list {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[0]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[1]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[2]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[3]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[4]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[5]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[6]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[7]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[8]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[9]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[10]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[11]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[12]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[13]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[14]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_mask[15]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe2]
set_property port_width 23 [get_debug_ports u_ila_2/probe2]
connect_debug_port u_ila_2/probe2 [get_nets [list {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[3]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[4]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[5]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[6]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[7]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[8]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[9]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[10]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[11]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[12]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[13]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[14]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[15]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[16]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[17]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[18]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[19]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[20]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[21]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[22]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[23]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[24]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_addr[25]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe3]
set_property port_width 32 [get_debug_ports u_ila_2/probe3]
connect_debug_port u_ila_2/probe3 [get_nets [list {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[96]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[97]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[98]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[99]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[100]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[101]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[102]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[103]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[104]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[105]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[106]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[107]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[108]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[109]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[110]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[111]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[112]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[113]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[114]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[115]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[116]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[117]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[118]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[119]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[120]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[121]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[122]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[123]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[124]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[125]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[126]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_data[127]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe4]
set_property port_width 128 [get_debug_ports u_ila_2/probe4]
connect_debug_port u_ila_2/probe4 [get_nets [list {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[0]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[1]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[2]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[3]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[4]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[5]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[6]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[7]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[8]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[9]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[10]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[11]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[12]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[13]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[14]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[15]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[16]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[17]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[18]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[19]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[20]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[21]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[22]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[23]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[24]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[25]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[26]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[27]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[28]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[29]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[30]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[31]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[32]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[33]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[34]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[35]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[36]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[37]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[38]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[39]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[40]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[41]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[42]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[43]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[44]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[45]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[46]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[47]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[48]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[49]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[50]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[51]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[52]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[53]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[54]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[55]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[56]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[57]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[58]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[59]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[60]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[61]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[62]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[63]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[64]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[65]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[66]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[67]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[68]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[69]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[70]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[71]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[72]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[73]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[74]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[75]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[76]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[77]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[78]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[79]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[80]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[81]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[82]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[83]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[84]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[85]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[86]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[87]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[88]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[89]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[90]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[91]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[92]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[93]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[94]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[95]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[96]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[97]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[98]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[99]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[100]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[101]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[102]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[103]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[104]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[105]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[106]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[107]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[108]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[109]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[110]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[111]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[112]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[113]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[114]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[115]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[116]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[117]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[118]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[119]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[120]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[121]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[122]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[123]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[124]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[125]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[126]} {m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data[127]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe5]
set_property port_width 2 [get_debug_ports u_ila_2/probe5]
connect_debug_port u_ila_2/probe5 [get_nets [list {s_axi_awburst[0]} {s_axi_awburst[1]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe6]
set_property port_width 3 [get_debug_ports u_ila_2/probe6]
connect_debug_port u_ila_2/probe6 [get_nets [list {s_axi_arsize[0]} {s_axi_arsize[1]} {s_axi_arsize[2]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe7]
set_property port_width 8 [get_debug_ports u_ila_2/probe7]
connect_debug_port u_ila_2/probe7 [get_nets [list {s_axi_arlen[0]} {s_axi_arlen[1]} {s_axi_arlen[2]} {s_axi_arlen[3]} {s_axi_arlen[4]} {s_axi_arlen[5]} {s_axi_arlen[6]} {s_axi_arlen[7]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe8]
set_property port_width 3 [get_debug_ports u_ila_2/probe8]
connect_debug_port u_ila_2/probe8 [get_nets [list {s_axi_arprot[0]} {s_axi_arprot[1]} {s_axi_arprot[2]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe9]
set_property port_width 4 [get_debug_ports u_ila_2/probe9]
connect_debug_port u_ila_2/probe9 [get_nets [list {s_axi_arqos[0]} {s_axi_arqos[1]} {s_axi_arqos[2]} {s_axi_arqos[3]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe10]
set_property port_width 28 [get_debug_ports u_ila_2/probe10]
connect_debug_port u_ila_2/probe10 [get_nets [list {s_axi_awaddr[0]} {s_axi_awaddr[1]} {s_axi_awaddr[2]} {s_axi_awaddr[3]} {s_axi_awaddr[4]} {s_axi_awaddr[5]} {s_axi_awaddr[6]} {s_axi_awaddr[7]} {s_axi_awaddr[8]} {s_axi_awaddr[9]} {s_axi_awaddr[10]} {s_axi_awaddr[11]} {s_axi_awaddr[12]} {s_axi_awaddr[13]} {s_axi_awaddr[14]} {s_axi_awaddr[15]} {s_axi_awaddr[16]} {s_axi_awaddr[17]} {s_axi_awaddr[18]} {s_axi_awaddr[19]} {s_axi_awaddr[20]} {s_axi_awaddr[21]} {s_axi_awaddr[22]} {s_axi_awaddr[23]} {s_axi_awaddr[24]} {s_axi_awaddr[25]} {s_axi_awaddr[26]} {s_axi_awaddr[27]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe11]
set_property port_width 4 [get_debug_ports u_ila_2/probe11]
connect_debug_port u_ila_2/probe11 [get_nets [list {s_axi_arcache[0]} {s_axi_arcache[1]} {s_axi_arcache[2]} {s_axi_arcache[3]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe12]
set_property port_width 28 [get_debug_ports u_ila_2/probe12]
connect_debug_port u_ila_2/probe12 [get_nets [list {s_axi_araddr[0]} {s_axi_araddr[1]} {s_axi_araddr[2]} {s_axi_araddr[3]} {s_axi_araddr[4]} {s_axi_araddr[5]} {s_axi_araddr[6]} {s_axi_araddr[7]} {s_axi_araddr[8]} {s_axi_araddr[9]} {s_axi_araddr[10]} {s_axi_araddr[11]} {s_axi_araddr[12]} {s_axi_araddr[13]} {s_axi_araddr[14]} {s_axi_araddr[15]} {s_axi_araddr[16]} {s_axi_araddr[17]} {s_axi_araddr[18]} {s_axi_araddr[19]} {s_axi_araddr[20]} {s_axi_araddr[21]} {s_axi_araddr[22]} {s_axi_araddr[23]} {s_axi_araddr[24]} {s_axi_araddr[25]} {s_axi_araddr[26]} {s_axi_araddr[27]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe13]
set_property port_width 2 [get_debug_ports u_ila_2/probe13]
connect_debug_port u_ila_2/probe13 [get_nets [list {s_axi_arburst[0]} {s_axi_arburst[1]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe14]
set_property port_width 3 [get_debug_ports u_ila_2/probe14]
connect_debug_port u_ila_2/probe14 [get_nets [list {s_axi_awprot[0]} {s_axi_awprot[1]} {s_axi_awprot[2]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe15]
set_property port_width 8 [get_debug_ports u_ila_2/probe15]
connect_debug_port u_ila_2/probe15 [get_nets [list {s_axi_awlen[0]} {s_axi_awlen[1]} {s_axi_awlen[2]} {s_axi_awlen[3]} {s_axi_awlen[4]} {s_axi_awlen[5]} {s_axi_awlen[6]} {s_axi_awlen[7]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe16]
set_property port_width 4 [get_debug_ports u_ila_2/probe16]
connect_debug_port u_ila_2/probe16 [get_nets [list {s_axi_awcache[0]} {s_axi_awcache[1]} {s_axi_awcache[2]} {s_axi_awcache[3]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe17]
set_property port_width 4 [get_debug_ports u_ila_2/probe17]
connect_debug_port u_ila_2/probe17 [get_nets [list {s_conv_axi_wstrb[0]} {s_conv_axi_wstrb[1]} {s_conv_axi_wstrb[2]} {s_conv_axi_wstrb[3]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe18]
set_property port_width 32 [get_debug_ports u_ila_2/probe18]
connect_debug_port u_ila_2/probe18 [get_nets [list {s_conv_axi_wdata[0]} {s_conv_axi_wdata[1]} {s_conv_axi_wdata[2]} {s_conv_axi_wdata[3]} {s_conv_axi_wdata[4]} {s_conv_axi_wdata[5]} {s_conv_axi_wdata[6]} {s_conv_axi_wdata[7]} {s_conv_axi_wdata[8]} {s_conv_axi_wdata[9]} {s_conv_axi_wdata[10]} {s_conv_axi_wdata[11]} {s_conv_axi_wdata[12]} {s_conv_axi_wdata[13]} {s_conv_axi_wdata[14]} {s_conv_axi_wdata[15]} {s_conv_axi_wdata[16]} {s_conv_axi_wdata[17]} {s_conv_axi_wdata[18]} {s_conv_axi_wdata[19]} {s_conv_axi_wdata[20]} {s_conv_axi_wdata[21]} {s_conv_axi_wdata[22]} {s_conv_axi_wdata[23]} {s_conv_axi_wdata[24]} {s_conv_axi_wdata[25]} {s_conv_axi_wdata[26]} {s_conv_axi_wdata[27]} {s_conv_axi_wdata[28]} {s_conv_axi_wdata[29]} {s_conv_axi_wdata[30]} {s_conv_axi_wdata[31]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe19]
set_property port_width 4 [get_debug_ports u_ila_2/probe19]
connect_debug_port u_ila_2/probe19 [get_nets [list {s_conv_axi_rid[0]} {s_conv_axi_rid[1]} {s_conv_axi_rid[2]} {s_conv_axi_rid[3]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe20]
set_property port_width 32 [get_debug_ports u_ila_2/probe20]
connect_debug_port u_ila_2/probe20 [get_nets [list {s_conv_axi_rdata[0]} {s_conv_axi_rdata[1]} {s_conv_axi_rdata[2]} {s_conv_axi_rdata[3]} {s_conv_axi_rdata[4]} {s_conv_axi_rdata[5]} {s_conv_axi_rdata[6]} {s_conv_axi_rdata[7]} {s_conv_axi_rdata[8]} {s_conv_axi_rdata[9]} {s_conv_axi_rdata[10]} {s_conv_axi_rdata[11]} {s_conv_axi_rdata[12]} {s_conv_axi_rdata[13]} {s_conv_axi_rdata[14]} {s_conv_axi_rdata[15]} {s_conv_axi_rdata[16]} {s_conv_axi_rdata[17]} {s_conv_axi_rdata[18]} {s_conv_axi_rdata[19]} {s_conv_axi_rdata[20]} {s_conv_axi_rdata[21]} {s_conv_axi_rdata[22]} {s_conv_axi_rdata[23]} {s_conv_axi_rdata[24]} {s_conv_axi_rdata[25]} {s_conv_axi_rdata[26]} {s_conv_axi_rdata[27]} {s_conv_axi_rdata[28]} {s_conv_axi_rdata[29]} {s_conv_axi_rdata[30]} {s_conv_axi_rdata[31]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe21]
set_property port_width 3 [get_debug_ports u_ila_2/probe21]
connect_debug_port u_ila_2/probe21 [get_nets [list {s_conv_axi_awsize[0]} {s_conv_axi_awsize[1]} {s_conv_axi_awsize[2]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe22]
set_property port_width 4 [get_debug_ports u_ila_2/probe22]
connect_debug_port u_ila_2/probe22 [get_nets [list {s_conv_axi_bid[0]} {s_conv_axi_bid[1]} {s_conv_axi_bid[2]} {s_conv_axi_bid[3]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe23]
set_property port_width 4 [get_debug_ports u_ila_2/probe23]
connect_debug_port u_ila_2/probe23 [get_nets [list {s_conv_axi_awcache[0]} {s_conv_axi_awcache[1]} {s_conv_axi_awcache[2]} {s_conv_axi_awcache[3]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe24]
set_property port_width 3 [get_debug_ports u_ila_2/probe24]
connect_debug_port u_ila_2/probe24 [get_nets [list {s_conv_axi_awprot[0]} {s_conv_axi_awprot[1]} {s_conv_axi_awprot[2]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe25]
set_property port_width 8 [get_debug_ports u_ila_2/probe25]
connect_debug_port u_ila_2/probe25 [get_nets [list {s_conv_axi_awlen[0]} {s_conv_axi_awlen[1]} {s_conv_axi_awlen[2]} {s_conv_axi_awlen[3]} {s_conv_axi_awlen[4]} {s_conv_axi_awlen[5]} {s_conv_axi_awlen[6]} {s_conv_axi_awlen[7]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe26]
set_property port_width 2 [get_debug_ports u_ila_2/probe26]
connect_debug_port u_ila_2/probe26 [get_nets [list {s_conv_axi_awburst[0]} {s_conv_axi_awburst[1]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe27]
set_property port_width 4 [get_debug_ports u_ila_2/probe27]
connect_debug_port u_ila_2/probe27 [get_nets [list {s_conv_axi_awqos[0]} {s_conv_axi_awqos[1]} {s_conv_axi_awqos[2]} {s_conv_axi_awqos[3]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe28]
set_property port_width 4 [get_debug_ports u_ila_2/probe28]
connect_debug_port u_ila_2/probe28 [get_nets [list {s_conv_axi_awid[0]} {s_conv_axi_awid[1]} {s_conv_axi_awid[2]} {s_conv_axi_awid[3]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe29]
set_property port_width 8 [get_debug_ports u_ila_2/probe29]
connect_debug_port u_ila_2/probe29 [get_nets [list {s_conv_axi_arlen[0]} {s_conv_axi_arlen[1]} {s_conv_axi_arlen[2]} {s_conv_axi_arlen[3]} {s_conv_axi_arlen[4]} {s_conv_axi_arlen[5]} {s_conv_axi_arlen[6]} {s_conv_axi_arlen[7]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe30]
set_property port_width 3 [get_debug_ports u_ila_2/probe30]
connect_debug_port u_ila_2/probe30 [get_nets [list {s_conv_axi_arsize[0]} {s_conv_axi_arsize[1]} {s_conv_axi_arsize[2]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe31]
set_property port_width 4 [get_debug_ports u_ila_2/probe31]
connect_debug_port u_ila_2/probe31 [get_nets [list {s_conv_axi_arqos[0]} {s_conv_axi_arqos[1]} {s_conv_axi_arqos[2]} {s_conv_axi_arqos[3]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe32]
set_property port_width 4 [get_debug_ports u_ila_2/probe32]
connect_debug_port u_ila_2/probe32 [get_nets [list {s_conv_axi_arid[0]} {s_conv_axi_arid[1]} {s_conv_axi_arid[2]} {s_conv_axi_arid[3]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe33]
set_property port_width 32 [get_debug_ports u_ila_2/probe33]
connect_debug_port u_ila_2/probe33 [get_nets [list {s_conv_axi_awaddr[0]} {s_conv_axi_awaddr[1]} {s_conv_axi_awaddr[2]} {s_conv_axi_awaddr[3]} {s_conv_axi_awaddr[4]} {s_conv_axi_awaddr[5]} {s_conv_axi_awaddr[6]} {s_conv_axi_awaddr[7]} {s_conv_axi_awaddr[8]} {s_conv_axi_awaddr[9]} {s_conv_axi_awaddr[10]} {s_conv_axi_awaddr[11]} {s_conv_axi_awaddr[12]} {s_conv_axi_awaddr[13]} {s_conv_axi_awaddr[14]} {s_conv_axi_awaddr[15]} {s_conv_axi_awaddr[16]} {s_conv_axi_awaddr[17]} {s_conv_axi_awaddr[18]} {s_conv_axi_awaddr[19]} {s_conv_axi_awaddr[20]} {s_conv_axi_awaddr[21]} {s_conv_axi_awaddr[22]} {s_conv_axi_awaddr[23]} {s_conv_axi_awaddr[24]} {s_conv_axi_awaddr[25]} {s_conv_axi_awaddr[26]} {s_conv_axi_awaddr[27]} {s_conv_axi_awaddr[28]} {s_conv_axi_awaddr[29]} {s_conv_axi_awaddr[30]} {s_conv_axi_awaddr[31]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe34]
set_property port_width 3 [get_debug_ports u_ila_2/probe34]
connect_debug_port u_ila_2/probe34 [get_nets [list {s_conv_axi_arprot[0]} {s_conv_axi_arprot[1]} {s_conv_axi_arprot[2]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe35]
set_property port_width 128 [get_debug_ports u_ila_2/probe35]
connect_debug_port u_ila_2/probe35 [get_nets [list {s_axi_wdata[0]} {s_axi_wdata[1]} {s_axi_wdata[2]} {s_axi_wdata[3]} {s_axi_wdata[4]} {s_axi_wdata[5]} {s_axi_wdata[6]} {s_axi_wdata[7]} {s_axi_wdata[8]} {s_axi_wdata[9]} {s_axi_wdata[10]} {s_axi_wdata[11]} {s_axi_wdata[12]} {s_axi_wdata[13]} {s_axi_wdata[14]} {s_axi_wdata[15]} {s_axi_wdata[16]} {s_axi_wdata[17]} {s_axi_wdata[18]} {s_axi_wdata[19]} {s_axi_wdata[20]} {s_axi_wdata[21]} {s_axi_wdata[22]} {s_axi_wdata[23]} {s_axi_wdata[24]} {s_axi_wdata[25]} {s_axi_wdata[26]} {s_axi_wdata[27]} {s_axi_wdata[28]} {s_axi_wdata[29]} {s_axi_wdata[30]} {s_axi_wdata[31]} {s_axi_wdata[32]} {s_axi_wdata[33]} {s_axi_wdata[34]} {s_axi_wdata[35]} {s_axi_wdata[36]} {s_axi_wdata[37]} {s_axi_wdata[38]} {s_axi_wdata[39]} {s_axi_wdata[40]} {s_axi_wdata[41]} {s_axi_wdata[42]} {s_axi_wdata[43]} {s_axi_wdata[44]} {s_axi_wdata[45]} {s_axi_wdata[46]} {s_axi_wdata[47]} {s_axi_wdata[48]} {s_axi_wdata[49]} {s_axi_wdata[50]} {s_axi_wdata[51]} {s_axi_wdata[52]} {s_axi_wdata[53]} {s_axi_wdata[54]} {s_axi_wdata[55]} {s_axi_wdata[56]} {s_axi_wdata[57]} {s_axi_wdata[58]} {s_axi_wdata[59]} {s_axi_wdata[60]} {s_axi_wdata[61]} {s_axi_wdata[62]} {s_axi_wdata[63]} {s_axi_wdata[64]} {s_axi_wdata[65]} {s_axi_wdata[66]} {s_axi_wdata[67]} {s_axi_wdata[68]} {s_axi_wdata[69]} {s_axi_wdata[70]} {s_axi_wdata[71]} {s_axi_wdata[72]} {s_axi_wdata[73]} {s_axi_wdata[74]} {s_axi_wdata[75]} {s_axi_wdata[76]} {s_axi_wdata[77]} {s_axi_wdata[78]} {s_axi_wdata[79]} {s_axi_wdata[80]} {s_axi_wdata[81]} {s_axi_wdata[82]} {s_axi_wdata[83]} {s_axi_wdata[84]} {s_axi_wdata[85]} {s_axi_wdata[86]} {s_axi_wdata[87]} {s_axi_wdata[88]} {s_axi_wdata[89]} {s_axi_wdata[90]} {s_axi_wdata[91]} {s_axi_wdata[92]} {s_axi_wdata[93]} {s_axi_wdata[94]} {s_axi_wdata[95]} {s_axi_wdata[96]} {s_axi_wdata[97]} {s_axi_wdata[98]} {s_axi_wdata[99]} {s_axi_wdata[100]} {s_axi_wdata[101]} {s_axi_wdata[102]} {s_axi_wdata[103]} {s_axi_wdata[104]} {s_axi_wdata[105]} {s_axi_wdata[106]} {s_axi_wdata[107]} {s_axi_wdata[108]} {s_axi_wdata[109]} {s_axi_wdata[110]} {s_axi_wdata[111]} {s_axi_wdata[112]} {s_axi_wdata[113]} {s_axi_wdata[114]} {s_axi_wdata[115]} {s_axi_wdata[116]} {s_axi_wdata[117]} {s_axi_wdata[118]} {s_axi_wdata[119]} {s_axi_wdata[120]} {s_axi_wdata[121]} {s_axi_wdata[122]} {s_axi_wdata[123]} {s_axi_wdata[124]} {s_axi_wdata[125]} {s_axi_wdata[126]} {s_axi_wdata[127]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe36]
set_property port_width 2 [get_debug_ports u_ila_2/probe36]
connect_debug_port u_ila_2/probe36 [get_nets [list {s_conv_axi_arburst[0]} {s_conv_axi_arburst[1]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe37]
set_property port_width 4 [get_debug_ports u_ila_2/probe37]
connect_debug_port u_ila_2/probe37 [get_nets [list {s_conv_axi_arcache[0]} {s_conv_axi_arcache[1]} {s_conv_axi_arcache[2]} {s_conv_axi_arcache[3]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe38]
set_property port_width 16 [get_debug_ports u_ila_2/probe38]
connect_debug_port u_ila_2/probe38 [get_nets [list {s_axi_wstrb[0]} {s_axi_wstrb[1]} {s_axi_wstrb[2]} {s_axi_wstrb[3]} {s_axi_wstrb[4]} {s_axi_wstrb[5]} {s_axi_wstrb[6]} {s_axi_wstrb[7]} {s_axi_wstrb[8]} {s_axi_wstrb[9]} {s_axi_wstrb[10]} {s_axi_wstrb[11]} {s_axi_wstrb[12]} {s_axi_wstrb[13]} {s_axi_wstrb[14]} {s_axi_wstrb[15]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe39]
set_property port_width 32 [get_debug_ports u_ila_2/probe39]
connect_debug_port u_ila_2/probe39 [get_nets [list {s_conv_axi_araddr[0]} {s_conv_axi_araddr[1]} {s_conv_axi_araddr[2]} {s_conv_axi_araddr[3]} {s_conv_axi_araddr[4]} {s_conv_axi_araddr[5]} {s_conv_axi_araddr[6]} {s_conv_axi_araddr[7]} {s_conv_axi_araddr[8]} {s_conv_axi_araddr[9]} {s_conv_axi_araddr[10]} {s_conv_axi_araddr[11]} {s_conv_axi_araddr[12]} {s_conv_axi_araddr[13]} {s_conv_axi_araddr[14]} {s_conv_axi_araddr[15]} {s_conv_axi_araddr[16]} {s_conv_axi_araddr[17]} {s_conv_axi_araddr[18]} {s_conv_axi_araddr[19]} {s_conv_axi_araddr[20]} {s_conv_axi_araddr[21]} {s_conv_axi_araddr[22]} {s_conv_axi_araddr[23]} {s_conv_axi_araddr[24]} {s_conv_axi_araddr[25]} {s_conv_axi_araddr[26]} {s_conv_axi_araddr[27]} {s_conv_axi_araddr[28]} {s_conv_axi_araddr[29]} {s_conv_axi_araddr[30]} {s_conv_axi_araddr[31]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe40]
set_property port_width 2 [get_debug_ports u_ila_2/probe40]
connect_debug_port u_ila_2/probe40 [get_nets [list {s_axi_rresp[0]} {s_axi_rresp[1]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe41]
set_property port_width 3 [get_debug_ports u_ila_2/probe41]
connect_debug_port u_ila_2/probe41 [get_nets [list {s_axi_awsize[0]} {s_axi_awsize[1]} {s_axi_awsize[2]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe42]
set_property port_width 128 [get_debug_ports u_ila_2/probe42]
connect_debug_port u_ila_2/probe42 [get_nets [list {s_axi_rdata[0]} {s_axi_rdata[1]} {s_axi_rdata[2]} {s_axi_rdata[3]} {s_axi_rdata[4]} {s_axi_rdata[5]} {s_axi_rdata[6]} {s_axi_rdata[7]} {s_axi_rdata[8]} {s_axi_rdata[9]} {s_axi_rdata[10]} {s_axi_rdata[11]} {s_axi_rdata[12]} {s_axi_rdata[13]} {s_axi_rdata[14]} {s_axi_rdata[15]} {s_axi_rdata[16]} {s_axi_rdata[17]} {s_axi_rdata[18]} {s_axi_rdata[19]} {s_axi_rdata[20]} {s_axi_rdata[21]} {s_axi_rdata[22]} {s_axi_rdata[23]} {s_axi_rdata[24]} {s_axi_rdata[25]} {s_axi_rdata[26]} {s_axi_rdata[27]} {s_axi_rdata[28]} {s_axi_rdata[29]} {s_axi_rdata[30]} {s_axi_rdata[31]} {s_axi_rdata[32]} {s_axi_rdata[33]} {s_axi_rdata[34]} {s_axi_rdata[35]} {s_axi_rdata[36]} {s_axi_rdata[37]} {s_axi_rdata[38]} {s_axi_rdata[39]} {s_axi_rdata[40]} {s_axi_rdata[41]} {s_axi_rdata[42]} {s_axi_rdata[43]} {s_axi_rdata[44]} {s_axi_rdata[45]} {s_axi_rdata[46]} {s_axi_rdata[47]} {s_axi_rdata[48]} {s_axi_rdata[49]} {s_axi_rdata[50]} {s_axi_rdata[51]} {s_axi_rdata[52]} {s_axi_rdata[53]} {s_axi_rdata[54]} {s_axi_rdata[55]} {s_axi_rdata[56]} {s_axi_rdata[57]} {s_axi_rdata[58]} {s_axi_rdata[59]} {s_axi_rdata[60]} {s_axi_rdata[61]} {s_axi_rdata[62]} {s_axi_rdata[63]} {s_axi_rdata[64]} {s_axi_rdata[65]} {s_axi_rdata[66]} {s_axi_rdata[67]} {s_axi_rdata[68]} {s_axi_rdata[69]} {s_axi_rdata[70]} {s_axi_rdata[71]} {s_axi_rdata[72]} {s_axi_rdata[73]} {s_axi_rdata[74]} {s_axi_rdata[75]} {s_axi_rdata[76]} {s_axi_rdata[77]} {s_axi_rdata[78]} {s_axi_rdata[79]} {s_axi_rdata[80]} {s_axi_rdata[81]} {s_axi_rdata[82]} {s_axi_rdata[83]} {s_axi_rdata[84]} {s_axi_rdata[85]} {s_axi_rdata[86]} {s_axi_rdata[87]} {s_axi_rdata[88]} {s_axi_rdata[89]} {s_axi_rdata[90]} {s_axi_rdata[91]} {s_axi_rdata[92]} {s_axi_rdata[93]} {s_axi_rdata[94]} {s_axi_rdata[95]} {s_axi_rdata[96]} {s_axi_rdata[97]} {s_axi_rdata[98]} {s_axi_rdata[99]} {s_axi_rdata[100]} {s_axi_rdata[101]} {s_axi_rdata[102]} {s_axi_rdata[103]} {s_axi_rdata[104]} {s_axi_rdata[105]} {s_axi_rdata[106]} {s_axi_rdata[107]} {s_axi_rdata[108]} {s_axi_rdata[109]} {s_axi_rdata[110]} {s_axi_rdata[111]} {s_axi_rdata[112]} {s_axi_rdata[113]} {s_axi_rdata[114]} {s_axi_rdata[115]} {s_axi_rdata[116]} {s_axi_rdata[117]} {s_axi_rdata[118]} {s_axi_rdata[119]} {s_axi_rdata[120]} {s_axi_rdata[121]} {s_axi_rdata[122]} {s_axi_rdata[123]} {s_axi_rdata[124]} {s_axi_rdata[125]} {s_axi_rdata[126]} {s_axi_rdata[127]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe43]
set_property port_width 2 [get_debug_ports u_ila_2/probe43]
connect_debug_port u_ila_2/probe43 [get_nets [list {s_axi_bresp[0]} {s_axi_bresp[1]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe44]
set_property port_width 4 [get_debug_ports u_ila_2/probe44]
connect_debug_port u_ila_2/probe44 [get_nets [list {s_axi_awqos[0]} {s_axi_awqos[1]} {s_axi_awqos[2]} {s_axi_awqos[3]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe45]
set_property port_width 1 [get_debug_ports u_ila_2/probe45]
connect_debug_port u_ila_2/probe45 [get_nets [list dram_init_calib_complete]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe46]
set_property port_width 1 [get_debug_ports u_ila_2/probe46]
connect_debug_port u_ila_2/probe46 [get_nets [list m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_init_calib_complete]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe47]
set_property port_width 1 [get_debug_ports u_ila_2/probe47]
connect_debug_port u_ila_2/probe47 [get_nets [list m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_rd_en]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe48]
set_property port_width 1 [get_debug_ports u_ila_2/probe48]
connect_debug_port u_ila_2/probe48 [get_nets [list m/c/dram_con/dram/dram/dram_con_without_cache/dc/i_wr_en]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe49]
set_property port_width 1 [get_debug_ports u_ila_2/probe49]
connect_debug_port u_ila_2/probe49 [get_nets [list m/c/dram_con/dram/dram/dram_con_without_cache/dc/n_0_1]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe50]
set_property port_width 1 [get_debug_ports u_ila_2/probe50]
connect_debug_port u_ila_2/probe50 [get_nets [list m/c/dram_con/dram/dram/dram_con_without_cache/dc/n_0_2]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe51]
set_property port_width 1 [get_debug_ports u_ila_2/probe51]
connect_debug_port u_ila_2/probe51 [get_nets [list m/c/dram_con/dram/dram/dram_con_without_cache/dc/n_0_3]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe52]
set_property port_width 1 [get_debug_ports u_ila_2/probe52]
connect_debug_port u_ila_2/probe52 [get_nets [list m/c/dram_con/dram/dram/dram_con_without_cache/dc/n_0_4]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe53]
set_property port_width 1 [get_debug_ports u_ila_2/probe53]
connect_debug_port u_ila_2/probe53 [get_nets [list m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_data_valid]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe54]
set_property port_width 1 [get_debug_ports u_ila_2/probe54]
connect_debug_port u_ila_2/probe54 [get_nets [list m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_ready]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe55]
set_property port_width 1 [get_debug_ports u_ila_2/probe55]
connect_debug_port u_ila_2/probe55 [get_nets [list m/c/dram_con/dram/dram/dram_con_without_cache/dc/o_wdf_ready]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe56]
set_property port_width 1 [get_debug_ports u_ila_2/probe56]
connect_debug_port u_ila_2/probe56 [get_nets [list s_axi_arlock]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe57]
set_property port_width 1 [get_debug_ports u_ila_2/probe57]
connect_debug_port u_ila_2/probe57 [get_nets [list s_axi_arready]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe58]
set_property port_width 1 [get_debug_ports u_ila_2/probe58]
connect_debug_port u_ila_2/probe58 [get_nets [list s_axi_arvalid]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe59]
set_property port_width 1 [get_debug_ports u_ila_2/probe59]
connect_debug_port u_ila_2/probe59 [get_nets [list s_axi_awlock]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe60]
set_property port_width 1 [get_debug_ports u_ila_2/probe60]
connect_debug_port u_ila_2/probe60 [get_nets [list s_axi_awready]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe61]
set_property port_width 1 [get_debug_ports u_ila_2/probe61]
connect_debug_port u_ila_2/probe61 [get_nets [list s_axi_awvalid]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe62]
set_property port_width 1 [get_debug_ports u_ila_2/probe62]
connect_debug_port u_ila_2/probe62 [get_nets [list s_axi_bready]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe63]
set_property port_width 1 [get_debug_ports u_ila_2/probe63]
connect_debug_port u_ila_2/probe63 [get_nets [list s_axi_bvalid]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe64]
set_property port_width 1 [get_debug_ports u_ila_2/probe64]
connect_debug_port u_ila_2/probe64 [get_nets [list s_axi_rlast]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe65]
set_property port_width 1 [get_debug_ports u_ila_2/probe65]
connect_debug_port u_ila_2/probe65 [get_nets [list s_axi_rready]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe66]
set_property port_width 1 [get_debug_ports u_ila_2/probe66]
connect_debug_port u_ila_2/probe66 [get_nets [list s_axi_rvalid]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe67]
set_property port_width 1 [get_debug_ports u_ila_2/probe67]
connect_debug_port u_ila_2/probe67 [get_nets [list s_axi_wlast]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe68]
set_property port_width 1 [get_debug_ports u_ila_2/probe68]
connect_debug_port u_ila_2/probe68 [get_nets [list s_axi_wready]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe69]
set_property port_width 1 [get_debug_ports u_ila_2/probe69]
connect_debug_port u_ila_2/probe69 [get_nets [list s_axi_wvalid]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe70]
set_property port_width 1 [get_debug_ports u_ila_2/probe70]
connect_debug_port u_ila_2/probe70 [get_nets [list s_conv_axi_arlock]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe71]
set_property port_width 1 [get_debug_ports u_ila_2/probe71]
connect_debug_port u_ila_2/probe71 [get_nets [list s_conv_axi_arready]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe72]
set_property port_width 1 [get_debug_ports u_ila_2/probe72]
connect_debug_port u_ila_2/probe72 [get_nets [list s_conv_axi_arvalid]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe73]
set_property port_width 1 [get_debug_ports u_ila_2/probe73]
connect_debug_port u_ila_2/probe73 [get_nets [list s_conv_axi_awlock]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe74]
set_property port_width 1 [get_debug_ports u_ila_2/probe74]
connect_debug_port u_ila_2/probe74 [get_nets [list s_conv_axi_awready]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe75]
set_property port_width 1 [get_debug_ports u_ila_2/probe75]
connect_debug_port u_ila_2/probe75 [get_nets [list s_conv_axi_awvalid]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe76]
set_property port_width 1 [get_debug_ports u_ila_2/probe76]
connect_debug_port u_ila_2/probe76 [get_nets [list s_conv_axi_bready]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe77]
set_property port_width 1 [get_debug_ports u_ila_2/probe77]
connect_debug_port u_ila_2/probe77 [get_nets [list s_conv_axi_bvalid]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe78]
set_property port_width 1 [get_debug_ports u_ila_2/probe78]
connect_debug_port u_ila_2/probe78 [get_nets [list s_conv_axi_rlast]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe79]
set_property port_width 1 [get_debug_ports u_ila_2/probe79]
connect_debug_port u_ila_2/probe79 [get_nets [list s_conv_axi_rready]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe80]
set_property port_width 1 [get_debug_ports u_ila_2/probe80]
connect_debug_port u_ila_2/probe80 [get_nets [list s_conv_axi_rvalid]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe81]
set_property port_width 1 [get_debug_ports u_ila_2/probe81]
connect_debug_port u_ila_2/probe81 [get_nets [list s_conv_axi_wlast]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe82]
set_property port_width 1 [get_debug_ports u_ila_2/probe82]
connect_debug_port u_ila_2/probe82 [get_nets [list s_conv_axi_wready]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe83]
set_property port_width 1 [get_debug_ports u_ila_2/probe83]
connect_debug_port u_ila_2/probe83 [get_nets [list s_conv_axi_wvalid]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets mig_ui_clk]
