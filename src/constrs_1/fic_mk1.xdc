# set_false_path -from [get_clocks -of_objects [get_pins clk_wiz_0_i/inst/mmcme3_adv_inst/CLKOUT0] \
#                -filter {IS_GENERATED && MASTER_CLOCK == sys_clk_pin}] \
# 	       -to [get_clocks -of_objects [get_pins clk_wiz_0_i/inst/mmcme3_adv_inst/CLKOUT0] \
# 	       -filter {IS_GENERATED && MASTER_CLOCK == FGCK_P}]
# set_false_path -from [get_clocks -of_objects [get_pins clk_wiz_0_i/inst/mmcme3_adv_inst/CLKOUT0] \
#                -filter {IS_GENERATED && MASTER_CLOCK == FGCK_P}] \
# 	       -to [get_clocks -of_objects [get_pins clk_wiz_0_i/inst/mmcme3_adv_inst/CLKOUT0] \
# 	       -filter {IS_GENERATED && MASTER_CLOCK == sys_clk_pin}]
# set_false_path -from [get_clocks -of_objects [get_pins ddr4_0_i/inst/u_ddr4_infrastructure/gen_mmcme3.u_mmcme_adv_inst/CLKOUT0]] \
#                -to [get_clocks -of_objects [get_pins clkgen1/inst/mmcme3_adv_inst/CLKOUT0]]
# set_false_path -from [get_clocks -of_objects [get_pins clk_wiz_0_i/inst/mmcme3_adv_inst/CLKOUT0] \
#                -filter {IS_GENERATED && MASTER_CLOCK == FGCK_P}] \
# 	       -to [get_clocks -of_objects [get_pins ddr4_0_i/inst/u_ddr4_infrastructure/gen_mmcme3.u_mmcme_adv_inst/CLKOUT0]]
# set_false_path -from [get_clocks -of_objects [get_pins clk_wiz_0_i/inst/mmcme3_adv_inst/CLKOUT0] \
#                -filter {IS_GENERATED && MASTER_CLOCK == sys_clk_pin}] \
# 	       -to [get_clocks -of_objects [get_pins ddr4_0_i/inst/u_ddr4_infrastructure/gen_mmcme3.u_mmcme_adv_inst/CLKOUT0]]
# set_false_path -from [get_clocks -of_objects [get_pins clkgen1/inst/mmcme3_adv_inst/CLKOUT0]] \
#                -to [get_clocks -of_objects [get_pins ddr4_0_i/inst/u_ddr4_infrastructure/gen_mmcme3.u_mmcme_adv_inst/CLKOUT0]]

# create_generated_clock -name mig_in_clk [get_pins m_clkgen0/inst/mmcm_adv_inst/CLKOUT0]
#

# #create_generated_clock -name core_clk [get_pins mem_ctrl/dram_con/dram/dram/dram_con_witout_cache/clkgen1/inst/mmcm_adv_inst/CLKOUT0]
# create_generated_clock -name core_clk [get_pins clkgen1/inst/mmcm_adv_inst/CLKOUT0]
#

create_generated_clock -name mig_in_clk [get_pins clk_wiz_0_i/inst/mmcme3_adv_inst/CLKOUT0]
create_generated_clock -name core_clk [get_pins clkgen1/inst/mmcme3_adv_inst/CLKOUT0]
create_generated_clock -name ddr4_clk [get_pins ddr4_0_i/inst/u_ddr4_infrastructure/gen_mmcme3.u_mmcme_adv_inst/CLKOUT0]

set_clock_groups -asynchronous -group mig_in_clk
set_clock_groups -asynchronous -group core_clk
set_clock_groups -asynchronous -group ddr4_clk

set_property -dict {PACKAGE_PIN AV27 IOSTANDARD SUB_LVDS DIFF_TERM_ADV TERM_100} [get_ports FGCK_P]
set_property -dict {PACKAGE_PIN AV28 IOSTANDARD SUB_LVDS DIFF_TERM_ADV TERM_100} [get_ports FGCK_N]
create_clock -period 100.000 [get_ports FGCK_P]

