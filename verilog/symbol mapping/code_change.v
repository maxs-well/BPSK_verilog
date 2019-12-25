`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/18 21:25:32
// Design Name: 
// Module Name: code_change
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


module code_change(
    input                           code        ,
    output  signed  [1:0]           code_o      
    );

assign code_o = (code == 1'b1) ? 2'b01 : 2'b11;
    
endmodule
