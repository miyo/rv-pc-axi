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
     output reg [3:0] s_axi_awid,
     output reg [APP_ADDR_WIDTH-1:0] s_axi_awaddr,
     output reg [7:0] s_axi_awlen,
     output reg [2:0] s_axi_awsize,
     output reg [1:0] s_axi_awburst,
     output reg [0:0] s_axi_awlock,
     output reg [3:0] s_axi_awcache,
     output reg [2:0] s_axi_awprot,
     output reg [3:0] s_axi_awqos,
     output reg s_axi_awvalid,
     input wire s_axi_awready,

     output reg [APP_DATA_WIDTH-1:0] s_axi_wdata,
     output reg [APP_MASK_WIDTH-1:0] s_axi_wstrb,
     output reg s_axi_wlast,
     output reg s_axi_wvalid,
     input wire s_axi_wready,

     input wire [3:0] s_axi_bid,
     input wire [1:0] s_axi_bresp,
     input wire s_axi_bvalid,
     output wire s_axi_bready,

     output reg [3:0] s_axi_arid,
     output reg [APP_ADDR_WIDTH-1:0] s_axi_araddr,
     output reg [7:0] s_axi_arlen,
     output reg [2:0] s_axi_arsize,
     output reg [1:0] s_axi_arburst,
     output reg [0:0] s_axi_arlock,
     output reg [3:0] s_axi_arcache,
     output reg [2:0] s_axi_arprot,
     output reg [3:0] s_axi_arqos,
     output reg s_axi_arvalid,
     input wire s_axi_arready,

     input wire [3:0] s_axi_rid,
     input wire [APP_DATA_WIDTH-1:0] s_axi_rdata,
     input wire [1:0] s_axi_rresp,
     input wire s_axi_rlast,
     input wire s_axi_rvalid,
     output wire s_axi_rready,

     // input clk, rst (active-low)
     input wire                         i_clk,
     input wire                         i_rst_x,
     // user interface ports
     (* mark_debug *) input  wire                         i_rd_en,
     (* mark_debug *) input  wire                         i_wr_en,
     (* mark_debug *) input  wire [APP_ADDR_WIDTH-1 : 0]  i_addr,
     (* mark_debug *) input  wire [APP_DATA_WIDTH-1 : 0]  i_data,
     (* mark_debug *) input wire                         i_init_calib_complete,
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

    reg                         app_rdy;
    reg                         app_wdf_rdy;

    (* mark_debug *) reg  [2:0]                  state;

`ifndef ARTYA7
    reg  [3:0]                  data_mask = 0;
`else
    reg  [APP_MASK_WIDTH-1 : 0] data_mask = 0;
`endif

    assign o_data = s_axi_rdata;

    assign o_data_valid = s_axi_rvalid;

    assign o_ready = app_rdy;
    assign o_wdf_ready = app_wdf_rdy;

    assign s_axi_bready = 1'b1;
    assign s_axi_rready = 1'b1;

    always @(posedge i_clk) begin
        if (~i_rst_x) begin
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
                    if (i_init_calib_complete) begin
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

