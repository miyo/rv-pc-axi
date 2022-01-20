`default_nettype none

module DRAMController_AXI #(
`ifndef ARTYA7
                        parameter DDR2_DQ_WIDTH   = 16,
                        parameter DDR2_DQS_WIDTH  = 2,
                        parameter DDR2_ADDR_WIDTH = 13,
                        parameter DDR2_BA_WIDTH   = 3,
                        parameter DDR2_DM_WIDTH   = 2,
                        parameter APP_ADDR_WIDTH  = 27,
`else
                        parameter DDR3_DQ_WIDTH   = 16,
                        parameter DDR3_DQS_WIDTH  = 2,
                        parameter DDR3_ADDR_WIDTH = 14,
                        parameter DDR3_BA_WIDTH   = 3,
                        parameter DDR3_DM_WIDTH   = 2,
                        parameter APP_ADDR_WIDTH  = 28,
`endif
                        parameter APP_CMD_WIDTH   = 3,
                        parameter APP_DATA_WIDTH  = 128,
                        parameter APP_MASK_WIDTH  = 16)
    (
     // input clk, rst (active-low)
     input  wire                         sys_clk,
     input  wire                         sys_rst_x,
`ifdef ARTYA7
     input  wire                         ref_clk, 
`endif
     // memory interface ports
`ifndef ARTYA7
     inout  wire [DDR2_DQ_WIDTH-1 : 0]   ddr2_dq,
     inout  wire [DDR2_DQS_WIDTH-1 : 0]  ddr2_dqs_n,
     inout  wire [DDR2_DQS_WIDTH-1 : 0]  ddr2_dqs_p,
     output wire [DDR2_ADDR_WIDTH-1 : 0] ddr2_addr,
     output wire [DDR2_BA_WIDTH-1 : 0]   ddr2_ba,
     output wire                         ddr2_ras_n,
     output wire                         ddr2_cas_n,
     output wire                         ddr2_we_n,
     output wire [0:0]                   ddr2_ck_p,
     output wire [0:0]                   ddr2_ck_n,
     output wire [0:0]                   ddr2_cke,
     output wire [0:0]                   ddr2_cs_n,
     output wire [DDR2_DM_WIDTH-1 : 0]   ddr2_dm,
     output wire [0:0]                   ddr2_odt,
`else
     inout  wire [DDR3_DQ_WIDTH-1 : 0]   ddr3_dq,
     inout  wire [DDR3_DQS_WIDTH-1 : 0]  ddr3_dqs_n,
     inout  wire [DDR3_DQS_WIDTH-1 : 0]  ddr3_dqs_p,
     output wire [DDR3_ADDR_WIDTH-1 : 0] ddr3_addr,
     output wire [DDR3_BA_WIDTH-1 : 0]   ddr3_ba,
     output wire                         ddr3_ras_n,
     output wire                         ddr3_cas_n,
     output wire                         ddr3_we_n,
     output wire [0:0]                   ddr3_ck_p,
     output wire [0:0]                   ddr3_ck_n,
     output wire                         ddr3_reset_n,
     output wire [0:0]                   ddr3_cke,
     output wire [0:0]                   ddr3_cs_n,
     output wire [DDR3_DM_WIDTH-1 : 0]   ddr3_dm,
     output wire [0:0]                   ddr3_odt,
`endif
     // output clk, rst (active-low)
     output wire                         o_clk,
     output wire                         o_rst_x,
     // user interface ports
     (* mark_debug *) input  wire                         i_rd_en,
     (* mark_debug *) input  wire                         i_wr_en,
     (* mark_debug *) input  wire [APP_ADDR_WIDTH-1 : 0]  i_addr,
     (* mark_debug *) input  wire [APP_DATA_WIDTH-1 : 0]  i_data,
     (* mark_debug *) output wire                         o_init_calib_complete,
     (* mark_debug *) output wire [APP_DATA_WIDTH-1 : 0]  o_data,
     (* mark_debug *) output wire                         o_data_valid,
     (* mark_debug *) output wire                         o_ready,
     (* mark_debug *) output wire                         o_wdf_ready,
`ifndef ARTYA7
     input  wire [3:0]                   i_mask);
