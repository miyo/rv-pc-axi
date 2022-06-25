`default_nettype none

`include "define.vh"

module exstickge#(
               parameter DDR3_DQ_WIDTH   = 16,
               parameter DDR3_DQS_WIDTH  = 2,
               parameter DDR3_ADDR_WIDTH = 14,
               parameter DDR3_BA_WIDTH   = 3,
               parameter DDR3_DM_WIDTH   = 2,
               parameter APP_ADDR_WIDTH  = 28,
               parameter APP_CMD_WIDTH   = 3,
               parameter APP_DATA_WIDTH  = 128,  // Note
               parameter APP_MASK_WIDTH  = 16)
    (
              input  wire        CLK_P,
              input  wire        CLK_N,
              input  wire        w_rxd,
              output wire        w_txd,

              inout  wire  [7:0] ddr3_dq,    ///// for DRAM
              inout  wire  [0:0] ddr3_dqs_n, //
              inout  wire  [0:0] ddr3_dqs_p, //
              output wire [13:0] ddr3_addr,  //
              output wire  [2:0] ddr3_ba,    //
              output wire        ddr3_ras_n, //
              output wire        ddr3_cas_n, //
              output wire        ddr3_we_n,  //
              output wire  [0:0] ddr3_ck_p,  // 
              output wire  [0:0] ddr3_ck_n,  //
              output wire        ddr3_reset_n, //
              output wire  [0:0] ddr3_cke,   //
              output wire  [0:0] ddr3_cs_n,  //
              output wire  [0:0] ddr3_dm,    //
              output wire  [0:0] ddr3_odt,   //

              //output wire        w_mdio_phy,
              //output wire        w_mdc_phy,
              //input  wire        w_crs_dv_phy,
              //output wire  [1:0] w_txd_phy,
              //output wire        w_txen_phy,
              //input  wire  [1:0] w_rxd_phy,
              //input  wire        w_phy_clk,

              input  wire        sd_cd,
              output wire        sd_rst,
              output wire        sd_sclk,
              inout  wire        sd_cmd,
              inout  wire [ 3:0] sd_dat
              );

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

    IBUFDS ibufds_i(.O(CLK), .I(CLK_P), .IB(CLK_N));

    wire mig_clk;
    wire ref_clk;
    clk_wiz_0 clkgen0 (.clk_in1(CLK), .resetn(RST_X_IN), .clk_out1(mig_clk), .locked(w_locked));

    // mig_ui_clk = mig_clk / 2 = 310MHz / 2 = 155MHz
    // clkgen1_clk = 75MHz
    clk_wiz_1 clkgen1 (.clk_in1(mig_ui_clk), .resetn(~mig_ui_rst), .clk_out1(clkgen1_clk), .locked(clkgen1_locked));

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

    wire pix_clk; // 25.175
    clk_wiz_3 clkgen3 (.clk_in1(CLK), .reset(1'b0), .clk_out1(pix_clk), .locked());

    // 50MHz Clock for SD card
    wire clk_50mhz;
    wire w_locked_50mhz;
    clk_wiz_2 clkgen2 (.clk_in1(CLK), .resetn(RST_X_IN), .clk_out1(clk_50mhz), .clk_out2(ref_clk), .locked(w_locked_50mhz));

    wire RST        = ~w_locked || ~w_locked_50mhz;
    //////////////////////////////////////

    (* mark_debug *) wire [3:0] s_axi_awid;
    (* mark_debug *) wire [APP_ADDR_WIDTH-1:0] s_axi_awaddr;
    (* mark_debug *) wire [7:0] s_axi_awlen;
    (* mark_debug *) wire [2:0] s_axi_awsize;
    (* mark_debug *) wire [1:0] s_axi_awburst;
    (* mark_debug *) wire [0:0] s_axi_awlock;
    (* mark_debug *) wire [3:0] s_axi_awcache;
    (* mark_debug *) wire [2:0] s_axi_awprot;
    (* mark_debug *) wire [3:0] s_axi_awqos;
    (* mark_debug *) wire s_axi_awvalid;
    (* mark_debug *) wire s_axi_awready;
    (* mark_debug *) wire [APP_DATA_WIDTH-1:0] s_axi_wdata;
    (* mark_debug *) wire [APP_MASK_WIDTH-1:0] s_axi_wstrb;
    (* mark_debug *) wire s_axi_wlast;
    (* mark_debug *) wire s_axi_wvalid;
    (* mark_debug *) wire s_axi_wready;
    (* mark_debug *) wire [3:0] s_axi_bid;
    (* mark_debug *) wire [1:0] s_axi_bresp;
    (* mark_debug *) wire s_axi_bvalid;
    (* mark_debug *) wire s_axi_bready;    
    (* mark_debug *) wire [3:0] s_axi_arid;
    (* mark_debug *) wire [APP_ADDR_WIDTH-1:0] s_axi_araddr;
    (* mark_debug *) wire [7:0] s_axi_arlen;
    (* mark_debug *) wire [2:0] s_axi_arsize;
    (* mark_debug *) wire [1:0] s_axi_arburst;
    (* mark_debug *) wire [0:0] s_axi_arlock;
    (* mark_debug *) wire [3:0] s_axi_arcache;
    (* mark_debug *) wire [2:0] s_axi_arprot;
    (* mark_debug *) wire [3:0] s_axi_arqos;
    (* mark_debug *) wire s_axi_arvalid;
    (* mark_debug *) wire s_axi_arready;    
    (* mark_debug *) wire [3:0] s_axi_rid;
    (* mark_debug *) wire [APP_DATA_WIDTH-1:0] s_axi_rdata;
    (* mark_debug *) wire [1:0] s_axi_rresp;
    (* mark_debug *) wire s_axi_rlast;
    (* mark_debug *) wire s_axi_rvalid;
    (* mark_debug *) wire s_axi_rready;
    
    (* mark_debug *) wire dram_init_calib_complete;
    (* mark_debug *) wire calib_done;

    (* mark_debug *) wire [3:0]  s_conv_axi_awid;
    (* mark_debug *) wire [31:0] s_conv_axi_awaddr;
    (* mark_debug *) wire [7:0]  s_conv_axi_awlen;
    (* mark_debug *) wire [2:0]  s_conv_axi_awsize;
    (* mark_debug *) wire [1:0]  s_conv_axi_awburst;
    (* mark_debug *) wire [0:0]  s_conv_axi_awlock;
    (* mark_debug *) wire [3:0]  s_conv_axi_awcache;
    (* mark_debug *) wire [2:0]  s_conv_axi_awprot;
    (* mark_debug *) wire [3:0]  s_conv_axi_awqos;
    (* mark_debug *) wire        s_conv_axi_awvalid;
    (* mark_debug *) wire        s_conv_axi_awready;
    (* mark_debug *) wire [31:0] s_conv_axi_wdata;
    (* mark_debug *) wire [3:0]  s_conv_axi_wstrb;
    (* mark_debug *) wire        s_conv_axi_wlast;
    (* mark_debug *) wire        s_conv_axi_wvalid;
    (* mark_debug *) wire        s_conv_axi_wready;
    (* mark_debug *) wire [3:0]  s_conv_axi_bid;
    (* mark_debug *) wire [1:0]  s_conv_axi_bresp;
    (* mark_debug *) wire        s_conv_axi_bvalid;
    (* mark_debug *) wire        s_conv_axi_bready;
    (* mark_debug *) wire [3:0]  s_conv_axi_arid;
    (* mark_debug *) wire [31:0] s_conv_axi_araddr;
    (* mark_debug *) wire [7:0]  s_conv_axi_arlen;
    (* mark_debug *) wire [2:0]  s_conv_axi_arsize;
    (* mark_debug *) wire [1:0]  s_conv_axi_arburst;
    (* mark_debug *) wire [0:0]  s_conv_axi_arlock;
    (* mark_debug *) wire [3:0]  s_conv_axi_arcache;
    (* mark_debug *) wire [2:0]  s_conv_axi_arprot;
    (* mark_debug *) wire [3:0]  s_conv_axi_arqos;
    (* mark_debug *) wire        s_conv_axi_arvalid;
    (* mark_debug *) wire        s_conv_axi_arready;
    (* mark_debug *) wire [3:0]  s_conv_axi_rid;
    (* mark_debug *) wire [31:0] s_conv_axi_rdata;
    (* mark_debug *) wire [1:0]  s_conv_axi_rresp;
    (* mark_debug *) wire        s_conv_axi_rlast;
    (* mark_debug *) wire        s_conv_axi_rvalid;
    (* mark_debug *) wire        s_conv_axi_rready;

    m_main#(
            .APP_ADDR_WIDTH(APP_ADDR_WIDTH),
	    .APP_CMD_WIDTH(APP_CMD_WIDTH),
            .APP_DATA_WIDTH(APP_DATA_WIDTH),
            .APP_MASK_WIDTH(APP_MASK_WIDTH))
    m(
      .CLK(CLK),
      .RST(RST),

      .w_rxd(w_rxd),
      .w_txd(w_txd),

      .CORE_CLK(CORE_CLK),
      .RST_X2(RST_X2),
      .clk_50mhz(clk_50mhz),
      //.ether_clk(w_phy_clk),
      .ether_clk(clk_50mhz),
      .pix_clk(pix_clk),

      .w_led(),
      .r_sg(),
      .r_an(),

      .w_led1_B(),
      .w_led1_G(),
      .w_led1_R(),

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

      //.w_mdio_phy(w_mdio_phy),
      .w_mdio_phy(),
      //.r_mdc_phy(w_mdc_phy),
      .r_mdc_phy(),
      .r_rstn_phy(),
      //.w_crs_dv_phy(w_crs_dv_phy),
      .w_crs_dv_phy(1'b0),
      //.w_txd_phy(w_txd_phy),
      .w_txd_phy(),
      //.w_txen_phy(w_txen_phy),
      .w_txen_phy(),
      //.w_rxd_phy(w_rxd_phy),
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

  mig_7series_0 u_mig_7series_0 (

    // Memory interface ports
    .ddr3_addr                      (ddr3_addr),  // output [13:0]		ddr3_addr
    .ddr3_ba                        (ddr3_ba),  // output [2:0]		ddr3_ba
    .ddr3_cas_n                     (ddr3_cas_n),  // output			ddr3_cas_n
    .ddr3_ck_n                      (ddr3_ck_n),  // output [0:0]		ddr3_ck_n
    .ddr3_ck_p                      (ddr3_ck_p),  // output [0:0]		ddr3_ck_p
    .ddr3_cke                       (ddr3_cke),  // output [0:0]		ddr3_cke
    .ddr3_ras_n                     (ddr3_ras_n),  // output			ddr3_ras_n
    .ddr3_reset_n                   (ddr3_reset_n),  // output			ddr3_reset_n
    .ddr3_we_n                      (ddr3_we_n),  // output			ddr3_we_n
    .ddr3_dq                        (ddr3_dq),  // inout [15:0]		ddr3_dq
    .ddr3_dqs_n                     (ddr3_dqs_n),  // inout [1:0]		ddr3_dqs_n
    .ddr3_dqs_p                     (ddr3_dqs_p),  // inout [1:0]		ddr3_dqs_p
    .ddr3_cs_n                      (ddr3_cs_n),  // output [0:0]		ddr3_cs_n
    .ddr3_dm                        (ddr3_dm),  // output [1:0]		ddr3_dm
    .ddr3_odt                       (ddr3_odt),  // output [0:0]		ddr3_odt

    .init_calib_complete            (dram_init_calib_complete),  // output			init_calib_complete
    // Application interface ports
    .ui_clk                         (mig_ui_clk),  // output			ui_clk
    .ui_clk_sync_rst                (mig_ui_rst),  // output			ui_clk_sync_rst
    .mmcm_locked                    (),  // output			mmcm_locked
    .aresetn                        (1'b1),  // input			aresetn
    .app_sr_req                     (1'b0),  // input			app_sr_req
    .app_ref_req                    (1'b0),  // input			app_ref_req
    .app_zq_req                     (1'b0),  // input			app_zq_req
    .app_sr_active                  (),  // output			app_sr_active
    .app_ref_ack                    (),  // output			app_ref_ack
    .app_zq_ack                     (),  // output			app_zq_ack
    // Slave Interface Write Address Ports
    .s_axi_awid                     (s_conv_axi_awid),    // input [3:0]	s_axi_awid
    .s_axi_awaddr                   (s_conv_axi_awaddr),  // input [31:0]	s_axi_awaddr
    .s_axi_awlen                    (s_conv_axi_awlen),   // input [7:0]	s_axi_awlen
    .s_axi_awsize                   (s_conv_axi_awsize),  // input [2:0]	s_axi_awsize
    .s_axi_awburst                  (s_conv_axi_awburst), // input [1:0]	s_axi_awburst
    .s_axi_awlock                   (s_conv_axi_awlock),  // input [0:0]	s_axi_awlock
    .s_axi_awcache                  (s_conv_axi_awcache), // input [3:0]	s_axi_awcache
    .s_axi_awprot                   (s_conv_axi_awprot),  // input [2:0]	s_axi_awprot
    .s_axi_awqos                    (s_conv_axi_awqos),   // input [3:0]	s_axi_awqos
    .s_axi_awvalid                  (s_conv_axi_awvalid), // input		s_axi_awvalid
    .s_axi_awready                  (s_conv_axi_awready), // output		s_axi_awready
    // Slave Interface Write Data Ports
    .s_axi_wdata                    (s_conv_axi_wdata),  // input [31:0]	s_axi_wdata
    .s_axi_wstrb                    (s_conv_axi_wstrb),  // input [3:0]		s_axi_wstrb
    .s_axi_wlast                    (s_conv_axi_wlast),  // input		s_axi_wlast
    .s_axi_wvalid                   (s_conv_axi_wvalid), // input		s_axi_wvalid
    .s_axi_wready                   (s_conv_axi_wready), // output		s_axi_wready
    // Slave Interface Write Response conv_Ports
    .s_axi_bid                      (s_conv_axi_bid),    // output [3:0]	s_axi_bid
    .s_axi_bresp                    (s_conv_axi_bresp),  // output [1:0]	s_axi_bresp
    .s_axi_bvalid                   (s_conv_axi_bvalid), // output		s_axi_bvalid
    .s_axi_bready                   (s_conv_axi_bready), // input		s_axi_bready
    // Slave Interface Read Address Ports
    .s_axi_arid                     (s_conv_axi_arid),    // input [3:0]	s_axi_arid
    .s_axi_araddr                   (s_conv_axi_araddr),  // input [31:0]	s_axi_araddr
    .s_axi_arlen                    (s_conv_axi_arlen),   // input [7:0]	s_axi_arlen
    .s_axi_arsize                   (s_conv_axi_arsize),  // input [2:0]	s_axi_arsize
    .s_axi_arburst                  (s_conv_axi_arburst), // input [1:0]	s_axi_arburst
    .s_axi_arlock                   (s_conv_axi_arlock),  // input [0:0]	s_axi_arlock
    .s_axi_arcache                  (s_conv_axi_arcache), // input [3:0]	s_axi_arcache
    .s_axi_arprot                   (s_conv_axi_arprot),  // input [2:0]	s_axi_arprot
    .s_axi_arqos                    (s_conv_axi_arqos),   // input [3:0]	s_axi_arqos
    .s_axi_arvalid                  (s_conv_axi_arvalid), // input		s_axi_arvalid
    .s_axi_arready                  (s_conv_axi_arready), // output		s_axi_arready
    // Slave Interface Read Data Ports
    .s_axi_rid                      (s_conv_axi_rid),    // output [3:0]	s_axi_rid
    .s_axi_rdata                    (s_conv_axi_rdata),  // output [31:0]	s_axi_rdata
    .s_axi_rresp                    (s_conv_axi_rresp),  // output [1:0]	s_axi_rresp
    .s_axi_rlast                    (s_conv_axi_rlast),  // output		s_axi_rlast
    .s_axi_rvalid                   (s_conv_axi_rvalid), // output		s_axi_rvalid
    .s_axi_rready                   (s_conv_axi_rready), // input		s_axi_rready
    // System Clock Ports
    .sys_clk_i                      (mig_clk),
    // Reference Clock Ports
    .clk_ref_i                      (ref_clk),
    .sys_rst                        (!RST) // input sys_rst
    );

    // synchronize the calibration status signal: MIG -> MIPS core
    reg                         dram_init_calib_complete_sync1;
    reg                         dram_init_calib_complete_sync2;
    always @(posedge CORE_CLK) begin
        if (!RST_X2) begin
            dram_init_calib_complete_sync1 <= 1'b0;
            dram_init_calib_complete_sync2 <= 1'b0;
        end else begin
            dram_init_calib_complete_sync1 <= dram_init_calib_complete;
            dram_init_calib_complete_sync2 <= dram_init_calib_complete_sync1;
        end
    end
    assign calib_done = dram_init_calib_complete_sync2;

    axi_dwidth_converter_0 axi_dwidth_converter_0_i (
       .s_axi_aclk(mig_ui_clk),     // input wire s_axi_aclk
       .s_axi_aresetn(~mig_ui_rst), // input wire s_axi_aresetn
       .s_axi_awaddr(s_axi_awaddr[APP_ADDR_WIDTH-1:0]),      // input wire [31 : 0] s_axi_awaddr
       .s_axi_awlen(s_axi_awlen),        // input wire [7 : 0] s_axi_awlen
       .s_axi_awsize(s_axi_awsize),      // input wire [2 : 0] s_axi_awsize
       .s_axi_awburst(s_axi_awburst),    // input wire [1 : 0] s_axi_awburst
       .s_axi_awlock(s_axi_awlock),      // input wire [0 : 0] s_axi_awlock
       .s_axi_awcache(s_axi_awcache),    // input wire [3 : 0] s_axi_awcache
       .s_axi_awprot(s_axi_awprot),      // input wire [2 : 0] s_axi_awprot
       .s_axi_awregion(4'd0),            // input wire [3 : 0] s_axi_awregion
       .s_axi_awqos(s_axi_awqos),        // input wire [3 : 0] s_axi_awqos
       .s_axi_awvalid(s_axi_awvalid),    // input wire s_axi_awvalid
       .s_axi_awready(s_axi_awready),    // output wire s_axi_awready
       .s_axi_wdata(s_axi_wdata),        // input wire [127 : 0] s_axi_wdata
       .s_axi_wstrb(s_axi_wstrb),        // input wire [15 : 0] s_axi_wstrb
       .s_axi_wlast(s_axi_wlast),        // input wire s_axi_wlast
       .s_axi_wvalid(s_axi_wvalid),      // input wire s_axi_wvalid
       .s_axi_wready(s_axi_wready),      // output wire s_axi_wready
       .s_axi_bresp(s_axi_bresp),        // output wire [1 : 0] s_axi_bresp
       .s_axi_bvalid(s_axi_bvalid),      // output wire s_axi_bvalid
       .s_axi_bready(s_axi_bready),      // input wire s_axi_bready
       .s_axi_araddr(s_axi_araddr[APP_ADDR_WIDTH-1:0]),      // input wire [31 : 0] s_axi_araddr
       .s_axi_arlen(s_axi_arlen),        // input wire [7 : 0] s_axi_arlen
       .s_axi_arsize(s_axi_arsize),      // input wire [2 : 0] s_axi_arsize
       .s_axi_arburst(s_axi_arburst),    // input wire [1 : 0] s_axi_arburst
       .s_axi_arlock(s_axi_arlock),      // input wire [0 : 0] s_axi_arlock
       .s_axi_arcache(s_axi_arcache),    // input wire [3 : 0] s_axi_arcache
       .s_axi_arprot(s_axi_arprot),      // input wire [2 : 0] s_axi_arprot
       .s_axi_arregion(4'b0),            // input wire [3 : 0] s_axi_arregion
       .s_axi_arqos(s_axi_arqos),        // input wire [3 : 0] s_axi_arqos
       .s_axi_arvalid(s_axi_arvalid),    // input wire s_axi_arvalid
       .s_axi_arready(s_axi_arready),    // output wire s_axi_arready
       .s_axi_rdata(s_axi_rdata),        // output wire [127 : 0] s_axi_rdata
       .s_axi_rresp(s_axi_rresp),        // output wire [1 : 0] s_axi_rresp
       .s_axi_rlast(s_axi_rlast),        // output wire s_axi_rlast
       .s_axi_rvalid(s_axi_rvalid),      // output wire s_axi_rvalid
       .s_axi_rready(s_axi_rready),      // input wire s_axi_rready

       .m_axi_awaddr(s_conv_axi_awaddr[13:0]),      // output wire [31 : 0] m_axi_awaddr
       .m_axi_awlen(s_conv_axi_awlen),        // output wire [7 : 0] m_axi_awlen
       .m_axi_awsize(s_conv_axi_awsize),      // output wire [2 : 0] m_axi_awsize
       .m_axi_awburst(s_conv_axi_awburst),    // output wire [1 : 0] m_axi_awburst
       .m_axi_awlock(s_conv_axi_awlock),      // output wire [0 : 0] m_axi_awlock
       .m_axi_awcache(s_conv_axi_awcache),    // output wire [3 : 0] m_axi_awcache
       .m_axi_awprot(s_conv_axi_awprot),      // output wire [2 : 0] m_axi_awprot
       .m_axi_awregion(),                     // output wire [3 : 0] m_axi_awregion
       .m_axi_awqos(s_conv_axi_awqos),        // output wire [3 : 0] m_axi_awqos
       .m_axi_awvalid(s_conv_axi_awvalid),    // output wire m_axi_awvalid
       .m_axi_awready(s_conv_axi_awready),    // input wire m_axi_awready
       .m_axi_wdata(s_conv_axi_wdata),        // output wire [31 : 0] m_axi_wdata
       .m_axi_wstrb(s_conv_axi_wstrb),        // output wire [3 : 0] m_axi_wstrb
       .m_axi_wlast(s_conv_axi_wlast),        // output wire m_axi_wlast
       .m_axi_wvalid(s_conv_axi_wvalid),      // output wire m_axi_wvalid
       .m_axi_wready(s_conv_axi_wready),      // input wire m_axi_wready
       .m_axi_bresp(s_conv_axi_bresp),        // input wire [1 : 0] m_axi_bresp
       .m_axi_bvalid(s_conv_axi_bvalid),      // input wire m_axi_bvalid
       .m_axi_bready(s_conv_axi_bready),      // output wire m_axi_bready
       .m_axi_araddr(s_conv_axi_araddr[13:0]), // output wire [31 : 0] m_axi_araddr
       .m_axi_arlen(s_conv_axi_arlen),        // output wire [7 : 0] m_axi_arlen
       .m_axi_arsize(s_conv_axi_arsize),      // output wire [2 : 0] m_axi_arsize
       .m_axi_arburst(s_conv_axi_arburst),    // output wire [1 : 0] m_axi_arburst
       .m_axi_arlock(s_conv_axi_arlock),      // output wire [0 : 0] m_axi_arlock
       .m_axi_arcache(s_conv_axi_arcache),    // output wire [3 : 0] m_axi_arcache
       .m_axi_arprot(s_conv_axi_arprot),      // output wire [2 : 0] m_axi_arprot
       .m_axi_arregion(),                     // output wire [3 : 0] m_axi_arregion
       .m_axi_arqos(s_conv_axi_arqos),        // output wire [3 : 0] m_axi_arqos
       .m_axi_arvalid(s_conv_axi_arvalid),    // output wire m_axi_arvalid
       .m_axi_arready(s_conv_axi_arready),    // input wire m_axi_arready
       .m_axi_rdata(s_conv_axi_rdata),        // input wire [31 : 0] m_axi_rdata
       .m_axi_rresp(s_conv_axi_rresp),        // input wire [1 : 0] m_axi_rresp
       .m_axi_rlast(s_conv_axi_rlast),        // input wire m_axi_rlast
       .m_axi_rvalid(s_conv_axi_rvalid),      // input wire m_axi_rvalid
       .m_axi_rready(s_conv_axi_rready)       // output wire m_axi_rready
       );

    assign s_conv_axi_awaddr[31:14] = 0;
    assign s_conv_axi_araddr[31:14] = 0;

endmodule // exstickge

