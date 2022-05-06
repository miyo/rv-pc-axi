/**************************************************************************************************/
/**** RVSoC (Mini Kuroda/RISC-V)                       since 2018-08-07   ArchLab. TokyoTech   ****/
/**** Memory Module v0.02                                                                      ****/
/**************************************************************************************************/
`default_nettype none
/**************************************************************************************************/
`include "define.vh"

/**** DRAM Main Memory module for implementation                                               ****/
/**************************************************************************************************/
`ifndef SIM_MODE
/**** DRAM Controller with Cache                                                               ****/
/**************************************************************************************************/
module DRAM_conRV#(
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
     input wire                         i_init_calib_complete,
     output wire [127:0]                  o_data,
     output wire                         o_busy,
     input  wire [2:0]                   i_ctrl
     );

    /***** store output data to registers in posedge clock cycle *****/

    reg  [31:0] r_addr  = 0;
    reg   [2:0] r_ctrl  = 0;

    reg         r_we    = 0;
    reg  [31:0] r_wdata = 0;
    reg         r_rd    = 0;

    always @(posedge i_clk) begin
        if((i_rd_en || i_wr_en) && !o_busy) begin
            r_ctrl  <= i_ctrl;
            r_addr  <= i_addr;
            r_wdata <= i_data;
        end
        r_we    <= i_wr_en;
        r_rd    <= i_rd_en;
    end

    wire[127:0] w_dram_odata;
    assign o_data = w_dram_odata;
    wire [3:0]  w_mask =    (r_ctrl[1:0] == 0) ? (4'b0001 << r_addr[1:0]) :
                            (r_ctrl[1:0] == 1) ? (4'b0011 << {r_addr[1], 1'b0}) : 4'b1111;
    wire [31:0] w_wdata =   (r_ctrl[1:0] == 0) ? {4{r_wdata[ 7:0]}} :
                            (r_ctrl[1:0] == 1) ? {2{r_wdata[15:0]}} : r_wdata;

    //wire        w_addr = (r_we) ? r_addr : i_addr;

    wire w_busy;
    assign o_busy = w_busy | r_we | r_rd;

    DRAM_conX#(
               .APP_ADDR_WIDTH(APP_ADDR_WIDTH),
               .APP_CMD_WIDTH(APP_CMD_WIDTH),
               .APP_DATA_WIDTH(APP_DATA_WIDTH),
               .APP_MASK_WIDTH(APP_MASK_WIDTH))
    dram (
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
	       .mig_ui_clk(mig_ui_clk),
	       .mig_ui_rst_x(mig_ui_rst_x),
	       .dram_init_calib_complete(dram_init_calib_complete),

               // output clk, rst (active-low)
               .i_clk(i_clk),
               .i_rst_x(i_rst_x),
               // user interface ports
               .i_rd_en(r_rd),
               .i_wr_en(r_we),
               .i_addr(r_addr),
               .i_data(w_wdata),
               .i_init_calib_complete(i_init_calib_complete),
               .o_data(w_dram_odata),
               .o_busy(w_busy),
               .i_mask(~w_mask)
               );

endmodule

/**************************************************************************************************/
/****Cache Controller                                                                          ****/
/**************************************************************************************************/
module cach_controller (
    input  wire                         clk,
    input  wire                         rst_x,
    input  wire                         i_rd_en,
    input  wire                         i_wr_en,
    input  wire [31:0]                  i_addr,
    input  wire [31:0]                  i_data,
    output wire [127:0]                 o_data,
    output wire                         o_busy,
    input  wire [3:0]                   i_mask,
    // cach
    input  wire                         cach_hit,
    output reg                          cach_we,
    output reg  [31:0]                  cach_addr,
    output reg  [127:0]                 cach_wdata,
    input  wire [127:0]                 cach_rdata,
    //dram
    input  wire                         dram_stall,
    output reg                          dram_le,
    output wire                         dram_we,
    input  wire [127:0]                 dram_rdata,
    output wire [31:0]                  dram_wdata,
    output wire [31:0]                  dram_addr
    );


    reg  [31:0] r_addr = 0;
    reg  [31:0] r_wdata = 0;
    reg [127:0] r_o_data = 0;

    // write buffer
    reg  [31:0] write_buf  = 0;
    reg         wbuf_full  = 0;
    reg         wbuf_we;


    wire [31:0]  write_mask = ~{{8{i_mask[3]}}, {8{i_mask[2]}}, {8{i_mask[1]}}, {8{i_mask[0]}}};
    wire [127:0] cach_rdata_mask = ~{{96'h0, write_mask} << {r_addr[3:2], 5'b0}};
    wire [127:0] cach_wdata_masked = (r_wdata & write_mask) << {r_addr[3:2], 5'b0};

    localparam  IDLE = 0;
    localparam  READ = 1;
    localparam  CACH_WRITE = 2;
    localparam  WBUF_WAIT = 3;
    localparam  READ_MISS = 4;
    localparam  WRITE_MISS = 5;

    reg [2:0]   r_state = IDLE;
    reg [2:0]   next_state = 0;
    reg [127:0] next_odata;
    // combinational logic

    always @ (*) begin
        next_state = r_state;
        next_odata = r_o_data;
        wbuf_we    = 0;
        dram_le    = 0;
        cach_we    = 0;
        cach_addr  = r_addr;
        cach_wdata = dram_rdata;
        case (r_state)
            IDLE: begin
                if (i_wr_en) begin
                    if (!wbuf_full) begin
                        wbuf_we = 1;
                        next_state = CACH_WRITE;
                    end else begin
                        next_state = WBUF_WAIT;
                    end
                end else if (i_rd_en) begin
                    next_state = READ;
                end
                cach_addr = i_addr;
            end
            READ: begin
                if (cach_hit) begin
                    next_state = IDLE;
                    next_odata = cach_rdata;
                end else begin
                    if (!dram_stall) begin
                        next_state = READ_MISS;
                        dram_le    = 1;
                    end
                end
            end
            READ_MISS: begin
                if (!dram_stall) begin
                    next_state = IDLE;
                    next_odata = dram_rdata;
                    cach_we = 1;
                    cach_wdata = dram_rdata;
                end
            end
            WBUF_WAIT: begin
                if (!wbuf_full) begin
                    wbuf_we = 1;
                    next_state = CACH_WRITE;
                end
            end
            CACH_WRITE: begin
                if (cach_hit) begin
                    next_state = IDLE;
                    cach_we = 1;
                    cach_wdata = (cach_rdata & cach_rdata_mask) | cach_wdata_masked;
                end else begin
`ifdef FETCH_BLOCK_ON_WRITE_MISS
                    if (!dram_stall) begin
                        next_state = WRITE_MISS;
                        dram_le = 1;
                    end
