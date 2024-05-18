module modulo_counters (input clk, 
input rst, input adjust_enable_minutes, 
input adjust_enable_hours,
input  enable_seconds, 
input Up_down,output [3:0]hours_units,
input  minuites_units, 
output [1:0]hours_tenth, 
output [2:0]minutes_tenth, 
iytput[5:0]seconds_OUT);
wire[5:0] minutes_OUT; 
wire[4:0] hours_OUT;
wire enable_hours, enable_minuites;
counter_x_bit #(6,60) seconds_counter ( clk, rst, enable_seconds, Up_down,seconds_OUT); // seconds counter, which will not show
assign enable_minuites = enable_seconds ? seconds_OUT == 6'd59 : adjust_enable_minutes;
counter_x_bit #(6,60) minutes_counter ( clk, rst, enable_minuites,Up_down, minutes_OUT); // minutes counter
assign enable_hours = enable_seconds ? (seconds_OUT == 6'd59 & minutes_OUT == 6'd59) : adjust_enable_hours;// this fixes the 23:59 reseting 
counter_x_bit #(5,24) hours_counter ( clk, rst, enable_hours,Up_down, hours_OUT); 
assign minutes_tenth=minutes_OUT/10;
assign minuites_units=minutes_OUT%10;
assign hours_tenth=hours_OUT/10;
assign hours_units=hours_OUT%10;

endmodule