set_property -dict {PACKAGE_PIN AN24 IOSTANDARD LVCMOS33} [get_ports led0]
set_property -dict {PACKAGE_PIN AP23 IOSTANDARD LVCMOS33} [get_ports led1]

set_property -dict {PACKAGE_PIN E40 IOSTANDARD LVCMOS18} [get_ports uart_tx]
set_property -dict {PACKAGE_PIN D40 IOSTANDARD LVCMOS18} [get_ports uart_rx]

#Pin LOC constraints for the status signals init_calib_complete and data_compare_error

set_property IOSTANDARD DIFF_SSTL12_DCI [get_ports c0_sys_clk_p]
set_property IOSTANDARD DIFF_SSTL12_DCI [get_ports c0_sys_clk_n]

#set_property -dict {PACKAGE_PIN A37 IOSTANDARD LVCMOS18} [get_ports {sd_dat[3]}]
#set_property -dict {PACKAGE_PIN C36 IOSTANDARD LVCMOS18} [get_ports sd_cmd]
#set_property -dict {PACKAGE_PIN D38 IOSTANDARD LVCMOS18} [get_ports {sd_dat[0]}]
#set_property -dict {PACKAGE_PIN A40 IOSTANDARD LVCMOS18} [get_ports sd_sclk]
#set_property -dict {PACKAGE_PIN B36 IOSTANDARD LVCMOS18} [get_ports {sd_dat[1]}]
#set_property -dict {PACKAGE_PIN E36 IOSTANDARD LVCMOS18} [get_ports {sd_dat[2]}]
#set_property -dict {PACKAGE_PIN C39 IOSTANDARD LVCMOS18} [get_ports sd_cd]
#set_property -dict {PACKAGE_PIN A39 IOSTANDARD LVCMOS18} [get_ports sd_rst]
#set_property -dict {PACKAGE_PIN B35 IOSTANDARD LVCMOS18} [get_ports level_conv_oe]

#set_property -dict {PACKAGE_PIN J31 IOSTANDARD LVCMOS18} [get_ports {sd_dat[3]}]
#set_property -dict {PACKAGE_PIN H32 IOSTANDARD LVCMOS18} [get_ports sd_cmd]
#set_property -dict {PACKAGE_PIN G31 IOSTANDARD LVCMOS18} [get_ports {sd_dat[0]}]
#set_property -dict {PACKAGE_PIN E33 IOSTANDARD LVCMOS18} [get_ports sd_sclk]
#set_property -dict {PACKAGE_PIN J33 IOSTANDARD LVCMOS18} [get_ports {sd_dat[1]}]
#set_property -dict {PACKAGE_PIN H31 IOSTANDARD LVCMOS18} [get_ports {sd_dat[2]}]
#set_property -dict {PACKAGE_PIN F33 IOSTANDARD LVCMOS18} [get_ports sd_cd]
#set_property -dict {PACKAGE_PIN E32 IOSTANDARD LVCMOS18} [get_ports sd_rst]

set_property -dict {PACKAGE_PIN G35 IOSTANDARD LVCMOS18} [get_ports {sd_dat[3]}]
set_property -dict {PACKAGE_PIN B32 IOSTANDARD LVCMOS18} [get_ports sd_cmd]
set_property -dict {PACKAGE_PIN A32 IOSTANDARD LVCMOS18} [get_ports {sd_dat[0]}]
set_property -dict {PACKAGE_PIN C34 IOSTANDARD LVCMOS18} [get_ports sd_sclk]
set_property -dict {PACKAGE_PIN C31 IOSTANDARD LVCMOS18} [get_ports {sd_dat[1]}]
set_property -dict {PACKAGE_PIN C32 IOSTANDARD LVCMOS18} [get_ports {sd_dat[2]}]
set_property -dict {PACKAGE_PIN C33 IOSTANDARD LVCMOS18} [get_ports sd_cd]
set_property -dict {PACKAGE_PIN D34 IOSTANDARD LVCMOS18} [get_ports sd_rst]