`else
                    next_state = IDLE;
`endif
                end
            end
            WRITE_MISS: begin
                if (!dram_stall) begin
                    next_state = IDLE;
                    cach_we = 1;
                    cach_wdata = (dram_rdata & cach_rdata_mask) | cach_wdata_masked;
                end
            end
            default:;
        endcase
    end

    always @ (posedge clk) begin
        r_state <= (!rst_x) ? IDLE : next_state;
        r_o_data <= next_odata;
        if ((i_wr_en || i_rd_en) && r_state == IDLE) begin
            r_addr <= i_addr;
            r_wdata <= i_data;
        end
    end

    always @ (posedge clk) begin
        if (wbuf_we) begin
            wbuf_full  <= 1;
        end else if (wbuf_full & !dram_stall) begin
            wbuf_full <= 0;
        end
    end

    assign dram_we = (!wbuf_full) & wbuf_we;
    assign dram_addr = (wbuf_we && r_state == IDLE) ? i_addr : r_addr;
    assign dram_wdata = (r_state == IDLE) ? i_data : r_wdata;

    assign o_busy = r_state != IDLE;

    assign o_data = r_o_data;

endmodule //cach_controller

/**************************************************************************************************/
/**** DRAM Controller with Cache                                                               ****/
/**************************************************************************************************/
module DRAM_conX#(
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
     output wire[127:0]                  o_data,
     output wire                         o_busy,
     input  wire [3:0]                   i_mask);

    /***** store output data to registers in posedge clock cycle *****/


    // DRAM
    wire        w_dram_stall;
    wire        w_dram_le;
    wire        w_dram_we;
    wire [31:0] w_dram_addr;
    wire [31:0] w_dram_idata;
    wire[127:0] w_dram_odata;

    // Cache
    wire        c_oe;
    wire        c_clr;
    wire        c_we;
    wire [31:0] c_addr;
    wire[127:0] c_idata;
    wire[127:0] c_odata;

    cach_controller cach_controller(
        .clk(i_clk),
        .rst_x(i_rst_x),
        .i_rd_en(i_rd_en),
        .i_wr_en(i_wr_en),
        .i_addr(i_addr),
        .i_data(i_data),
        .o_data(o_data),
        .o_busy(o_busy),
        .i_mask(i_mask),
        .cach_hit(c_oe),
        .cach_we(c_we),
        .cach_addr(c_addr),
        .cach_wdata(c_idata),
        .cach_rdata(c_odata),
        .dram_stall(w_dram_stall),
        .dram_le(w_dram_le),
        .dram_we(w_dram_we),
        .dram_rdata(w_dram_odata),
        .dram_wdata(w_dram_idata),
        .dram_addr(w_dram_addr)
        );

    m_dram_cache#(28,128,`CACHE_SIZE/16) cache(i_clk, 1'b1, 1'b0, c_clr, c_we,
                                c_addr[31:4], c_idata, c_odata, c_oe);

    DRAM_Wrapper2#(
                   .APP_ADDR_WIDTH(APP_ADDR_WIDTH),
                   .APP_CMD_WIDTH(APP_CMD_WIDTH),
                   .APP_DATA_WIDTH(APP_DATA_WIDTH),
                   .APP_MASK_WIDTH(APP_MASK_WIDTH))
    dram (
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
	       .mig_ui_clk(mig_ui_clk),
	       .mig_ui_rst_x(mig_ui_rst_x),
	       .dram_init_calib_complete(dram_init_calib_complete),

               // output clk, rst (active-low)
               .i_clk(i_clk),
               .i_rst_x(i_rst_x),
               // user interface ports
               .i_rd_en(w_dram_le),
               .i_wr_en(w_dram_we),
               .i_addr(w_dram_addr),
               .i_data(w_dram_idata),
               .i_init_calib_complete(i_init_calib_complete),
               .o_data(w_dram_odata),
               .o_busy(w_dram_stall),
               .i_mask(i_mask)
               );

