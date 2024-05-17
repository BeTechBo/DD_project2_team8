module modulo_10_counter(input clk,input reset,input enable,output [3:0] count);
integer n=10;
wire clk_out;   

clockDivider #(3000000000) j1(.clk(clk),.rst (reset),.clk_out (clk_out));
exp1#(4,10) j2(.clk(clk_out),.reset(reset),.enable(enable),.count(count));

endmodule