###############################################################################################
## main.xdc for NEXYS A7   ArchLab TOKYO TECH
###############################################################################################

## 100MHz system clock
###############################################################################################
set_property -dict { PACKAGE_PIN E3  IOSTANDARD LVCMOS33} [get_ports { CLK }];
create_clock -add -name sys_clk -period 10.00 [get_ports {CLK}];

## UART (Serial Port)
###############################################################################################
set_property -dict { PACKAGE_PIN D10  IOSTANDARD LVCMOS33} [get_ports { w_txd }];
set_property -dict { PACKAGE_PIN A9  IOSTANDARD LVCMOS33} [get_ports { w_rxd }];
# set_property -dict { PACKAGE_PIN A9  IOSTANDARD LVCMOS33} [get_ports { w_txd }];
# set_property -dict { PACKAGE_PIN D10  IOSTANDARD LVCMOS33} [get_ports { w_rxd }];
###############################################################################################
create_generated_clock -name mig_in_clk [get_pins m_clkgen0/inst/mmcm_adv_inst/CLKOUT0]
set_clock_groups -asynchronous -group {mig_in_clk}

create_generated_clock -name core_clk [get_pins clkgen1/inst/mmcm_adv_inst/CLKOUT0]
set_clock_groups -asynchronous -group {core_clk}

## LEDs
###############################################################################################
set_property -dict { PACKAGE_PIN H5 IOSTANDARD LVCMOS33} [get_ports { w_ledx[0] }];
set_property -dict { PACKAGE_PIN J5 IOSTANDARD LVCMOS33} [get_ports { w_ledx[1] }];
set_property -dict { PACKAGE_PIN T9 IOSTANDARD LVCMOS33} [get_ports { w_ledx[2] }];
set_property -dict { PACKAGE_PIN T10 IOSTANDARD LVCMOS33} [get_ports { w_ledx[3] }];

## RGB LEDs
###############################################################################################
set_property -dict { PACKAGE_PIN E1 IOSTANDARD LVCMOS33 } [get_ports { w_led1_B }]; 
set_property -dict { PACKAGE_PIN F6 IOSTANDARD LVCMOS33 } [get_ports { w_led1_G }]; 
set_property -dict { PACKAGE_PIN G6 IOSTANDARD LVCMOS33 } [get_ports { w_led1_R }]; 

## TEST
set_property -dict { PACKAGE_PIN K5 IOSTANDARD SSTL135 } [get_ports { ddr3_dq[0] }];
set_property -dict { PACKAGE_PIN L3 IOSTANDARD SSTL135 } [get_ports { ddr3_dq[1] }]; 
set_property -dict { PACKAGE_PIN K3 IOSTANDARD SSTL135 } [get_ports { ddr3_dq[2] }]; 
set_property -dict { PACKAGE_PIN L6 IOSTANDARD SSTL135 } [get_ports { ddr3_dq[3] }]; 
set_property -dict { PACKAGE_PIN M3 IOSTANDARD SSTL135 } [get_ports { ddr3_dq[4] }]; 
set_property -dict { PACKAGE_PIN M1 IOSTANDARD SSTL135 } [get_ports { ddr3_dq[5] }]; 
set_property -dict { PACKAGE_PIN L4 IOSTANDARD SSTL135 } [get_ports { ddr3_dq[6] }]; 
set_property -dict { PACKAGE_PIN M2 IOSTANDARD SSTL135 } [get_ports { ddr3_dq[7] }]; 
set_property -dict { PACKAGE_PIN V4 IOSTANDARD SSTL135 } [get_ports { ddr3_dq[8] }]; 
set_property -dict { PACKAGE_PIN T5 IOSTANDARD SSTL135 } [get_ports { ddr3_dq[9] }]; 
set_property -dict { PACKAGE_PIN U4 IOSTANDARD SSTL135 } [get_ports { ddr3_dq[10] }]; 
set_property -dict { PACKAGE_PIN V5 IOSTANDARD SSTL135 } [get_ports { ddr3_dq[11] }]; 
set_property -dict { PACKAGE_PIN V1 IOSTANDARD SSTL135 } [get_ports { ddr3_dq[12] }]; 
set_property -dict { PACKAGE_PIN T3 IOSTANDARD SSTL135 } [get_ports { ddr3_dq[13] }]; 
set_property -dict { PACKAGE_PIN U3 IOSTANDARD SSTL135 } [get_ports { ddr3_dq[14] }]; 
set_property -dict { PACKAGE_PIN R3 IOSTANDARD SSTL135 } [get_ports { ddr3_dq[15] }]; 

