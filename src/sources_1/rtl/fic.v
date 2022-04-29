`default_nettype none

`include "define.vh"

module fic#(
	    parameter APP_ADDR_WIDTH  = 28,
	    parameter APP_CMD_WIDTH   = 3,
	    parameter APP_DATA_WIDTH  = 128,  // Note
	    parameter APP_MASK_WIDTH  = 16)
    (
     input wire FGCK_P,
     input wire FGCK_N,
     
     input wire c0_sys_clk_p,
     input wire c0_sys_clk_n,
     output wire [16:0] c0_ddr4_adr,
     output wire [1:0] c0_ddr4_ba,
     output wire [1:0] c0_ddr4_cke,
     output wire [1:0] c0_ddr4_cs_n,
     inout wire [8:0] c0_ddr4_dm_dbi_n,
     inout wire [71:0] c0_ddr4_dq,
     inout wire [8:0] c0_ddr4_dqs_c,
     inout wire [8:0] c0_ddr4_dqs_t,
     output wire [1:0] c0_ddr4_odt,
     output wire [1:0] c0_ddr4_bg,
     output wire c0_ddr4_reset_n,
     output wire c0_ddr4_act_n,
     output wire [1:0] c0_ddr4_ck_c,
     output wire [1:0] c0_ddr4_ck_t,
     
     input  wire        uart_rx,
     output wire        uart_tx,
     
     input  wire        sd_cd,
     output wire        sd_rst,
     output wire        sd_sclk,
     inout  wire        sd_cmd,
     inout  wire [ 3:0] sd_dat,

     output wire level_conv_oe,
     
     output wire        led0,
     output wire        led1
     );

    assign level_conv_oe = 1'b1;
  
    // Clock
    //////////////////////////////////////
    wire mig_ui_clk;
    wire mig_ui_rst;
    wire CORE_CLK;
    wire RST_X2;
    wire clkgen1_clk;
    wire clkgen1_rst_x;
    wire clkgen1_locked;
    wire clkgen1_rst_x_async;
    reg  clkgen1_rst_x_sync1;
    reg  clkgen1_rst_x_sync2;

    wire CLK;
    wire w_locked;
    wire RST_X_IN = 1;

    clk_wiz_0 clk_wiz_0_i
      (
       // Clock out ports
       .clk_out1(CLK), // output clk_out1
       // Status and control signals
       .reset(1'b0), // input reset
       .locked(w_locked),    // output locked
       // Clock in ports
       .clk_in1_p(FGCK_P), // input clk_in1_p
       .clk_in1_n(FGCK_N)  // input clk_in1_n
       );

    clk_wiz_1 clkgen1 (
                       .clk_in1(mig_ui_clk),
                       .resetn(~mig_ui_rst),
                       .clk_out1(clkgen1_clk),
                       .locked(clkgen1_locked));

    assign clkgen1_rst_x_async = (~mig_ui_rst) & clkgen1_locked;
    assign clkgen1_rst_x = clkgen1_rst_x_sync2;

    always @(posedge clkgen1_clk or negedge clkgen1_rst_x_async) begin
        if (!clkgen1_rst_x_async) begin
            clkgen1_rst_x_sync1 <= 1'b0;
            clkgen1_rst_x_sync2 <= 1'b0;
        end else begin
            clkgen1_rst_x_sync1 <= 1'b1;
            clkgen1_rst_x_sync2 <= clkgen1_rst_x_sync1;
        end
    end
    assign CORE_CLK = clkgen1_clk;
    assign RST_X2 = clkgen1_rst_x;

    // 50MHz Clock for SD card and Ethernet
    wire clk_50mhz, w_locked_50mhz;
    clk_wiz_2 clkgen2 (.clk_in1(CLK), .resetn(RST_X_IN), .clk_out1(clk_50mhz), .locked(w_locked_50mhz));

    wire pix_clk;
    wire clk_100mhz = CLK;
    clk_wiz_3 m_clkgen3 (.clk_in1(clk_100mhz), .reset(1'b0), .clk_out1(pix_clk), .locked());

    wire RST        = ~w_locked || ~w_locked_50mhz;
    //////////////////////////////////////

    wire [3:0] s_axi_awid;
    wire [APP_ADDR_WIDTH-1:0] s_axi_awaddr;
    wire [7:0] s_axi_awlen;
    wire [2:0] s_axi_awsize;
    wire [1:0] s_axi_awburst;
    wire [0:0] s_axi_awlock;
    wire [3:0] s_axi_awcache;
    wire [2:0] s_axi_awprot;
    wire [3:0] s_axi_awqos;
    wire s_axi_awvalid;
    wire s_axi_awready;
    
    wire [APP_DATA_WIDTH-1:0] s_axi_wdata;
    wire [APP_MASK_WIDTH-1:0] s_axi_wstrb;
    wire s_axi_wlast;
    wire s_axi_wvalid;
    wire s_axi_wready;
    
    wire [3:0] s_axi_bid;
    wire [1:0] s_axi_bresp;
    wire s_axi_bvalid;
    wire s_axi_bready;
    
    wire [3:0] s_axi_arid;
    wire [APP_ADDR_WIDTH-1:0] s_axi_araddr;
    wire [7:0] s_axi_arlen;
    wire [2:0] s_axi_arsize;
    wire [1:0] s_axi_arburst;
    wire [0:0] s_axi_arlock;
    wire [3:0] s_axi_arcache;
    wire [2:0] s_axi_arprot;
    wire [3:0] s_axi_arqos;
    wire s_axi_arvalid;
    wire s_axi_arready;
    
    wire [3:0] s_axi_rid;
    wire [APP_DATA_WIDTH-1:0] s_axi_rdata;
    wire [1:0] s_axi_rresp;
    wire s_axi_rlast;
    wire s_axi_rvalid;
    wire s_axi_rready;
    
    wire dram_init_calib_complete;
    wire calib_done;

    wire        w_led1_B;
    wire        w_led1_G;
    wire        w_led1_R;

    assign led0 = w_led1_G;
    assign led1 = w_led1_B | w_led1_R;

    m_main#(
            .APP_ADDR_WIDTH(APP_ADDR_WIDTH),
	    .APP_CMD_WIDTH(APP_CMD_WIDTH),
            .APP_DATA_WIDTH(APP_DATA_WIDTH),
            .APP_MASK_WIDTH(APP_MASK_WIDTH))
    m(
      .CLK(CLK),
      .RST(RST),

      .w_rxd(uart_rx),
      .w_txd(uart_tx),

      .CORE_CLK(CORE_CLK),
      .RST_X2(RST_X2),
      .clk_100mhz(clk_100mhz),
      .clk_50mhz(clk_50mhz),
      .pix_clk(pix_clk),

      .w_led(),
      .r_sg(),
      .r_an(),

      .w_led1_B(w_led1_B),
      .w_led1_G(w_led1_G),
      .w_led1_R(w_led1_R),

      .s_axi_awid                     (s_axi_awid),  // input [3:0]			s_axi_awid
      .s_axi_awaddr                   (s_axi_awaddr),  // input [27:0]			s_axi_awaddr
      .s_axi_awlen                    (s_axi_awlen),  // input [7:0]			s_axi_awlen
      .s_axi_awsize                   (s_axi_awsize),  // input [2:0]			s_axi_awsize
      .s_axi_awburst                  (s_axi_awburst),  // input [1:0]			s_axi_awburst
      .s_axi_awlock                   (s_axi_awlock),  // input [0:0]			s_axi_awlock
      .s_axi_awcache                  (s_axi_awcache),  // input [3:0]			s_axi_awcache
      .s_axi_awprot                   (s_axi_awprot),  // input [2:0]			s_axi_awprot
      .s_axi_awqos                    (s_axi_awqos),  // input [3:0]			s_axi_awqos
      .s_axi_awvalid                  (s_axi_awvalid),  // input			s_axi_awvalid
      .s_axi_awready                  (s_axi_awready),  // output			s_axi_awready
      // Slave Interface Write Data Ports
      .s_axi_wdata                    (s_axi_wdata),  // input [127:0]			s_axi_wdata
      .s_axi_wstrb                    (s_axi_wstrb),  // input [15:0]			s_axi_wstrb
      .s_axi_wlast                    (s_axi_wlast),  // input			s_axi_wlast
      .s_axi_wvalid                   (s_axi_wvalid),  // input			s_axi_wvalid
      .s_axi_wready                   (s_axi_wready),  // output			s_axi_wready
      // Slave Interface Write Response Ports
      .s_axi_bid                      (s_axi_bid),  // output [3:0]			s_axi_bid
      .s_axi_bresp                    (s_axi_bresp),  // output [1:0]			s_axi_bresp
      .s_axi_bvalid                   (s_axi_bvalid),  // output			s_axi_bvalid
      .s_axi_bready                   (s_axi_bready),  // input			s_axi_bready
      // Slave Interface Read Address Ports
      .s_axi_arid                     (s_axi_arid),  // input [3:0]			s_axi_arid
      .s_axi_araddr                   (s_axi_araddr),  // input [27:0]			s_axi_araddr
      .s_axi_arlen                    (s_axi_arlen),  // input [7:0]			s_axi_arlen
      .s_axi_arsize                   (s_axi_arsize),  // input [2:0]			s_axi_arsize
      .s_axi_arburst                  (s_axi_arburst),  // input [1:0]			s_axi_arburst
      .s_axi_arlock                   (s_axi_arlock),  // input [0:0]			s_axi_arlock
      .s_axi_arcache                  (s_axi_arcache),  // input [3:0]			s_axi_arcache
      .s_axi_arprot                   (s_axi_arprot),  // input [2:0]			s_axi_arprot
      .s_axi_arqos                    (s_axi_arqos),  // input [3:0]			s_axi_arqos
      .s_axi_arvalid                  (s_axi_arvalid),  // input			s_axi_arvalid
      .s_axi_arready                  (s_axi_arready),  // output			s_axi_arready
      // Slave Interface Read Data Ports
      .s_axi_rid                      (s_axi_rid),  // output [3:0]			s_axi_rid
      .s_axi_rdata                    (s_axi_rdata),  // output [127:0]			s_axi_rdata
      .s_axi_rresp                    (s_axi_rresp),  // output [1:0]			s_axi_rresp
      .s_axi_rlast                    (s_axi_rlast),  // output			s_axi_rlast
      .s_axi_rvalid                   (s_axi_rvalid),  // output			s_axi_rvalid
      .s_axi_rready                   (s_axi_rready),  // input			s_axi_rready
      .mig_ui_clk(mig_ui_clk),
      .mig_ui_rst_x(~mig_ui_rst),
      .dram_init_calib_complete(dram_init_calib_complete),
      .calib_done(calib_done),

      .w_btnu(1'b0),
      .w_btnd(1'b0),
      .w_btnl(1'b0),
      .w_btnr(1'b0),
      .w_btnc(1'b0),
      .w_mdio_phy(),
      .r_mdc_phy(),
      .r_rstn_phy(),
      .w_crs_dv_phy(1'b0),
      .w_txd_phy(),
      .w_txen_phy(),
      .w_rxd_phy(2'b00),
      .w_rxerr_phy(1'b0),
      .w_clkin_phy(),
      .sd_cd(sd_cd),
      .sd_rst(sd_rst),
      .sd_sclk(sd_sclk),
      .sd_cmd(sd_cmd),
      .sd_dat(sd_dat),
      .vga_red(),
      .vga_green(),
      .vga_blue(),
      .vga_h_sync(),
      .vga_v_sync(),
      .usb_ps2_clk(),
      .usb_ps2_data(),
`ifdef CH559_USB
      .ch559_rx(1'b0),
`else
      .pmod_ps2_clk(),
      .pmod_ps2_data()
`endif
      );

    wire dbg_clk;
    wire [511:0] dbg_bus;

    wire c0_ddr4_aresetn;
    // ctrl
    wire c0_ddr4_s_axi_ctrl_awvalid;
    wire c0_ddr4_s_axi_ctrl_awready;
    wire [31:0] c0_ddr4_s_axi_ctrl_awaddr;
    wire c0_ddr4_s_axi_ctrl_wvalid;
    wire c0_ddr4_s_axi_ctrl_wready;
    wire [31:0] c0_ddr4_s_axi_ctrl_wdata;
    wire c0_ddr4_s_axi_ctrl_bvalid;
    wire c0_ddr4_s_axi_ctrl_bready;
    wire [1:0] c0_ddr4_s_axi_ctrl_bresp;
    wire c0_ddr4_s_axi_ctrl_arvalid;
    wire c0_ddr4_s_axi_ctrl_arready;
    wire [31:0] c0_ddr4_s_axi_ctrl_araddr;
    wire c0_ddr4_s_axi_ctrl_rvalid;
    wire c0_ddr4_s_axi_ctrl_rready;
    wire [31:0] c0_ddr4_s_axi_ctrl_rdata;
    wire [1:0] c0_ddr4_s_axi_ctrl_rresp;
    wire c0_ddr4_interrupt;

    wire sys_rst;

    ddr4_0 ddr4_0_i (
		     .c0_init_calib_complete(dram_init_calib_complete),          // output wire c0_init_calib_complete
		     .dbg_clk(dbg_clk),                                        // output wire dbg_clk
		     .dbg_bus(dbg_bus),                                        // output wire [511 : 0] dbg_bus
		     .c0_sys_clk_p(c0_sys_clk_p),                              // input wire c0_sys_clk_p
		     .c0_sys_clk_n(c0_sys_clk_n),                              // input wire c0_sys_clk_n
		     .c0_ddr4_adr(c0_ddr4_adr),                                // output wire [16 : 0] c0_ddr4_adr
		     .c0_ddr4_ba(c0_ddr4_ba),                                  // output wire [1 : 0] c0_ddr4_ba
		     .c0_ddr4_cke(c0_ddr4_cke),                                // output wire [1 : 0] c0_ddr4_cke
		     .c0_ddr4_cs_n(c0_ddr4_cs_n),                              // output wire [1 : 0] c0_ddr4_cs_n
		     .c0_ddr4_dm_dbi_n(c0_ddr4_dm_dbi_n),                      // inout wire [8 : 0] c0_ddr4_dm_dbi_n
		     .c0_ddr4_dq(c0_ddr4_dq),                                  // inout wire [71 : 0] c0_ddr4_dq
		     .c0_ddr4_dqs_c(c0_ddr4_dqs_c),                            // inout wire [8 : 0] c0_ddr4_dqs_c
		     .c0_ddr4_dqs_t(c0_ddr4_dqs_t),                            // inout wire [8 : 0] c0_ddr4_dqs_t
		     .c0_ddr4_odt(c0_ddr4_odt),                                // output wire [1 : 0] c0_ddr4_odt
		     .c0_ddr4_bg(c0_ddr4_bg),                                  // output wire [1 : 0] c0_ddr4_bg
		     .c0_ddr4_reset_n(c0_ddr4_reset_n),                        // output wire c0_ddr4_reset_n
		     .c0_ddr4_act_n(c0_ddr4_act_n),                            // output wire c0_ddr4_act_n
		     .c0_ddr4_ck_c(c0_ddr4_ck_c),                              // output wire [1 : 0] c0_ddr4_ck_c
		     .c0_ddr4_ck_t(c0_ddr4_ck_t),                              // output wire [1 : 0] c0_ddr4_ck_t
		     .c0_ddr4_ui_clk(mig_ui_clk),                          // output wire c0_ddr4_ui_clk
		     .c0_ddr4_ui_clk_sync_rst(mig_ui_rst),        // output wire c0_ddr4_ui_clk_sync_rst
		     .c0_ddr4_aresetn(c0_ddr4_aresetn),                        // input wire c0_ddr4_aresetn
		     .c0_ddr4_s_axi_ctrl_awvalid(c0_ddr4_s_axi_ctrl_awvalid),  // input wire c0_ddr4_s_axi_ctrl_awvalid
		     .c0_ddr4_s_axi_ctrl_awready(c0_ddr4_s_axi_ctrl_awready),  // output wire c0_ddr4_s_axi_ctrl_awready
		     .c0_ddr4_s_axi_ctrl_awaddr(c0_ddr4_s_axi_ctrl_awaddr),    // input wire [31 : 0] c0_ddr4_s_axi_ctrl_awaddr
		     .c0_ddr4_s_axi_ctrl_wvalid(c0_ddr4_s_axi_ctrl_wvalid),    // input wire c0_ddr4_s_axi_ctrl_wvalid
		     .c0_ddr4_s_axi_ctrl_wready(c0_ddr4_s_axi_ctrl_wready),    // output wire c0_ddr4_s_axi_ctrl_wready
		     .c0_ddr4_s_axi_ctrl_wdata(c0_ddr4_s_axi_ctrl_wdata),      // input wire [31 : 0] c0_ddr4_s_axi_ctrl_wdata
		     .c0_ddr4_s_axi_ctrl_bvalid(c0_ddr4_s_axi_ctrl_bvalid),    // output wire c0_ddr4_s_axi_ctrl_bvalid
		     .c0_ddr4_s_axi_ctrl_bready(c0_ddr4_s_axi_ctrl_bready),    // input wire c0_ddr4_s_axi_ctrl_bready
		     .c0_ddr4_s_axi_ctrl_bresp(c0_ddr4_s_axi_ctrl_bresp),      // output wire [1 : 0] c0_ddr4_s_axi_ctrl_bresp
		     .c0_ddr4_s_axi_ctrl_arvalid(c0_ddr4_s_axi_ctrl_arvalid),  // input wire c0_ddr4_s_axi_ctrl_arvalid
		     .c0_ddr4_s_axi_ctrl_arready(c0_ddr4_s_axi_ctrl_arready),  // output wire c0_ddr4_s_axi_ctrl_arready
		     .c0_ddr4_s_axi_ctrl_araddr(c0_ddr4_s_axi_ctrl_araddr),    // input wire [31 : 0] c0_ddr4_s_axi_ctrl_araddr
		     .c0_ddr4_s_axi_ctrl_rvalid(c0_ddr4_s_axi_ctrl_rvalid),    // output wire c0_ddr4_s_axi_ctrl_rvalid
		     .c0_ddr4_s_axi_ctrl_rready(c0_ddr4_s_axi_ctrl_rready),    // input wire c0_ddr4_s_axi_ctrl_rready
		     .c0_ddr4_s_axi_ctrl_rdata(c0_ddr4_s_axi_ctrl_rdata),      // output wire [31 : 0] c0_ddr4_s_axi_ctrl_rdata
		     .c0_ddr4_s_axi_ctrl_rresp(c0_ddr4_s_axi_ctrl_rresp),      // output wire [1 : 0] c0_ddr4_s_axi_ctrl_rresp
		     .c0_ddr4_interrupt(c0_ddr4_interrupt),                    // output wire c0_ddr4_interrupt
		     .c0_ddr4_s_axi_awid(s_axi_awid),                  // input wire [7 : 0] c0_ddr4_s_axi_awid
		     .c0_ddr4_s_axi_awaddr({6'b0, s_axi_awaddr}),              // input wire [33 : 0] c0_ddr4_s_axi_awaddr
		     .c0_ddr4_s_axi_awlen(s_axi_awlen),                // input wire [7 : 0] c0_ddr4_s_axi_awlen
		     .c0_ddr4_s_axi_awsize(s_axi_awsize),              // input wire [2 : 0] c0_ddr4_s_axi_awsize
		     .c0_ddr4_s_axi_awburst(s_axi_awburst),            // input wire [1 : 0] c0_ddr4_s_axi_awburst
		     .c0_ddr4_s_axi_awlock(s_axi_awlock),              // input wire [0 : 0] c0_ddr4_s_axi_awlock
		     .c0_ddr4_s_axi_awcache(s_axi_awcache),            // input wire [3 : 0] c0_ddr4_s_axi_awcache
		     .c0_ddr4_s_axi_awprot(s_axi_awprot),              // input wire [2 : 0] c0_ddr4_s_axi_awprot
		     .c0_ddr4_s_axi_awqos(s_axi_awqos),                // input wire [3 : 0] c0_ddr4_s_axi_awqos
		     .c0_ddr4_s_axi_awvalid(s_axi_awvalid),            // input wire c0_ddr4_s_axi_awvalid
		     .c0_ddr4_s_axi_awready(s_axi_awready),            // output wire c0_ddr4_s_axi_awready
		     .c0_ddr4_s_axi_wdata(s_axi_wdata),                // input wire [127 : 0] c0_ddr4_s_axi_wdata
		     .c0_ddr4_s_axi_wstrb(s_axi_wstrb),                // input wire [15 : 0] c0_ddr4_s_axi_wstrb
		     .c0_ddr4_s_axi_wlast(s_axi_wlast),                // input wire c0_ddr4_s_axi_wlast
		     .c0_ddr4_s_axi_wvalid(s_axi_wvalid),              // input wire c0_ddr4_s_axi_wvalid
		     .c0_ddr4_s_axi_wready(s_axi_wready),              // output wire c0_ddr4_s_axi_wready
		     .c0_ddr4_s_axi_bready(s_axi_bready),              // input wire c0_ddr4_s_axi_bready
		     .c0_ddr4_s_axi_bid({4'b0, s_axi_bid}),            // output wire [7 : 0] c0_ddr4_s_axi_bid
		     .c0_ddr4_s_axi_bresp(s_axi_bresp),                // output wire [1 : 0] c0_ddr4_s_axi_bresp
		     .c0_ddr4_s_axi_bvalid(s_axi_bvalid),              // output wire c0_ddr4_s_axi_bvalid
		     .c0_ddr4_s_axi_arid(s_axi_arid),                  // input wire [7 : 0] c0_ddr4_s_axi_arid
		     .c0_ddr4_s_axi_araddr({6'b0, s_axi_araddr}),      // input wire [33 : 0] c0_ddr4_s_axi_araddr
		     .c0_ddr4_s_axi_arlen(s_axi_arlen),                // input wire [7 : 0] c0_ddr4_s_axi_arlen
		     .c0_ddr4_s_axi_arsize(s_axi_arsize),              // input wire [2 : 0] c0_ddr4_s_axi_arsize
		     .c0_ddr4_s_axi_arburst(s_axi_arburst),            // input wire [1 : 0] c0_ddr4_s_axi_arburst
		     .c0_ddr4_s_axi_arlock(s_axi_arlock),              // input wire [0 : 0] c0_ddr4_s_axi_arlock
		     .c0_ddr4_s_axi_arcache(s_axi_arcache),            // input wire [3 : 0] c0_ddr4_s_axi_arcache
		     .c0_ddr4_s_axi_arprot(s_axi_arprot),              // input wire [2 : 0] c0_ddr4_s_axi_arprot
		     .c0_ddr4_s_axi_arqos(s_axi_arqos),                // input wire [3 : 0] c0_ddr4_s_axi_arqos
		     .c0_ddr4_s_axi_arvalid(s_axi_arvalid),            // input wire c0_ddr4_s_axi_arvalid
		     .c0_ddr4_s_axi_arready(s_axi_arready),            // output wire c0_ddr4_s_axi_arready
		     .c0_ddr4_s_axi_rready(s_axi_rready),              // input wire c0_ddr4_s_axi_rready
		     .c0_ddr4_s_axi_rlast(s_axi_rlast),                // output wire c0_ddr4_s_axi_rlast
		     .c0_ddr4_s_axi_rvalid(s_axi_rvalid),              // output wire c0_ddr4_s_axi_rvalid
		     .c0_ddr4_s_axi_rresp(s_axi_rresp),                // output wire [1 : 0] c0_ddr4_s_axi_rresp
		     .c0_ddr4_s_axi_rid({4'b0, s_axi_rid}),            // output wire [7 : 0] c0_ddr4_s_axi_rid
		     .c0_ddr4_s_axi_rdata(s_axi_rdata),                // output wire [127 : 0] c0_ddr4_s_axi_rdata
		     .sys_rst(sys_rst)                                 // input wire sys_rst
		     );

    reg reset = 1'b1;

    reg [31:0] counter = 32'h0;
    always @(posedge CLK) begin
	counter <= counter + 1;
	if(counter > 1000) begin
	    reset <= 1'b0;
	end
    end

    assign c0_ddr4_aresetn = ~reset;
    assign sys_rst = reset;

    assign c0_ddr4_s_axi_ctrl_awvalid = 1'b0;
    assign c0_ddr4_s_axi_ctrl_awaddr = 32'h0;
    assign c0_ddr4_s_axi_ctrl_wvalid = 1'b0;
    assign c0_ddr4_s_axi_ctrl_wdata = 32'h0;
    assign c0_ddr4_s_axi_ctrl_bready = 1'b1;
    assign c0_ddr4_s_axi_ctrl_arvalid = 1'b0;
    assign c0_ddr4_s_axi_ctrl_araddr = 32'h0;
    assign c0_ddr4_s_axi_ctrl_rready = 1'b1;

endmodule // artya7

`default_nettype wire
