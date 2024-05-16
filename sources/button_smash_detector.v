`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2023 07:12:59 PM
// Design Name: 
// Module Name: SMASH_buttondetector
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


module SMASH_buttondetector(input clk_in, rst, in, output out);
wire out_1, out_2; 
//clk div
wire clk;
clock_divider #(.DIVIDE_BY(500000)) Lio_pessi
(
    .clk_in(clk_in),
    .reset(rst),    
    .clk_out(clk)
);
debouncer Messi_010 (.clk(clk), .rst(rst), .in(in), .out(out_1));
synchronizer R9 (.clk(clk), .rst(rst), .in(out_1), .out(out_2));
fsm cristiano_007(.clk(clk), .rst(rst), .w(out_2), .z(out));
   
endmodule