set_property -dict { PACKAGE_PIN L1 IOSTANDARD SSTL135 } [get_ports { ddr3_dm[0] }]; 
set_property -dict { PACKAGE_PIN U1 IOSTANDARD SSTL135 } [get_ports { ddr3_dm[1] }]; 

set_property -dict { PACKAGE_PIN N2 IOSTANDARD DIFF_SSTL135 } [get_ports { ddr3_dqs_p[0] }];
set_property -dict { PACKAGE_PIN N1 IOSTANDARD DIFF_SSTL135 } [get_ports { ddr3_dqs_n[0] }]; 
set_property -dict { PACKAGE_PIN U2 IOSTANDARD DIFF_SSTL135 } [get_ports { ddr3_dqs_p[1] }];
set_property -dict { PACKAGE_PIN V2 IOSTANDARD DIFF_SSTL135 } [get_ports { ddr3_dqs_n[1] }]; 

set_property -dict { PACKAGE_PIN T8 IOSTANDARD SSTL135 } [get_ports { ddr3_addr[13] }];
set_property -dict { PACKAGE_PIN T6 IOSTANDARD SSTL135 } [get_ports { ddr3_addr[12] }]; 
set_property -dict { PACKAGE_PIN U6 IOSTANDARD SSTL135 } [get_ports { ddr3_addr[11] }]; 
set_property -dict { PACKAGE_PIN R6 IOSTANDARD SSTL135 } [get_ports { ddr3_addr[10] }]; 
set_property -dict { PACKAGE_PIN V7 IOSTANDARD SSTL135 } [get_ports { ddr3_addr[9] }]; 
set_property -dict { PACKAGE_PIN R8 IOSTANDARD SSTL135 } [get_ports { ddr3_addr[8] }]; 
set_property -dict { PACKAGE_PIN U7 IOSTANDARD SSTL135 } [get_ports { ddr3_addr[7] }]; 
set_property -dict { PACKAGE_PIN V6 IOSTANDARD SSTL135 } [get_ports { ddr3_addr[6] }]; 
set_property -dict { PACKAGE_PIN R7 IOSTANDARD SSTL135 } [get_ports { ddr3_addr[5] }]; 
set_property -dict { PACKAGE_PIN N6 IOSTANDARD SSTL135 } [get_ports { ddr3_addr[4] }]; 
set_property -dict { PACKAGE_PIN T1 IOSTANDARD SSTL135 } [get_ports { ddr3_addr[3] }]; 
set_property -dict { PACKAGE_PIN N4 IOSTANDARD SSTL135 } [get_ports { ddr3_addr[2] }]; 
set_property -dict { PACKAGE_PIN M6 IOSTANDARD SSTL135 } [get_ports { ddr3_addr[1] }]; 
set_property -dict { PACKAGE_PIN R2 IOSTANDARD SSTL135 } [get_ports { ddr3_addr[0] }]; 

set_property -dict { PACKAGE_PIN P2 IOSTANDARD SSTL135 } [get_ports { ddr3_ba[2] }]; 
set_property -dict { PACKAGE_PIN P4 IOSTANDARD SSTL135 } [get_ports { ddr3_ba[1] }]; 
set_property -dict { PACKAGE_PIN R1 IOSTANDARD SSTL135 } [get_ports { ddr3_ba[0] }]; 