endmodule
/**************************************************************************************************/
/**************************************************************************************************/
module DRAM_Wrapper2 #(
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

    /***** store output data to registers in posedge clock cycle *****/

    wire [127:0]w_o_data;
    wire        w_o_busy;

    reg  [127:0]r_o_data = 0;
    reg         r_o_busy = 0;
    always @(posedge i_clk) begin
        r_o_data <= w_ctrl_data;
        r_o_busy <= w_o_busy;
    end

    assign o_data = r_o_data;
    assign o_busy = r_o_busy || r_le || r_we;

    /***** select load data by i_ctrl *****/

    reg  [3:0]  r_mask  = 0;
    reg  [31:0] r_iaddr = 0;
    wire [127:0]w_ctrl_data;

    reg  [31:0] r_wdata = 0;
    reg         r_le = 0;
    reg         r_we = 0;

    always @(posedge i_clk) begin
        //if(i_rd_en) begin
        r_mask  <= i_mask;
        r_iaddr <= i_addr;
        //end
        r_le <= i_rd_en;
        r_we <= i_wr_en;
        r_wdata <= i_data;
    end
    assign w_ctrl_data = w_o_data;

    wire [31:0] w_ctrl_iaddr = (r_we) ? {r_iaddr[31:2],2'b0} : {r_iaddr[31:4],4'b0};

    DRAM_con_without_cache#(
                     .APP_ADDR_WIDTH(APP_ADDR_WIDTH),
                     .APP_CMD_WIDTH(APP_CMD_WIDTH),
                     .APP_DATA_WIDTH(APP_DATA_WIDTH),
                     .APP_MASK_WIDTH(APP_MASK_WIDTH))
    dram_con_without_cache (
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
	       .mig_ui_clk(mig_ui_clk),
	       .mig_ui_rst_x(mig_ui_rst_x),
	       .dram_init_calib_complete(dram_init_calib_complete),
	       
               // output clk, rst (active-low)
               .i_clk(i_clk),
               .i_rst_x(i_rst_x),
               // user interface ports
               .i_rd_en(r_le),
               .i_wr_en(r_we),
               .i_addr(w_ctrl_iaddr),
               .i_data(r_wdata),
               .i_init_calib_complete(i_init_calib_complete),
               .o_data(w_o_data),
               .o_busy(w_o_busy),
               .i_mask(r_mask)
               );

