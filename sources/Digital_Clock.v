`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2024 12:20:42 AM
// Design Name: 
// Module Name: Digital_Clock
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


//module Digital_Clock(input C,L,R,U,D,clk);
//wire out1, out2, out3, out4,out5;
//  reg [2:0] state, nextstate;
//  parameter [2:0] A0 = 3'b000, A1=3'b001, A2 = 3'b010, A3 = 3'b011, A4 = 3'b100;

//  PushButton Ab (.clk_in(clk), .rst(rst), .in(C), .out(out1));
//  PushButton Bb (.clk_in(clk), .rst(rst), .in(L), .out(out2));
//  PushButton Cb (.clk_in(clk), .rst(rst), .in(R), .out(out3));
//  PushButton Db (.clk_in(clk), .rst(rst), .in(U), .out(out4));
//  PushButton b (.clk_in(clk), .rst(rst), .in(D), .out(out5));
  
//  wire [4:0] usedoutput = {out1, out2, out3, out4,out5};
//endmodule



module Digital_Clock(input clk, rst,C,L, R, U, D, Up_down,output [3:0]anode_active, output [6:0] seg); 
wire out1, out2, out3, out4, out5; 
reg [1:0] alarm_hours_first , [3:0] alarm_hours_second , [2:0] alarm_mins_first, [3:0] alarm_mins_second;
reg [2:0] state, nextstate; 
parameter [2:0] A0 = 3'b000, A1=3'b001, A2 = 3'b010, A3 = 3'b011, A4 = 3'b100, A5 =3'b101; 
  PushButton Ab (.clk_in(clk), .rst(rst), .in(C), .out(out1));
  PushButton Bb (.clk_in(clk), .rst(rst), .in(L), .out(out2));
  PushButton Cb (.clk_in(clk), .rst(rst), .in(R), .out(out3));
  PushButton Db (.clk_in(clk), .rst(rst), .in(U), .out(out4));
  PushButton Ee (.clk_in(clk), .rst(rst), .in(D), .out(out5));
wire [4:0] usedoutput = {out1, out2, out3, out4, out5};

 
clock_divider #(.DIVIDE_BY(500000)) clkop (.clk_in(clk_in),.reset(rst),.clk_out(clk_out)); 
reg [6:0] alarm_hours = 6'b000000;
reg [7:0] alarm_mins =  7'b0000000;

  always @(posedge clk_out or posedge rst) begin 
    if (rst) begin 
      state <= A0; 
    end 
    else begin 
      state <= nextstate; 
    end 
  end 
  
  
  
  wire clk_1_hz;
  wire clk_200_hz;
  wire sec_en , min_en ,hour_en , alarm_min_en , alarm_hour_en;
  wire LD0;
  wire [3:0] LD;
  wire sec;
  wire alarm_clock;
  reg final_zero_flag; 
  
  always @* begin 
    case (state) 
      A0: begin
      clk = clk_1_hz;
      sec_en = 1'b1;
      LD0 = 1'b0;
      LD = 4'b0;
      alarm_min_en = 1'b0;
      alarm_hour_en = 1'b0;
      sec = clk_1_hz;
      alarm_clock = 1'b1;
      Up_down  = 1'b1;
      if (final_zero_flag == 1)nextstate = A5;
      if (usedoutput == 5'b00100) nextstate = A1;  .
        else nextstate = A0;
      end 
      
      
      A1: begin 
        LD = 4'b0000;
        LD0 = 1'b0;
        
        if (usedoutput == 5'b01000) nextstate = A2;  
        else if (usedoutput == 4'b0000) nextstate = A1 ; 
        else if (usedoutput == 4'b1000) nextstate = A1; 
        else nextstate = A0;
      end 
      
      
      A2: begin 
        if (usedoutput == 4'b0100) nextstate = A3;  
        else if (usedoutput == 4'b0000) nextstate = A2; 
        else if (usedoutput == 4'b1000) nextstate = A1; 
        else nextstate = A0; 
      end 
      
      
      A3: begin 
        if (usedoutput == 4'b0010) nextstate = A4;  
        else if (usedoutput == 4'b0000)  nextstate = A3; 
        else if (usedoutput == 4'b1000) nextstate = A1; 
        else nextstate = A0; 
      end 
      
      
      A4: begin 
        if (usedoutput == 4'b0000)  nextstate = A4; 
        else if (usedoutput == 4'b1000) nextstate = A1; 
        else nextstate = A0; 
      end 
      
      A5:
      default: nextstate = A0; 
    endcase 
  end 
   
assign anode_active = 4'b1110; 
   assign w = (state == A4) && rst == 0; 
assign seg = w? 7'b1000001:7'b1110001; 
 
endmodule