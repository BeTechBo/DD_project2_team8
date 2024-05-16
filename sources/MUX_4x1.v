`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2024 04:49:49 PM
// Design Name: 
// Module Name: MUX_4x1
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


module mux (input [3:0] inp1, inp2, inp3, inp4, input [1:0] sel,
    output reg [3:0] out
);

always @(*) begin
    case(sel)
        2'b00: out = inp1;
        2'b01: out = inp2;
        2'b10: out = inp3;
        2'b11: out = inp4;
        default: out = 4'bxxxx; 
    endcase
end

endmodule
