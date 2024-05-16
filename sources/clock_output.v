`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2024 04:46:10 PM
// Design Name: 
// Module Name: exp5
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

module exp5(input clk, reset, enable, output [3:0] anode_active ,output [6:0] segments, output LED0, output reg decimal, input C,L,R,U,D);
wire [13:0] count;
wire [3:0] wi_4 = count[3:0];
wire [2:0] wi_3 = count[6:4];
wire [3:0] wi_2 = count[10:7];
wire [2:0] wi_1 = count[13:11];
wire [1:0] sel;
wire[3:0] m_out;
wire clk_out;
wire clk_ds;





clockDivider #(50000000) clk1hz(clk,reset,clk_ds);
always@(*) begin
    if(anode_active==4'b1101&&clk_ds)
        decimal=0;
        else
        decimal=1;
    end

modulo_counters chess( .clk(clk), .reset(reset), .enable(enable), .count(count));
clockDivider #(60000) freq(clk, reset, clk_out);
exp1 #(2,4) gut(.clk(clk_out), .reset(reset),.enable(enable), .count(sel));
mux Multi(.inp1(wi_4),.inp2({1'b0,wi_3}),.inp3(wi_2),.inp4({1'b0,wi_1}),.sel(sel), .out(m_out));
seven_segment display(.num(m_out),.enable(sel),.anode_active(anode_active),.segments(segments));  
assign LED0=1;
endmodule
