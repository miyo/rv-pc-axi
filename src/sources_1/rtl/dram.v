/**************************************************************************************************/
/**** RVSoc (Mini Kuroda/RISC-V)                       since 2018-08-07   ArchLab. TokyoTech   ****/
/**** ALU Module v0.01                                                                         ****/
/**************************************************************************************************/
`default_nettype none
/**************************************************************************************************/
`include "define.vh"

/**************************************************************************************************/
/*** For Nexys A7 board ***************************************************************************/
module DRAM_con_without_cache #(
              parameter APP_ADDR_WIDTH  = 28,
              parameter APP_CMD_WIDTH   = 3,
              parameter APP_DATA_WIDTH  = 128,  // Note
              parameter APP_MASK_WIDTH  = 16)
    (

     // memory interface ports
     output wire [3:0] s_axi_awid,
     output wire [APP_ADDR_WIDTH-1:0] s_axi_awaddr,
     output wire [7:0] s_axi_awlen,
     output wire [2:0] s_axi_awsize,
     output wire [1:0] s_axi_awburst,
     output wire [0:0] s_axi_awlock,
     output wire [3:0] s_axi_awcache,
     output wire [2:0] s_axi_awprot,
     output wire [3:0] s_axi_awqos,
     output wire s_axi_awvalid,
     input wire s_axi_awready,

     output wire [APP_DATA_WIDTH-1:0] s_axi_wdata,
     output wire [APP_MASK_WIDTH-1:0] s_axi_wstrb,
     output wire s_axi_wlast,
     output wire s_axi_wvalid,
     input wire s_axi_wready,

     input wire [3:0] s_axi_bid,
     input wire [1:0] s_axi_bresp,
     input wire s_axi_bvalid,
     output wire s_axi_bready,

     output wire [3:0] s_axi_arid,
     output wire [APP_ADDR_WIDTH-1:0] s_axi_araddr,
     output wire [7:0] s_axi_arlen,
     output wire [2:0] s_axi_arsize,
     output wire [1:0] s_axi_arburst,
     output wire [0:0] s_axi_arlock,
     output wire [3:0] s_axi_arcache,
     output wire [2:0] s_axi_arprot,
     output wire [3:0] s_axi_arqos,
     output wire s_axi_arvalid,
     input wire s_axi_arready,

     input wire [3:0] s_axi_rid,
     input wire [APP_DATA_WIDTH-1:0] s_axi_rdata,
     input wire [1:0] s_axi_rresp,
     input wire s_axi_rlast,
     input wire s_axi_rvalid,
     output wire s_axi_rready,

     input wire mig_ui_clk,
     input wire mig_ui_rst_x,
     input wire dram_init_calib_complete,

     // output clk, rst (active-low)
     input wire                         i_clk,
     input wire                         i_rst_x,
     // user interface ports
     input  wire                         i_rd_en,
     input  wire                         i_wr_en,
     input  wire [31:0]                  i_addr,
     input  wire [31:0]                  i_data,
     input  wire                         i_init_calib_complete,
     output wire [127:0]                 o_data,
     output wire                         o_busy,
     input  wire [3:0]                   i_mask);

    wire                        dram_ren;
    wire                        dram_wen;
`ifndef ARTYA7
    wire [APP_ADDR_WIDTH-2 : 0] dram_addr;
`else
    wire [APP_ADDR_WIDTH-1 : 0] dram_addr;