#set_property -dict {PACKAGE_PIN F32 IOSTANDARD LVCMOS18} [get_ports dir0]
#set_property -dict {PACKAGE_PIN G32 IOSTANDARD LVCMOS18} [get_ports dir1]
#set_property -dict {PACKAGE_PIN H33 IOSTANDARD LVCMOS18} [get_ports dir2]
#set_property -dict {PACKAGE_PIN J30 IOSTANDARD LVCMOS18} [get_ports dir3]
set_property -dict {PACKAGE_PIN B31 IOSTANDARD LVCMOS18} [get_ports dir0]
set_property -dict {PACKAGE_PIN D31 IOSTANDARD LVCMOS18} [get_ports dir1]
set_property -dict {PACKAGE_PIN A33 IOSTANDARD LVCMOS18} [get_ports dir2]
set_property -dict {PACKAGE_PIN D33 IOSTANDARD LVCMOS18} [get_ports dir3]


set_property -dict { PACKAGE_PIN E35 IOSTANDARD LVCMOS18 } [get_ports { r_txd_phy[0] }];
set_property -dict { PACKAGE_PIN B37 IOSTANDARD LVCMOS18 } [get_ports { w_rxd_phy[1] }];
set_property -dict { PACKAGE_PIN A37 IOSTANDARD LVCMOS18 } [get_ports { w_crs_dv_phy }];
set_property -dict { PACKAGE_PIN C37 IOSTANDARD LVCMOS18 } [get_ports { w_mdc_phy }];

set_property -dict { PACKAGE_PIN E37 IOSTANDARD LVCMOS18 } [get_ports { r_txd_phy[1] }];
set_property -dict { PACKAGE_PIN A35 IOSTANDARD LVCMOS18 } [get_ports { r_txen_phy }];
set_property -dict { PACKAGE_PIN B36 IOSTANDARD LVCMOS18 } [get_ports { w_rxd_phy[0] }];
set_property -dict { PACKAGE_PIN D36 IOSTANDARD LVCMOS18 } [get_ports { w_phy_clk }];
set_property -dict { PACKAGE_PIN C36 IOSTANDARD LVCMOS18 } [get_ports { w_mdio_phy }];

set_property -dict {PACKAGE_PIN A34 IOSTANDARD LVCMOS18} [get_ports dir4]
set_property -dict {PACKAGE_PIN D35 IOSTANDARD LVCMOS18} [get_ports dir5]
set_property -dict {PACKAGE_PIN B35 IOSTANDARD LVCMOS18} [get_ports dir6]
set_property -dict {PACKAGE_PIN A38 IOSTANDARD LVCMOS18} [get_ports dir7]
set_property -dict {PACKAGE_PIN E36 IOSTANDARD LVCMOS18} [get_ports dir8]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets w_phy_clk_IBUF]
create_clock -period 18.000 -name w_phy_clk_net -add [get_ports w_phy_clk]

set_false_path -from [get_clocks w_phy_clk_net] -to [get_clocks core_clk_net]
set_false_path -from [get_clocks core_clk_net] -to [get_clocks w_phy_clk_net]

set_input_delay -clock w_phy_clk_net -max 4.000 [get_ports { w_rxd_phy[0] }];
set_input_delay -clock w_phy_clk_net -max 4.000 [get_ports { w_rxd_phy[1] }];
set_input_delay -clock w_phy_clk_net -max 4.000 [get_ports { w_crs_dv_phy }];

set_output_delay -clock w_phy_clk_net -max 1.000 [get_ports { w_txd_phy[0] }];
set_output_delay -clock w_phy_clk_net -max 1.000 [get_ports { w_txd_phy[1] }];
set_output_delay -clock w_phy_clk_net -max 1.000 [get_ports { w_txen_phy }];