endmodule
/**************************************************************************************************/
`endif

/**************************************************************************************************/

/*** Single-port RAM with synchronous read                                                      ***/
module m_bram#(parameter WIDTH=32, ENTRY=256)(CLK, w_we, w_addr, w_idata, r_odata);
  input  wire                     CLK, w_we;
  input  wire [$clog2(ENTRY)-1:0] w_addr;
  input  wire         [WIDTH-1:0] w_idata;
  output reg          [WIDTH-1:0] r_odata;

  reg          [WIDTH-1:0]  mem [0:ENTRY-1];

  integer i;
  initial for (i=0;i<ENTRY;i=i+1) mem[i]=0;

  always  @(posedge  CLK)  begin
    if (w_we) mem[w_addr] <= w_idata;
    r_odata <= mem[w_addr];
  end
endmodule
/**************************************************************************************************/

/*** Dual-port RAM with synchronous read                                                        ***/
module m_bram2#(parameter WIDTH=32, ENTRY=256)
                (CLK, w_we, w_raddr, w_waddr, w_idata, w_odata1, w_odata2);
    input  wire                     CLK, w_we;
    input  wire [$clog2(ENTRY)-1:0] w_raddr, w_waddr;
    input  wire         [WIDTH-1:0] w_idata;
    output wire         [WIDTH-1:0] w_odata1, w_odata2;

    reg  [$clog2(ENTRY)-1:0] r_addr, r_addr2;

    reg          [WIDTH-1:0] mem [0:ENTRY-1];

    always  @(posedge  CLK)  begin
        if (w_we) mem[w_waddr] <= w_idata;
        r_addr2 <= w_waddr;
        r_addr <= w_raddr;
    end
    assign w_odata1 = mem[r_addr];
    assign w_odata2 = mem[r_addr2];
endmodule
/**************************************************************************************************/
/*** Single-port RAM with synchronous read with colum access                                    ***/
module m_col_bram#(parameter WIDTH=32, ENTRY=256)(CLK, w_we, w_addr, w_idata, w_odata);
    input  wire                     CLK;
    input  wire               [3:0] w_we;
    input  wire [$clog2(ENTRY)-1:0] w_addr;
    input  wire         [WIDTH-1:0] w_idata;
    output wire         [WIDTH-1:0] w_odata;

    //initial $readmemh(`MEMFILE, mem);

    (* ram_style = "block" *) reg [WIDTH-1:0] mem[0:ENTRY-1];
    reg [$clog2(ENTRY)-1:0] addr=0;
    always @(posedge CLK) begin
        if (w_we[0]) mem[w_addr][ 7: 0] <= w_idata[ 7: 0];
        if (w_we[1]) mem[w_addr][15: 8] <= w_idata[15: 8];
        if (w_we[2]) mem[w_addr][23:16] <= w_idata[23:16];
        if (w_we[3]) mem[w_addr][31:24] <= w_idata[31:24];
        addr <= w_addr;
    end
    assign w_odata = mem[addr];
