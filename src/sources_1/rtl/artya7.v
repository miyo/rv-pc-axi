`default_nettype none

`include "define.vh"

module artya7#(
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
              input  wire        CLK,
              input  wire        w_rxd,
              output wire        w_txd,

              output wire  [3:0] w_ledx,

              output wire        w_led1_B,
              output wire        w_led1_G,
              output wire        w_led1_R,

              inout  wire [15:0] ddr3_dq,    ///// for DRAM
              inout  wire  [1:0] ddr3_dqs_n, //
              inout  wire  [1:0] ddr3_dqs_p, //
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
              output wire  [1:0] ddr3_dm,    //
              output wire  [0:0] ddr3_odt,   //

              input  wire        w_btnu,
              input  wire        w_btnd,
              input  wire        w_btnl,
              input  wire        w_btnr,
              input  wire        w_btnc,
              output wire        w_mdio_phy,
              output wire        r_mdc_phy,
              output wire        r_rstn_phy,
              input  wire        w_crs_dv_phy,
              output wire  [1:0] w_txd_phy,
              output wire        w_txen_phy,
              input  wire  [1:0] w_rxd_phy,
              input  wire        w_rxerr_phy,
              output wire        w_clkin_phy,
              input  wire        sd_cd,
              output wire        sd_rst,
              output wire        sd_sclk,
              inout  wire        sd_cmd,
              inout  wire [ 3:0] sd_dat,
              output wire [ 3:0] vga_red,
              output wire [ 3:0] vga_green,
              output wire [ 3:0] vga_blue,
              output wire        vga_h_sync,
              output wire        vga_v_sync,
              inout  wire        usb_ps2_clk,
              inout  wire        usb_ps2_data,
`ifdef CH559_USB
              input  wire        ch559_rx
`else
              inout  wire        pmod_ps2_clk,
              inout  wire        pmod_ps2_data
`endif
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

    wire w_locked;
    wire RST_X_IN = 1;

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

    wire pix_clk;
    wire clk_100mhz = CLK;
    clk_wiz_3 m_clkgen3 (.clk_in1(clk_100mhz), .reset(), .clk_out1(pix_clk), .locked());

    wire mig_clk, ref_clk;
    clk_wiz_0 m_clkgen0 (.clk_in1(CLK), .resetn(RST_X_IN), .clk_out1(), .clk_out2(ref_clk), .clk_out3(mig_clk), .locked(w_locked));

    // 50MHz Clock for SD card and Ethernet
    wire clk_50mhz, w_locked_50mhz;
    clk_wiz_2 clkgen2 (.clk_in1(CLK), .resetn(RST_X_IN), .clk_out1(clk_50mhz), .locked(w_locked_50mhz));

    wire RST        = ~w_locked || ~w_locked_50mhz;
    //////////////////////////////////////

    wire [15:0] w_led;
    assign w_ledx = w_led[3:0];//w_insn_data[3:0];

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
      .clk_100mhz(clk_100mhz),
      .clk_50mhz(clk_50mhz),
      .pix_clk(pix_clk),
      .mig_clk(mig_clk),

      .w_led(w_led),
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

      .w_btnu(w_btnu),
      .w_btnd(w_btnd),
      .w_btnl(w_btnl),
      .w_btnr(w_btnr),
      .w_btnc(w_btnc),
      .w_mdio_phy(w_mdio_phy),
      .r_mdc_phy(r_mdc_phy),
      .r_rstn_phy(r_rstn_phy),
      .w_crs_dv_phy(w_crs_dv_phy),
      .w_txd_phy(w_txd_phy),
      .w_txen_phy(w_txen_phy),
      .w_rxd_phy(w_rxd_phy),
      .w_rxerr_phy(w_rxerr_phy),
      .w_clkin_phy(w_clkin_phy),
      .sd_cd(sd_cd),
      .sd_rst(sd_rst),
      .sd_sclk(sd_sclk),
      .sd_cmd(sd_cmd),
      .sd_dat(sd_dat),
      .vga_red(vga_red),
      .vga_green(vga_green),
      .vga_blue(vga_blue),
      .vga_h_sync(vga_h_sync),
      .vga_v_sync(vga_v_sync),
      .usb_ps2_clk(usb_ps2_clk),
      .usb_ps2_data(usb_ps2_data),
`ifdef CH559_USB
      .ch559_rx(ch559_rx),
`else
      .pmod_ps2_clk(pmod_ps2_clk),
      .pmod_ps2_data(pmod_ps2_data)
`endif
      );

  mig_7series_0_axi u_mig_7series_0_axi (

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
    // System Clock Ports
    .sys_clk_i                      (mig_clk),
    // Reference Clock Ports
    .clk_ref_i                      (ref_clk),
    .device_temp_i                  (12'd0),  // input [11:0]			device_temp_i
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

endmodule // artya7