# ============ DDR_M0 (Bank 69). ========================================
#	set_property PACKAGE_PIN C17				[get_ports ""						]
	set_property PACKAGE_PIN A17				[get_ports "c0_ddr4_dq[2]"			]
	set_property PACKAGE_PIN B17				[get_ports "c0_ddr4_dq[6]"			]
	set_property PACKAGE_PIN B16				[get_ports "c0_ddr4_dq[7]"			]
	set_property PACKAGE_PIN C16				[get_ports "c0_ddr4_dq[3]"			]
	set_property PACKAGE_PIN A15				[get_ports "c0_ddr4_dqs_c[0]"		]
	set_property PACKAGE_PIN B15				[get_ports "c0_ddr4_dqs_t[0]"		]
	set_property PACKAGE_PIN A13				[get_ports "c0_ddr4_dq[4]"			]
	set_property PACKAGE_PIN A14				[get_ports "c0_ddr4_dq[0]"			]
	set_property PACKAGE_PIN B14				[get_ports "c0_ddr4_dq[1]"			]
	set_property PACKAGE_PIN C14				[get_ports "c0_ddr4_dq[5]"			]
#	set_property PACKAGE_PIN C13				[get_ports ""						]
	set_property PACKAGE_PIN D13				[get_ports "c0_ddr4_dm_dbi_n[0]"	]

#	set_property PACKAGE_PIN D14				[get_ports ""						]
	set_property PACKAGE_PIN D16				[get_ports "c0_ddr4_dq[10]"			]
	set_property PACKAGE_PIN E16				[get_ports "c0_ddr4_dq[11]"			]
	set_property PACKAGE_PIN D15				[get_ports "c0_ddr4_dq[14]"			]
	set_property PACKAGE_PIN E15				[get_ports "c0_ddr4_dq[15]"			]
	set_property PACKAGE_PIN G16				[get_ports "c0_ddr4_dqs_c[1]"		]
	set_property PACKAGE_PIN G17				[get_ports "c0_ddr4_dqs_t[1]"		]
	set_property PACKAGE_PIN E13				[get_ports "c0_ddr4_dq[13]"			]
	set_property PACKAGE_PIN F13				[get_ports "c0_ddr4_dq[12]"			]
	set_property PACKAGE_PIN F15				[get_ports "c0_ddr4_dq[9]"			]
	set_property PACKAGE_PIN G15				[get_ports "c0_ddr4_dq[8]"			]
#	set_property PACKAGE_PIN F14				[get_ports ""						]
	set_property PACKAGE_PIN G14				[get_ports "c0_ddr4_dm_dbi_n[1]"	]

#	set_property PACKAGE_PIN L15				[get_ports ""						]
	set_property PACKAGE_PIN J15				[get_ports "c0_ddr4_dq[16]"			]
	set_property PACKAGE_PIN J16				[get_ports "c0_ddr4_dq[17]"			]
	set_property PACKAGE_PIN H14				[get_ports "c0_ddr4_dq[18]"			]
	set_property PACKAGE_PIN J14				[get_ports "c0_ddr4_dq[19]"			]
	set_property PACKAGE_PIN H16				[get_ports "c0_ddr4_dqs_c[2]"		]
	set_property PACKAGE_PIN H17				[get_ports "c0_ddr4_dqs_t[2]"		]
	set_property PACKAGE_PIN H13				[get_ports "c0_ddr4_dq[20]"			]
	set_property PACKAGE_PIN J13				[get_ports "c0_ddr4_dq[21]"			]
	set_property PACKAGE_PIN K15				[get_ports "c0_ddr4_dq[22]"			]
	set_property PACKAGE_PIN K16				[get_ports "c0_ddr4_dq[23]"			]
#	set_property PACKAGE_PIN K13				[get_ports ""						]
	set_property PACKAGE_PIN L13				[get_ports "c0_ddr4_dm_dbi_n[2]"	]