`endif
    wire [APP_DATA_WIDTH-1 : 0] dram_din;
    wire [APP_DATA_WIDTH-1 : 0] dram_dout;
    wire                        dram_dout_valid;
    wire                        dram_ready;
    wire                        dram_wdf_ready;

    reg                         wen_afifo1;
    reg  [68:0]                 din_afifo1;
    wire                        ren_afifo1;
    wire [68:0]                 dout_afifo1;
    wire                        empty_afifo1;
    wire                        full_afifo1;
    wire                        dout_afifo1_wr_en;
    wire [31:0]                 dout_afifo1_addr;
    wire [31:0]                 dout_afifo1_data;

    wire                        wen_afifo2;
    wire [127:0]                din_afifo2;
    wire                        ren_afifo2;
    wire [127:0]                dout_afifo2;
    wire                        empty_afifo2;

    reg [1:0]                   state;

    wire [3:0]                  data_mask;

    localparam STATE_CALIB = 2'b00;
    localparam STATE_IDLE  = 2'b01;
    localparam STATE_WRITE = 2'b10;
    localparam STATE_READ  = 2'b11;

    // MIPS core -> MIG
    assign ren_afifo1 = (dram_ren || dram_wen);
    AsyncFIFO #(
                .DATA_WIDTH(69),
                .ADDR_WIDTH(2))
    afifo1 (
            .wclk(i_clk),
            .rclk(mig_ui_clk),
            .i_wrst_x(i_rst_x),
            .i_rrst_x(mig_ui_rst_x),
            .i_wen(wen_afifo1),
            .i_data(din_afifo1),
            .i_ren(ren_afifo1),
            .o_data(dout_afifo1),
            .o_empty(empty_afifo1),
            .o_full(full_afifo1));

    // MIG -> MIPS core
    assign wen_afifo2 = dram_dout_valid;
    assign din_afifo2 = dram_dout;
    assign ren_afifo2 = !empty_afifo2;
    AsyncFIFO #(
                .DATA_WIDTH(128),
                .ADDR_WIDTH(2))
    afifo2 (
            .wclk(mig_ui_clk),
            .rclk(i_clk),
            .i_wrst_x(mig_ui_rst_x),
            .i_rrst_x(i_rst_x),
            .i_wen(wen_afifo2),
            .i_data(din_afifo2),
            .i_ren(ren_afifo2),
            .o_data(dout_afifo2),
            .o_empty(empty_afifo2),
            .o_full());

    assign {dout_afifo1_wr_en, dout_afifo1_addr, dout_afifo1_data, data_mask} = dout_afifo1;
    assign dram_ren = (!empty_afifo1 && !dout_afifo1_wr_en && dram_ready);
    assign dram_wen = (!empty_afifo1 && dout_afifo1_wr_en && dram_ready && dram_wdf_ready);
`ifndef ARTYA7
    assign dram_addr = dout_afifo1_addr[26:1];
    assign dram_din = {{(APP_DATA_WIDTH-32){1'b0}}, dout_afifo1_data};
`else
    assign dram_addr = {2'b0, dout_afifo1_addr[26:4], 3'b0};
    assign dram_din = {4{dout_afifo1_data}};

    wire  [3:0] mask_t = ~data_mask;
    wire [15:0] mask_t2 = mask_t << {dout_afifo1_addr[3:2], 2'b0};
`endif

    DRAMController_AXI #(
                     .APP_ADDR_WIDTH(APP_ADDR_WIDTH),
                     .APP_CMD_WIDTH(APP_CMD_WIDTH),
                     .APP_DATA_WIDTH(APP_DATA_WIDTH),
                     .APP_MASK_WIDTH(APP_MASK_WIDTH))
    dc (

        // memory interface ports
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
	
        // output clk, rst (active-low)
        .i_clk(mig_ui_clk),
        .i_rst_x(mig_ui_rst_x),
        // user interface ports
        .i_rd_en(dram_ren),
        .i_wr_en(dram_wen),
`ifndef ARTYA7
        .i_addr({1'b0, dram_addr}),
`else
        .i_addr(dram_addr),
`endif
        .i_data(dram_din),
        .i_init_calib_complete(dram_init_calib_complete),
        .o_data(dram_dout),
        .o_data_valid(dram_dout_valid),
        .o_ready(dram_ready),
        .o_wdf_ready(dram_wdf_ready),
`ifndef ARTYA7
        .i_mask(data_mask));
`else
        .i_mask(~mask_t2));
`endif

    // state machine
    always @(negedge i_clk) begin
        if (!i_rst_x) begin
            state <= STATE_CALIB;
            wen_afifo1 <= 0;
            din_afifo1 <= 0;
        end else begin
            wen_afifo1 <= 0;
            din_afifo1 <= 0;
            case (state)
                STATE_CALIB: begin
                    if (i_init_calib_complete) begin
                        state <= STATE_IDLE;
                    end
                end
                STATE_IDLE: begin
                    if (i_wr_en) begin
                        state <= STATE_WRITE;
                        wen_afifo1 <= 1;
                        din_afifo1 <= {1'b1, i_addr, i_data, i_mask};
                    end else if (i_rd_en) begin
                        state <= STATE_READ;
                        wen_afifo1 <= 1;
                        din_afifo1 <= {1'b0, i_addr, i_data, 4'h0};
                    end
                end
                STATE_WRITE: begin
                    if (!full_afifo1) begin
                        state <= STATE_IDLE;
                    end
                end
                STATE_READ: begin
                    if (!empty_afifo2) begin
                        state <= STATE_IDLE;
                    end
                end
            endcase
        end
    end

    assign o_data = dout_afifo2;
    assign o_busy = (state != STATE_IDLE);

endmodule