set_property -dict { PACKAGE_PIN U9 IOSTANDARD DIFF_SSTL135 } [get_ports { ddr3_ck_p[0] }];
set_property -dict { PACKAGE_PIN V9 IOSTANDARD DIFF_SSTL135 } [get_ports { ddr3_ck_n[0] }];

set_property -dict { PACKAGE_PIN P3 IOSTANDARD SSTL135 } [get_ports { ddr3_ras_n }];
set_property -dict { PACKAGE_PIN M4 IOSTANDARD SSTL135 } [get_ports { ddr3_cas_n }]; 
set_property -dict { PACKAGE_PIN P5 IOSTANDARD SSTL135 } [get_ports { ddr3_we_n }];
set_property -dict { PACKAGE_PIN K6 IOSTANDARD SSTL135 } [get_ports { ddr3_reset_n }];
set_property -dict { PACKAGE_PIN N5 IOSTANDARD SSTL135 } [get_ports { ddr3_cke[0] }];
set_property -dict { PACKAGE_PIN R5 IOSTANDARD SSTL135 } [get_ports { ddr3_odt[0] }];
set_property -dict { PACKAGE_PIN U8 IOSTANDARD SSTL135 } [get_ports { ddr3_cs_n[0] }];

## Pmod Header JA
set_property -dict { PACKAGE_PIN G13   IOSTANDARD LVCMOS33 } [get_ports { vga_red[0] }]; #IO_0_15 Sch=ja[1]
set_property -dict { PACKAGE_PIN B11   IOSTANDARD LVCMOS33 } [get_ports { vga_red[1] }]; #IO_L4P_T0_15 Sch=ja[2]
set_property -dict { PACKAGE_PIN A11   IOSTANDARD LVCMOS33 } [get_ports { vga_red[2] }]; #IO_L4N_T0_15 Sch=ja[3]
set_property -dict { PACKAGE_PIN D12   IOSTANDARD LVCMOS33 } [get_ports { vga_red[3]  }]; #IO_L6P_T0_15 Sch=ja[4]
set_property -dict { PACKAGE_PIN D13   IOSTANDARD LVCMOS33 } [get_ports { vga_blue[0] }]; #IO_L6N_T0_VREF_15 Sch=ja[7]
set_property -dict { PACKAGE_PIN B18   IOSTANDARD LVCMOS33 } [get_ports { vga_blue[1] }]; #IO_L10P_T1_AD11P_15 Sch=ja[8]
set_property -dict { PACKAGE_PIN A18   IOSTANDARD LVCMOS33 } [get_ports { vga_blue[2] }]; #IO_L10N_T1_AD11N_15 Sch=ja[9]
set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports { vga_blue[3] }]; #IO_25_15 Sch=ja[10]

## Pmod Header JB
set_property -dict { PACKAGE_PIN E15   IOSTANDARD LVCMOS33 } [get_ports { vga_green[0] }]; #IO_L11P_T1_SRCC_15 Sch=jb_p[1]
set_property -dict { PACKAGE_PIN E16   IOSTANDARD LVCMOS33 } [get_ports { vga_green[1] }]; #IO_L11N_T1_SRCC_15 Sch=jb_n[1]
set_property -dict { PACKAGE_PIN D15   IOSTANDARD LVCMOS33 } [get_ports { vga_green[2] }]; #IO_L12P_T1_MRCC_15 Sch=jb_p[2]
set_property -dict { PACKAGE_PIN C15   IOSTANDARD LVCMOS33 } [get_ports { vga_green[3] }]; #IO_L12N_T1_MRCC_15 Sch=jb_n[2]
set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports { vga_h_sync }]; #IO_L23P_T3_FOE_B_15 Sch=jb_p[3]
set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports { vga_v_sync }]; #IO_L23N_T3_FWE_B_15 Sch=jb_n[3]
#set_property -dict { PACKAGE_PIN K15   IOSTANDARD LVCMOS33 } [get_ports { jb[6] }]; #IO_L24P_T3_RS1_15 Sch=jb_p[4]
#set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { jb[7] }]; #IO_L24N_T3_RS0_15 Sch=jb_n[4]