#	set_property PACKAGE_PIN M15				[get_ports ""						]
	set_property PACKAGE_PIN M16				[get_ports "c0_ddr4_dq[31]"			]
	set_property PACKAGE_PIN N16				[get_ports "c0_ddr4_dq[27]"			]
	set_property PACKAGE_PIN L14				[get_ports "c0_ddr4_dq[25]"			]
	set_property PACKAGE_PIN M14				[get_ports "c0_ddr4_dq[24]"			]
	set_property PACKAGE_PIN P16				[get_ports "c0_ddr4_dqs_c[3]"		]
	set_property PACKAGE_PIN R16				[get_ports "c0_ddr4_dqs_t[3]"		]
	set_property PACKAGE_PIN P15				[get_ports "c0_ddr4_dq[26]"			]
	set_property PACKAGE_PIN R15				[get_ports "c0_ddr4_dq[30]"			]
	set_property PACKAGE_PIN N14				[get_ports "c0_ddr4_dq[29]"			]
	set_property PACKAGE_PIN P14				[get_ports "c0_ddr4_dq[28]"			]
#	set_property PACKAGE_PIN N13				[get_ports ""						]
	set_property PACKAGE_PIN P13				[get_ports "c0_ddr4_dm_dbi_n[3]"	]


# ============ DDR_M0 (Bank 71). ========================================
#	set_property PACKAGE_PIN D26				[get_ports ""						]
	set_property PACKAGE_PIN A25				[get_ports "c0_ddr4_dq[34]"			]
	set_property PACKAGE_PIN B25				[get_ports "c0_ddr4_dq[38]"			]
	set_property PACKAGE_PIN A24				[get_ports "c0_ddr4_dq[32]"			]
	set_property PACKAGE_PIN B24				[get_ports "c0_ddr4_dq[36]"			]
	set_property PACKAGE_PIN A22				[get_ports "c0_ddr4_dqs_c[4]"		]
	set_property PACKAGE_PIN A23				[get_ports "c0_ddr4_dqs_t[4]"		]
	set_property PACKAGE_PIN B26				[get_ports "c0_ddr4_dq[35]"			]
	set_property PACKAGE_PIN C26				[get_ports "c0_ddr4_dq[39]"			]
	set_property PACKAGE_PIN C23				[get_ports "c0_ddr4_dq[37]"			]
	set_property PACKAGE_PIN C24				[get_ports "c0_ddr4_dq[33]"			]
#	set_property PACKAGE_PIN B22				[get_ports ""						]
	set_property PACKAGE_PIN C22				[get_ports "c0_ddr4_dm_dbi_n[4]"	]

#	set_property PACKAGE_PIN F25				[get_ports ""						]
	set_property PACKAGE_PIN D25				[get_ports "c0_ddr4_dq[44]"			]
	set_property PACKAGE_PIN E25				[get_ports "c0_ddr4_dq[45]"			]
	set_property PACKAGE_PIN D23				[get_ports "c0_ddr4_dq[46]"			]
	set_property PACKAGE_PIN D24				[get_ports "c0_ddr4_dq[47]"			]
	set_property PACKAGE_PIN E22				[get_ports "c0_ddr4_dqs_c[5]"		]
	set_property PACKAGE_PIN E23				[get_ports "c0_ddr4_dqs_t[5]"		]
	set_property PACKAGE_PIN F22				[get_ports "c0_ddr4_dq[42]"			]
	set_property PACKAGE_PIN G22				[get_ports "c0_ddr4_dq[43]"			]
	set_property PACKAGE_PIN F23				[get_ports "c0_ddr4_dq[40]"			]
	set_property PACKAGE_PIN F24				[get_ports "c0_ddr4_dq[41]"			]
#	set_property PACKAGE_PIN G24				[get_ports ""						]
	set_property PACKAGE_PIN G25				[get_ports "c0_ddr4_dm_dbi_n[5]"	]

