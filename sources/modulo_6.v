module modulo_6_counter(input clk,input reset,input enable,output [3:0] count);
integer n=6;
wire clk_out;   

clockDivider #(3000000000) l1(.clk(clk),.rst (reset),.clk_out (clk_out));
exp1#(3,6) l2(.clk(clk_out),.reset(reset),.enable(enable),.count(count));

endmodule