## Pmod Header JC
set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { sd_dat[3] }]; #IO_L20P_T3_A08_D24_14 Sch=jc_p[1]
set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { sd_cmd    }]; #IO_L20N_T3_A07_D23_14 Sch=jc_n[1]
set_property -dict { PACKAGE_PIN V10   IOSTANDARD LVCMOS33 } [get_ports { sd_dat[0] }]; #IO_L21P_T3_DQS_14 Sch=jc_p[2]
set_property -dict { PACKAGE_PIN V11   IOSTANDARD LVCMOS33 } [get_ports { sd_sclk   }]; #IO_L21N_T3_DQS_A06_D22_14 Sch=jc_n[2]
set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports { sd_dat[1] }]; #IO_L22P_T3_A05_D21_14 Sch=jc_p[3]
set_property -dict { PACKAGE_PIN V14   IOSTANDARD LVCMOS33 } [get_ports { sd_dat[2] }]; #IO_L22N_T3_A04_D20_14 Sch=jc_n[3]
set_property -dict { PACKAGE_PIN T13   IOSTANDARD LVCMOS33 } [get_ports { sd_cd     }]; #IO_L23P_T3_A03_D19_14 Sch=jc_p[4]
set_property -dict { PACKAGE_PIN U13   IOSTANDARD LVCMOS33 } [get_ports { sd_rst    }]; #IO_L23N_T3_A02_D18_14 Sch=jc_n[4]

## Pmod Header JD
set_property -dict { PACKAGE_PIN D4    IOSTANDARD LVCMOS33 } [get_ports { usb_ps2_data }]; #IO_L11N_T1_SRCC_35 Sch=jd[1]
#set_property -dict { PACKAGE_PIN D3    IOSTANDARD LVCMOS33 } [get_ports { jd[1] }]; #IO_L12N_T1_MRCC_35 Sch=jd[2]
set_property -dict { PACKAGE_PIN F4    IOSTANDARD LVCMOS33 } [get_ports { usb_ps2_clk  }]; #IO_L13P_T2_MRCC_35 Sch=jd[3]
#set_property -dict { PACKAGE_PIN F3    IOSTANDARD LVCMOS33 } [get_ports { jd[3] }]; #IO_L13N_T2_MRCC_35 Sch=jd[4]
set_property -dict { PACKAGE_PIN E2    IOSTANDARD LVCMOS33 } [get_ports { pmod_ps2_data }]; #IO_L14P_T2_SRCC_35 Sch=jd[7]
#set_property -dict { PACKAGE_PIN D2    IOSTANDARD LVCMOS33 } [get_ports { jd[5] }]; #IO_L14N_T2_SRCC_35 Sch=jd[8]
set_property -dict { PACKAGE_PIN H2    IOSTANDARD LVCMOS33 } [get_ports { pmod_ps2_clk }]; #IO_L15P_T2_DQS_35 Sch=jd[9]
#set_property -dict { PACKAGE_PIN G2    IOSTANDARD LVCMOS33 } [get_ports { jd[7] }]; #IO_L15N_T2_DQS_35 Sch=jd[10]