#	set_property PACKAGE_PIN H22				[get_ports ""						]
	set_property PACKAGE_PIN H24				[get_ports "c0_ddr4_dq[53]"			]
	set_property PACKAGE_PIN J24				[get_ports "c0_ddr4_dq[49]"			]
	set_property PACKAGE_PIN H23				[get_ports "c0_ddr4_dq[52]"			]
	set_property PACKAGE_PIN J23				[get_ports "c0_ddr4_dq[48]"			]
	set_property PACKAGE_PIN J25				[get_ports "c0_ddr4_dqs_c[6]"		]
	set_property PACKAGE_PIN K25				[get_ports "c0_ddr4_dqs_t[6]"		]
	set_property PACKAGE_PIN K23				[get_ports "c0_ddr4_dq[54]"			]
	set_property PACKAGE_PIN L23				[get_ports "c0_ddr4_dq[50]"			]
	set_property PACKAGE_PIN K22				[get_ports "c0_ddr4_dq[55]"			]
	set_property PACKAGE_PIN L22				[get_ports "c0_ddr4_dq[51]"			]
#	set_property PACKAGE_PIN L24				[get_ports ""						]
	set_property PACKAGE_PIN L25				[get_ports "c0_ddr4_dm_dbi_n[6]"	]

#	set_property PACKAGE_PIN R23				[get_ports ""						]
	set_property PACKAGE_PIN P25				[get_ports "c0_ddr4_dq[58]"			]
	set_property PACKAGE_PIN R25				[get_ports "c0_ddr4_dq[59]"			]
	set_property PACKAGE_PIN M24				[get_ports "c0_ddr4_dq[62]"			]
	set_property PACKAGE_PIN M25				[get_ports "c0_ddr4_dq[63]"			]
	set_property PACKAGE_PIN N24				[get_ports "c0_ddr4_dqs_c[7]"		]
	set_property PACKAGE_PIN P24				[get_ports "c0_ddr4_dqs_t[7]"		]
	set_property PACKAGE_PIN N23				[get_ports "c0_ddr4_dq[56]"			]
	set_property PACKAGE_PIN P23				[get_ports "c0_ddr4_dq[57]"			]
	set_property PACKAGE_PIN M22				[get_ports "c0_ddr4_dq[60]"			]
	set_property PACKAGE_PIN N22				[get_ports "c0_ddr4_dq[61]"			]
#	set_property PACKAGE_PIN P21				[get_ports ""						]
	set_property PACKAGE_PIN R21				[get_ports "c0_ddr4_dm_dbi_n[7]"	]


# ============ DDR_M0 (Bank 70). ========================================
#	set_property PACKAGE_PIN A18				[get_ports ""						]
	set_property PACKAGE_PIN A20				[get_ports "c0_ddr4_dq[66]"			]
	set_property PACKAGE_PIN B20				[get_ports "c0_ddr4_dq[70]"			]
	set_property PACKAGE_PIN A19				[get_ports "c0_ddr4_dq[64]"			]
	set_property PACKAGE_PIN B19				[get_ports "c0_ddr4_dq[68]"			]
	set_property PACKAGE_PIN C18				[get_ports "c0_ddr4_dqs_c[8]"		]
	set_property PACKAGE_PIN D18				[get_ports "c0_ddr4_dqs_t[8]"		]
	set_property PACKAGE_PIN B21				[get_ports "c0_ddr4_dq[67]"			]
	set_property PACKAGE_PIN C21				[get_ports "c0_ddr4_dq[71]"			]
	set_property PACKAGE_PIN D20				[get_ports "c0_ddr4_dq[69]"			]
	set_property PACKAGE_PIN D21				[get_ports "c0_ddr4_dq[65]"			]
