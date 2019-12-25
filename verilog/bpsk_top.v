`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/05 21:18:18
// Design Name: 
// Module Name: bpsk_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module bpsk_top(
    input                           sys_clk     ,
    input                           rst_n     ,
    
    output  reg                    a       

    );

wire    en  ;
wire    clk_50m;
wire    rst_global;
wire    locked  ;
wire    code    ;
wire    code_vld;
wire    cos_vld ;
(* MARK_DEBUG="true" *)wire [15:0] cos_o;
(* MARK_DEBUG="true" *)wire [23:0] fir_out ;
(* MARK_DEBUG="true" *)wire signed [1:0]  code_c;
(* MARK_DEBUG="true" *)wire signed [23:0]  duc_data;

assign rst_global = ~rst_n || ~locked;

clk_wiz_0 clk_inst
(
// Clock out portsen_generator en_inst
.clk_out1(clk_50m),     // output clk_out1(
// Status and control signals.clk(clk),
.reset(~rst_n), // input reset.rst(rst),
.locked(locked),       // output locked
// Clock in ports.start(1'b1),
.clk_in1(sys_clk)      // input clk_in1.en	  (en)
);   

(* keep_hierarchy="yes" *)
en_generator
#(.INTERVAL(50)) 
en_inst
(
.clk(clk_50m),
.rst(rst_global),
.start	(1'b1),
.en	    (en)
); 

(* keep_hierarchy="yes" *)
m_seq m_inst
(
.clk	(clk_50m),
.rst	(rst_global),

.en		 (en) ,
.data_out(code) ,
.data_vld(code_vld)
);

code_change code_inst(
.code    (code)  ,
.code_o  (code_c)  
);



fir_compiler_0 fir_inst (
  .aclk(clk_50m),                              // input wire aclk
  .s_axis_data_tvalid(1'b1),  // input wire s_axis_data_tvalid
  .s_axis_data_tready(),  // output wire s_axis_data_tready
  .s_axis_data_tdata({{6{code_c[1]}},code_c}),    // input wire [7 : 0] s_axis_data_tdata
  .m_axis_data_tvalid(),  // output wire m_axis_data_tvalid
  .m_axis_data_tdata(fir_out)    // output wire [23 : 0] m_axis_data_tdata   19-8
);



dds_compiler_0 dds_inst (
.aclk(clk_50m),                                // input wire aclk
.m_axis_data_tvalid(),    // output wire m_axis_data_tvalid
.m_axis_data_tdata(cos_o),      // output wire [15 : 0] m_axis_data_tdata 13 - 2
.m_axis_phase_tvalid(),  // output wire m_axis_phase_tvalid
.m_axis_phase_tdata()    // output wire [31 : 0] m_axis_phase_tdata 
);

xbip_dsp48_macro_0 dsp_product_inst (
  .CLK(clk_50m),  // input wire CLK
  .A(fir_out[19:8]),      // input wire [11 : 0] A
  .B(cos_o[13:2]),      // input wire [11 : 0] B
  .P(duc_data)      // output wire [23 : 0] P
);


endmodule