`else
     (* mark_debug *) input  wire [APP_MASK_WIDTH-1 : 0]  i_mask);
`endif

    localparam STATE_CALIB           = 3'b000;
    localparam STATE_IDLE            = 3'b001;
    localparam STATE_ISSUE_CMD_WDATA = 3'b010;
    localparam STATE_WAIT_WDATA_ACK  = 3'b011;
    localparam STATE_ISSUE_CMD_RDATA = 3'b100;

    localparam CMD_READ  = 3'b001;
    localparam CMD_WRITE = 3'b000;

    wire                        init_calib_complete;

    reg                         app_rdy;
    reg                         app_wdf_rdy;

    wire                        clk;
    wire                        rst;

    (* mark_debug *) reg [3:0] s_axi_awid;
    (* mark_debug *) reg [APP_ADDR_WIDTH-1:0] s_axi_awaddr;
    (* mark_debug *) reg [7:0] s_axi_awlen;
    (* mark_debug *) reg [2:0] s_axi_awsize;
    (* mark_debug *) reg [1:0] s_axi_awburst;
    (* mark_debug *) reg [0:0] s_axi_awlock;
    (* mark_debug *) reg [3:0] s_axi_awcache;
    (* mark_debug *) reg [2:0] s_axi_awprot;
    (* mark_debug *) reg [3:0] s_axi_awqos;
    (* mark_debug *) reg s_axi_awvalid;
    (* mark_debug *) wire s_axi_awready;

    (* mark_debug *) reg [APP_DATA_WIDTH-1:0] s_axi_wdata;
    (* mark_debug *) reg [APP_MASK_WIDTH-1:0] s_axi_wstrb;
    (* mark_debug *) reg s_axi_wlast;
    (* mark_debug *) reg s_axi_wvalid;
    (* mark_debug *) wire s_axi_wready;

    (* mark_debug *) wire [3:0] s_axi_bid;
    (* mark_debug *) wire [1:0] s_axi_bresp;
    (* mark_debug *) wire s_axi_bvalid;
    (* mark_debug *) wire s_axi_bready;

    (* mark_debug *) reg [3:0] s_axi_arid;
    (* mark_debug *) reg [APP_ADDR_WIDTH-1:0] s_axi_araddr;
    (* mark_debug *) reg [7:0] s_axi_arlen;
    (* mark_debug *) reg [2:0] s_axi_arsize;
    (* mark_debug *) reg [1:0] s_axi_arburst;
    (* mark_debug *) reg [0:0] s_axi_arlock;
    (* mark_debug *) reg [3:0] s_axi_arcache;
    (* mark_debug *) reg [2:0] s_axi_arprot;
    (* mark_debug *) reg [3:0] s_axi_arqos;
    (* mark_debug *) reg s_axi_arvalid;
    (* mark_debug *) wire s_axi_arready;

    (* mark_debug *) wire [3:0] s_axi_rid;
    (* mark_debug *) wire [APP_DATA_WIDTH-1:0] s_axi_rdata;
    (* mark_debug *) wire [1:0] s_axi_rresp;
    (* mark_debug *) wire s_axi_rlast;
    (* mark_debug *) wire s_axi_rvalid;
    (* mark_debug *) wire s_axi_rready;

    (* mark_debug *) reg  [2:0]                  state;

`ifndef ARTYA7
    reg  [3:0]                  data_mask = 0;
`else
    reg  [APP_MASK_WIDTH-1 : 0] data_mask = 0;