endmodule
/**************************************************************************************************/
`ifndef SIM_MODE
module AsyncFIFO #(
			       parameter DATA_WIDTH  = 512,
			       parameter ADDR_WIDTH  = 8) // FIFO_DEPTH = 2^ADDR_WIDTH
    (
     input  wire                    wclk,
	 input  wire                    rclk,
     input  wire                    i_wrst_x,
     input  wire                    i_rrst_x,
	 input  wire                    i_wen,
	 input  wire [DATA_WIDTH-1 : 0] i_data,
     input  wire                    i_ren,
	 output wire [DATA_WIDTH-1 : 0] o_data,
	 output wire                    o_empty,
	 output wire                    o_full);

    reg  [DATA_WIDTH-1 : 0] afifo[(2**ADDR_WIDTH)-1 : 0];
    reg  [ADDR_WIDTH : 0]   waddr;
    reg  [ADDR_WIDTH : 0]   raddr;

    reg  [ADDR_WIDTH : 0]   raddr_gray1;
    reg  [ADDR_WIDTH : 0]   raddr_gray2;

    reg  [ADDR_WIDTH : 0]   waddr_gray1;
    reg  [ADDR_WIDTH : 0]   waddr_gray2;

    wire [DATA_WIDTH-1 : 0] data;

    wire [ADDR_WIDTH : 0]   raddr_gray;
    wire [ADDR_WIDTH : 0]   waddr_gray;

    wire [ADDR_WIDTH : 0]   raddr2;
    wire [ADDR_WIDTH : 0]   waddr2;

    genvar genvar_i;

    // output signals
    assign o_data  = data;
    assign o_empty = (raddr == waddr2);
    assign o_full  = (waddr[ADDR_WIDTH] != raddr2[ADDR_WIDTH]) &&
                     (waddr[ADDR_WIDTH-1 : 0] == raddr2[ADDR_WIDTH-1 : 0]);

    // binary code to gray code
    assign raddr_gray = raddr[ADDR_WIDTH : 0] ^ {1'b0, raddr[ADDR_WIDTH : 1]};
    assign waddr_gray = waddr[ADDR_WIDTH : 0] ^ {1'b0, waddr[ADDR_WIDTH : 1]};

    // gray code to binary code
    generate
	    for (genvar_i = 0; genvar_i <= ADDR_WIDTH; genvar_i = genvar_i + 1) begin
		    assign raddr2[genvar_i] = ^raddr_gray2[ADDR_WIDTH : genvar_i];
		    assign waddr2[genvar_i] = ^waddr_gray2[ADDR_WIDTH : genvar_i];
	    end
    endgenerate

    // double flopping read address before using it in write clock domain
    always @(posedge wclk) begin
	    if (!i_wrst_x) begin
		    raddr_gray1 <= 0;
		    raddr_gray2 <= 0;
	    end else begin
		    raddr_gray1 <= raddr_gray;
		    raddr_gray2 <= raddr_gray1;
	    end
    end

    // double flopping write address before using it in read clock domain
    always @(posedge rclk) begin
	    if (!i_rrst_x) begin
		    waddr_gray1 <= 0;
		    waddr_gray2 <= 0;
	    end else begin
		    waddr_gray1 <= waddr_gray;
		    waddr_gray2 <= waddr_gray1;
	    end
    end

    // read
    assign data = afifo[raddr[ADDR_WIDTH-1 : 0]];
    always @(posedge rclk) begin
	    if (!i_rrst_x) begin
		    raddr <= 0;
	    end else if (i_ren) begin
		    raddr <= raddr + 1;
	    end
    end

    // write
    always @(posedge wclk) begin
	    if (!i_wrst_x) begin
		    waddr <= 0;
	    end else if (i_wen) begin
		    afifo[waddr[ADDR_WIDTH-1 : 0]] <= i_data;
		    waddr <= waddr + 1;
	    end
    end

endmodule
`endif
/**************************************************************************************************/
/*** Simple Direct Mapped Cache Sync CLK for DRAM                                               ***/
/**************************************************************************************************/
module m_dram_cache#(parameter ADDR_WIDTH = 30, D_WIDTH = 32, ENTRY = 1024)
    (CLK, RST_X, w_flush, w_clr, w_we, w_addr, w_idata, w_odata, w_oe);
    input  wire                     CLK, RST_X;
    input  wire                     w_flush, w_we, w_clr;
    input  wire [ADDR_WIDTH-1:0]    w_addr;
    input  wire    [D_WIDTH-1:0]    w_idata;
    output wire    [D_WIDTH-1:0]    w_odata;
    output wire                     w_oe;             //output enable

    // index and tag
    reg  [$clog2(ENTRY)-1:0]                r_idx = 0;
    reg  [(ADDR_WIDTH - $clog2(ENTRY))-1:0] r_tag = 0;

    // index and tag
    wire                [$clog2(ENTRY)-1:0] w_idx;
    wire [(ADDR_WIDTH - $clog2(ENTRY))-1:0] w_tag;
    assign {w_tag, w_idx} = w_addr;

    wire                                            w_mwe = w_clr | w_we | !RST_X | w_flush;
    wire                      [$clog2(ENTRY)-1:0]   w_maddr = w_idx;
    wire [ADDR_WIDTH - $clog2(ENTRY) + D_WIDTH:0]   w_mwdata = w_we ? {1'b1, w_tag, w_idata} : 0;
    wire [ADDR_WIDTH - $clog2(ENTRY) + D_WIDTH:0]   w_modata;

    wire                                            w_mvalid;
    wire                     [$clog2(ENTRY)-1:0]    w_midx;
    wire      [(ADDR_WIDTH - $clog2(ENTRY))-1:0]    w_mtag;
    wire                           [D_WIDTH-1:0]    w_mdata;
    assign {w_mvalid, w_mtag, w_mdata} = w_modata;


    m_bram#((ADDR_WIDTH - $clog2(ENTRY) + D_WIDTH)+1, ENTRY)
        mem(CLK, w_mwe, w_maddr, w_mwdata, w_modata);

    assign w_odata  = w_mdata;
    assign w_oe     = (w_mvalid && w_mtag == r_tag);

    always  @(posedge  CLK)  begin
        r_tag <= w_tag;
        r_idx <= w_idx;
    end
endmodule // DMC
/**************************************************************************************************/
