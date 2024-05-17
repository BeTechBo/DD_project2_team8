module modulo_counters (input clk, rst, adjust_enable_minutes, adjust_enable_hours, enable_seconds, Up_down,output [3:0]hours_units, minuites_units, output [1:0]hours_tenth, output [2:0]minutes_tenth);
wire[5:0]seconds_OUT;
wire[5:0] minutes_OUT; 
wire[4:0] hours_OUT;
wire enable_hours, enable_minuites;

counter_x_bit #(6,60) seconds_counter ( clk, rst, enable_seconds, Up_down,seconds_OUT); 
assign enable_minuites = enable_seconds ? seconds_OUT == 6'd59 : adjusted_enable_minuites;
counter_x_bit #(6,60) minutes_counter ( clk, rst, enable_minutes,Up_down, minutes_OUT); 
assign enable_hours = enable_seconds ? seconds_OUT == 6'd59 & minuites_OUT == 6'd59 : adjusted_enable_hours;
counter_x_bit #(5,24) hours_counter ( clk, rst, enable_hours,Up_down, hours_OUT); 

assign minutes_tenth=minutes_OUT/10;
assign minutes_units=minutes_OUT%10;

assign hours_tenth=hours_OUT/10;
assign hours_units=hours_OUT%10;

endmodule