`endif

    assign o_clk = clk;
    assign o_rst_x = ~rst;

    assign o_init_calib_complete = init_calib_complete;

    assign o_data = s_axi_rdata;

    assign o_data_valid = s_axi_rvalid;

    assign o_ready = app_rdy;
    assign o_wdf_ready = app_wdf_rdy;

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

    .init_calib_complete            (init_calib_complete),  // output			init_calib_complete
    // Application interface ports
    .ui_clk                         (clk),  // output			ui_clk
    .ui_clk_sync_rst                (rst),  // output			ui_clk_sync_rst
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
    .sys_clk_i                      (sys_clk),
    // Reference Clock Ports
    .clk_ref_i                      (ref_clk),
    .device_temp_i                  (12'd0),  // input [11:0]			device_temp_i
    .sys_rst                        (sys_rst_x) // input sys_rst
    );

    assign s_axi_bready = 1'b1;
    assign s_axi_rready = 1'b1;

    always @(posedge clk) begin
        if (rst) begin
            state <= STATE_CALIB;
            data_mask <= 0;
	    app_rdy <= 0;
	    app_wdf_rdy <= 0;
	    s_axi_awvalid <= 1'b0;
	    s_axi_arvalid <= 1'b0;
	    s_axi_wvalid <= 1'b0;
        end else begin
            case (state)
                STATE_CALIB: begin
		    app_rdy <= 0;
		    app_wdf_rdy <= 0;
		    s_axi_awvalid <= 1'b0;
		    s_axi_arvalid <= 1'b0;
		    s_axi_wvalid <= 1'b0;
                    if (init_calib_complete) begin
                        state <= STATE_IDLE;
                    end
                end
                STATE_IDLE: begin
                    if (i_wr_en) begin
			s_axi_awid <= 4'b0000;
			s_axi_awaddr <= {i_addr, 1'b0};
			s_axi_awlen <= 8'd0; // 1-word
			s_axi_awsize <= 3'b100; // '100' = 16Byte, '011' = 8Byte, '010' = 4Byte, '001' = 2Byte, '000' = 1Byte
			s_axi_awburst <= 2'b00; // '00' = Fixed, '01' = Incr
			s_axi_awlock <= 1'b0; // '0' = normal, '1' = excluding
			s_axi_awcache <= 4'b0000;
			s_axi_awprot <= 3'b000;
			s_axi_awqos <= 4'b0000;
			s_axi_awvalid <= 1'b1;
			data_mask <= i_mask;
                        state <= STATE_ISSUE_CMD_WDATA;
			s_axi_wdata <= i_data;
			app_rdy <= 0;
			app_wdf_rdy <= 0;
                    end else if (i_rd_en) begin
			s_axi_arid <= 4'b0000;
			s_axi_araddr <= {i_addr, 1'b0};
			s_axi_arlen <= 8'd0; // 1-word
			s_axi_arsize <= 3'b100;
			s_axi_arburst <= 2'b00;
			s_axi_arlock <= 1'b0;
			s_axi_arcache <= 4'b0000;
			s_axi_arprot <= 3'b000;
			s_axi_arqos <= 4'b0000;
			s_axi_arvalid <= 1'b1;
                        state <= STATE_ISSUE_CMD_RDATA;
			app_rdy <= 0;
			app_wdf_rdy <= 0;
                    end else begin
			app_rdy <= 1;
			app_wdf_rdy <= 1;
		    end
                end
                STATE_ISSUE_CMD_WDATA: begin
		    if(s_axi_awready == 1'b1) begin
			s_axi_awvalid <= 1'b0;
			s_axi_wstrb <= ~data_mask;
			s_axi_wlast <= 1'b1;
			s_axi_wvalid <= 1'b1;
			state <= STATE_WAIT_WDATA_ACK;
		    end
		end
		STATE_WAIT_WDATA_ACK: begin
		    if(s_axi_wready == 1'b1) begin
			s_axi_wvalid <= 1'b0;
			state <= STATE_IDLE;
		    end
		end
		STATE_ISSUE_CMD_RDATA: begin
		    if(s_axi_arready == 1'b1) begin
			s_axi_arvalid <= 1'b0;
		    end
		    if(s_axi_rvalid == 1'b1) begin
			state <= STATE_IDLE;
		    end
		end
                default: begin
		    app_rdy <= 0;
		    app_wdf_rdy <= 0;
		    s_axi_awvalid <= 1'b0;
		    s_axi_arvalid <= 1'b0;
		    s_axi_wvalid <= 1'b0;
                    state <= STATE_IDLE;
                end
            endcase
        end
    end

endmodule

`default_nettype wire