#	set_property PACKAGE_PIN C19				[ get_ports ""						]
	set_property PACKAGE_PIN D19				[get_ports "c0_ddr4_dm_dbi_n[8]"	]

	set_property PACKAGE_PIN G21				[get_ports "c0_ddr4_reset_n"		]
	set_property PACKAGE_PIN F17				[get_ports "c0_ddr4_cke[1]"			]
	set_property PACKAGE_PIN F18				[get_ports "c0_ddr4_cke[0]"			]
	set_property PACKAGE_PIN E20				[get_ports "c0_ddr4_act_n"			]
	set_property PACKAGE_PIN E21				[get_ports "c0_ddr4_bg[0]"			]
	set_property PACKAGE_PIN E17				[get_ports "c0_ddr4_bg[1]"			]
	set_property PACKAGE_PIN E18				[get_ports "c0_ddr4_adr[12]"		]
	set_property PACKAGE_PIN F19				[get_ports "c0_ddr4_adr[11]"		]
	set_property PACKAGE_PIN F20				[get_ports "c0_ddr4_adr[9]"			]
	set_property PACKAGE_PIN G19				[get_ports "c0_ddr4_adr[7]"			]
	set_property PACKAGE_PIN G20				[get_ports "c0_ddr4_adr[8]"			]
#	set_property PACKAGE_PIN H19				[get_ports "M0_SYS_CLK_P"			]
#	set_property PACKAGE_PIN H18				[get_ports "M0_SYS_CLK_N"			]

	set_property PACKAGE_PIN BA9				[get_ports "c0_sys_clk_p"			]
	set_property PACKAGE_PIN BA8				[get_ports "c0_sys_clk_n"			]

	set_property PACKAGE_PIN K21				[get_ports "c0_ddr4_adr[5]"			]
	set_property PACKAGE_PIN J19				[get_ports "c0_ddr4_ck_c[0]"		]
	set_property PACKAGE_PIN J20				[get_ports "c0_ddr4_ck_t[0]"		]
	set_property PACKAGE_PIN J18				[get_ports "c0_ddr4_ck_c[1]"		]
	set_property PACKAGE_PIN K18				[get_ports "c0_ddr4_ck_t[1]"		]
	set_property PACKAGE_PIN H21				[get_ports "c0_ddr4_adr[6]"			]
	set_property PACKAGE_PIN J21				[get_ports "c0_ddr4_adr[4]"			]
	set_property PACKAGE_PIN K20				[get_ports "c0_ddr4_adr[3]"			]
	set_property PACKAGE_PIN L20				[get_ports "c0_ddr4_adr[2]"			]
	set_property PACKAGE_PIN L18				[get_ports "c0_ddr4_adr[1]"			]
#	set_property PACKAGE_PIN L19				[get_ports "M0_EVENT_N"				]
	set_property PACKAGE_PIN K17				[get_ports "c0_ddr4_adr[0]"			]
	set_property PACKAGE_PIN L17				[get_ports "c0_ddr4_ba[1]"			]

#	set_property PACKAGE_PIN R18				[get_ports ""						]
	set_property PACKAGE_PIN M21				[get_ports "c0_ddr4_adr[10]"		]
	set_property PACKAGE_PIN N21				[get_ports "c0_ddr4_ba[0]"			]
	set_property PACKAGE_PIN P20				[get_ports "c0_ddr4_adr[16]"		]
	set_property PACKAGE_PIN R20				[get_ports "c0_ddr4_adr[14]"		]
	set_property PACKAGE_PIN N19				[get_ports "c0_ddr4_cs_n[0]"		]
	set_property PACKAGE_PIN P19				[get_ports "c0_ddr4_adr[15]"		]
	set_property PACKAGE_PIN M19				[get_ports "c0_ddr4_odt[0]"			]
	set_property PACKAGE_PIN M20				[get_ports "c0_ddr4_adr[13]"		]
	set_property PACKAGE_PIN N18				[get_ports "c0_ddr4_cs_n[1]"		]
	set_property PACKAGE_PIN P18				[get_ports "c0_ddr4_odt[1]"			]
#	set_property PACKAGE_PIN M17				[get_ports ""						]
#	set_property PACKAGE_PIN N17				[get_ports ""						]