## ChipKit Outer Digital Header
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports { w_btnu }]; #IO_L16P_T2_CSI_B_14 Sch=ck_io[0]
set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33 } [get_ports { w_btnd }]; #IO_L18P_T2_A12_D28_14 Sch=ck_io[1]
set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports { w_btnl }]; #IO_L8N_T1_D12_14 Sch=ck_io[2]
set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS33 } [get_ports { w_btnr }]; #IO_L19P_T3_A10_D26_14 Sch=ck_io[3]
set_property -dict { PACKAGE_PIN R12   IOSTANDARD LVCMOS33 } [get_ports { w_btnc }]; #IO_L5P_T0_D06_14 Sch=ck_io[4]
#set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33 } [get_ports { }]; #IO_L14P_T2_SRCC_14 Sch=ck_io[5]
#set_property -dict { PACKAGE_PIN T15   IOSTANDARD LVCMOS33 } [get_ports { }]; #IO_L14N_T2_SRCC_14 Sch=ck_io[6]
#set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports { }]; #IO_L15N_T2_DQS_DOUT_CSO_B_14 Sch=ck_io[7]
#set_property -dict { PACKAGE_PIN N15   IOSTANDARD LVCMOS33 } [get_ports { }]; #IO_L11P_T1_SRCC_14 Sch=ck_io[8]
#set_property -dict { PACKAGE_PIN M16   IOSTANDARD LVCMOS33 } [get_ports { }]; #IO_L10P_T1_D14_14 Sch=ck_io[9]
#set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports { }]; #IO_L18N_T2_A11_D27_14 Sch=ck_io[10]
#set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports { }]; #IO_L17N_T2_A13_D29_14 Sch=ck_io[11]
#set_property -dict { PACKAGE_PIN R17   IOSTANDARD LVCMOS33 } [get_ports { }]; #IO_L12N_T1_MRCC_14 Sch=ck_io[12]
#set_property -dict { PACKAGE_PIN P17   IOSTANDARD LVCMOS33 } [get_ports { }]; #IO_L12P_T1_MRCC_14 Sch=ck_io[13]

## ChipKit Inner Digital Header
set_property -dict { PACKAGE_PIN U11   IOSTANDARD LVCMOS33 } [get_ports { w_mdio_phy   }]; #IO_L19N_T3_A09_D25_VREF_14 Sch=ck_io[26]
set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { r_mdc_phy    }]; #IO_L16N_T2_A15_D31_14 Sch=ck_io[27]
set_property -dict { PACKAGE_PIN M13   IOSTANDARD LVCMOS33 } [get_ports { r_rstn_phy   }]; #IO_L6N_T0_D08_VREF_14 Sch=ck_io[28]
set_property -dict { PACKAGE_PIN R10   IOSTANDARD LVCMOS33 } [get_ports { w_crs_dv_phy }]; #IO_25_14 Sch=ck_io[29]
set_property -dict { PACKAGE_PIN R11   IOSTANDARD LVCMOS33 } [get_ports { w_txd_phy[0] }]; #IO_0_14 Sch=ck_io[30]
set_property -dict { PACKAGE_PIN R13   IOSTANDARD LVCMOS33 } [get_ports { w_txd_phy[1] }]; #IO_L5N_T0_D07_14 Sch=ck_io[31]
set_property -dict { PACKAGE_PIN R15   IOSTANDARD LVCMOS33 } [get_ports { w_txen_phy   }]; #IO_L13N_T2_MRCC_14 Sch=ck_io[32]
set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { w_rxd_phy[0] }]; #IO_L13P_T2_MRCC_14 Sch=ck_io[33]
set_property -dict { PACKAGE_PIN R16   IOSTANDARD LVCMOS33 } [get_ports { w_rxd_phy[1] }]; #IO_L15P_T2_DQS_RDWR_B_14 Sch=ck_io[34]
set_property -dict { PACKAGE_PIN N16   IOSTANDARD LVCMOS33 } [get_ports { w_rxerr_phy  }]; #IO_L11N_T1_SRCC_14 Sch=ck_io[35]
set_property -dict { PACKAGE_PIN N14   IOSTANDARD LVCMOS33 } [get_ports { w_clkin_phy  }]; #IO_L8P_T1_D11_14 Sch=ck_io[36]
#set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { ck_io37 }]; #IO_L17P_T2_A14_D30_14 Sch=ck_io[37]
#set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports { ck_io38 }]; #IO_L7N_T1_D10_14 Sch=ck_io[38]
#set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports { ck_io39 }]; #IO_L7P_T1_D09_14 Sch=ck_io[39]
#set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports { ck_io40 }]; #IO_L9N_T1_DQS_D13_14 Sch=ck_io[40]
#set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports { ck_io41 }]; #IO_L9P_T1_DQS_14 Sch=ck_io[41]

