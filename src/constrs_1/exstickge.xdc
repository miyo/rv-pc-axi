# CLOCK
set_property -dict {PACKAGE_PIN H4 IOSTANDARD LVDS_25} [get_ports CLK_P]
set_property -dict {PACKAGE_PIN G4 IOSTANDARD LVDS_25} [get_ports CLK_N]
create_clock -period 5.000 -name clk_pin -waveform {0.000 2.500} -add [get_ports CLK_P]

## UART (Serial Port)
set_property -dict {PACKAGE_PIN R18 IOSTANDARD LVCMOS33} [get_ports w_txd]
set_property -dict {PACKAGE_PIN T18 IOSTANDARD LVCMOS33} [get_ports w_rxd]

## Pmod CN6
set_property -dict {PACKAGE_PIN J17 IOSTANDARD LVCMOS33} [get_ports {sd_dat[3]}]
set_property -dict {PACKAGE_PIN M20 IOSTANDARD LVCMOS33} [get_ports sd_cmd]
set_property -dict {PACKAGE_PIN N19 IOSTANDARD LVCMOS33} [get_ports {sd_dat[0]}]
set_property -dict {PACKAGE_PIN L18 IOSTANDARD LVCMOS33} [get_ports sd_sclk]
set_property -dict {PACKAGE_PIN K17 IOSTANDARD LVCMOS33} [get_ports {sd_dat[1]}]
set_property -dict {PACKAGE_PIN N20 IOSTANDARD LVCMOS33} [get_ports {sd_dat[2]}]
set_property -dict {PACKAGE_PIN N18 IOSTANDARD LVCMOS33} [get_ports sd_cd]
set_property -dict {PACKAGE_PIN M18 IOSTANDARD LVCMOS33} [get_ports sd_rst]

## CLOCK ASYNCH
create_generated_clock -name mig_in_clk [get_pins clkgen0/inst/mmcm_adv_inst/CLKOUT0]
set_clock_groups -asynchronous -group mig_in_clk

create_generated_clock -name core_clk [get_pins clkgen1/inst/mmcm_adv_inst/CLKOUT0]
set_clock_groups -asynchronous -group core_clk

create_generated_clock -name clk_clk50mhz [get_pins clkgen2/inst/mmcm_adv_inst/CLKOUT0]
set_clock_groups -asynchronous -group clk_clk50mhz

create_generated_clock -name ref_clk [get_pins clkgen2/inst/mmcm_adv_inst/CLKOUT1]
set_clock_groups -asynchronous -group ref_clk

create_generated_clock -name pix_clk [get_pins clkgen3/inst/mmcm_adv_inst/CLKOUT0]
set_clock_groups -asynchronous -group pix_clk

