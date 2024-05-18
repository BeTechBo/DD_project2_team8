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

module exp5(input clk_1, input clk200, input reset,input enable, output [3:0] anode_active ,output [6:0] segments, output reg decimal, input  C, input L,input R,input U,input D, output  reg[0:4] LD, output z_flag);
wire [3:0] wi_4;// minuites units
wire [2:0] wi_3;// minuites tens
wire [3:0] wi_2;// hours units
wire [1:0] wi_1;// hours_tenth

wire [3:0] ai_4;// minuites units
wire [2:0] ai_3;// minuites tens
wire [3:0] ai_2;// hours units
wire [1:0] ai_1;// hours_tenth

reg pflag=0;


wire [1:0] sel, sel2;
wire clk_out;
reg chooser_clk;


wire clk_200_hz;
clockDivider #(250000) clkop (.clk(clk_1),.rst(rst),.clk_out(clk_200_hz)); 
clockDivider #(50000000) clkdiv (.clk(clk_1),.rst(rst),.clk_out(clk_out)); 

reg sec_en , min_en ,hour_en , alarm_min_en , alarm_hour_en, Up_down;

reg is_clicked;
wire sec_count2; wire sec_count;
wire mux_clk;
reg adjust;
reg adjusted_clk;
wire out1, out2, out3, out4, out5; 
reg [1:0] alarm_hours_first ; reg  [3:0] alarm_hours_second ; reg [2:0] alarm_mins_first; reg [3:0] alarm_mins_second;
reg [2:0] state, nextstate;
parameter [2:0] display_clock = 3'b000, alarm_mode = 3'b001,clk_hour = 3'b010, clk_min = 3'b100, alarm_hour = 3'b110, alarm_min = 3'b111;
  SMASH_buttondetector Ub (.clk_in(clk_200_hz), .rst(rst), .in(U), .out(out1));
  SMASH_buttondetector Db (.clk_in(clk_200_hz), .rst(rst), .in(D), .out(out2));
  SMASH_buttondetector Rb (.clk_in(clk_200_hz), .rst(rst), .in(R), .out(out3));
  SMASH_buttondetector Lb (.clk_in(clk_200_hz), .rst(rst), .in(L), .out(out4));
  SMASH_buttondetector Ce (.clk_in(clk_200_hz), .rst(rst), .in(C), .out(out5));
wire [4:0] usedoutput = {out1, out2, out3, out4, out5};


always@(*) begin
    if(anode_active==4'b1101 & clk_out & state==display_clock)
        decimal=0;
        else
        decimal=1;
    end
    
    
 wire[5:0]seconds_OUT;   

assign z_flag = ((wi_2 == ai_2) & (wi_4 == ai_4)& (wi_3 == ai_3)& (wi_1 == ai_1) & (seconds_OUT==0) & pflag );


always @* begin 
    case (state)
    display_clock :begin
    if (z_flag)begin 
    
          LD = {0,0,0,0,clk_out};
          nextstate = alarm_mode;
          chooser_clk=clk_out;
          sec_en=1;
          Up_down=1'b1;
          min_en=0;
          hour_en=0;
          alarm_min_en=0;
          alarm_hour_en=0;      
    
    end 
    else  if (usedoutput == 5'b00001) begin 
        nextstate = clk_hour;
        LD=5'b11000;
        chooser_clk=clk_200_hz;
        sec_en=0;
        Up_down=1'bx;
        min_en=0;
        hour_en=0;
        alarm_min_en=0;
        alarm_hour_en=0; 
      end
      else begin 
        nextstate = display_clock;
        LD=5'b00000;
        chooser_clk=clk_out;
        sec_en=1;
        Up_down=1'b1;
        min_en=0;
        hour_en=0;
        alarm_min_en=0;
        alarm_hour_en=0; 
      end
      end
    
      clk_hour: begin 
      if (usedoutput == 5'b00100) begin 
        nextstate = clk_min;
        LD=5'b10100;
        chooser_clk=clk_200_hz;
        sec_en=0;
        Up_down=1'bx;
        min_en=0;
        hour_en=0;
        alarm_min_en=0;
        alarm_hour_en=0; 
      end
      
       else if (usedoutput == 5'b00010) begin 
        nextstate = alarm_min;
        LD=5'b10001;
        chooser_clk=clk_200_hz;
        sec_en=0;
        Up_down=1'bx;
        min_en=0;
        hour_en=0;
        alarm_min_en=0;
        alarm_hour_en=0; 
        pflag=1;
      end
      
      else if (usedoutput == 5'b00001) begin 
        nextstate = display_clock;
        LD=5'b00000;
        chooser_clk=clk_out;
        sec_en=1;
        Up_down=1'b1;
        min_en=0;
        hour_en=0;
        alarm_min_en=0;
        alarm_hour_en=0;  
      end
     
      else if (usedoutput == 5'b10000)  begin 
        nextstate = clk_hour;
        LD=5'b11000;
        chooser_clk=clk_200_hz;
        sec_en=0;
        Up_down=1'b1;
        min_en=0;
        hour_en=1;
        alarm_min_en=0;
        alarm_hour_en=0;   
      end
      
      
      else if (usedoutput == 5'b01000) begin 
        nextstate = clk_hour;
        LD=5'b11000;
        chooser_clk=clk_200_hz;
        sec_en=0;
        Up_down=1'b0;
        min_en=0;
        hour_en=1;
        alarm_min_en=0;
        alarm_hour_en=0;  
      end
        
      else begin 
        nextstate = clk_hour;
        LD=5'b11000;
        chooser_clk=clk_200_hz;
        sec_en=0;
        Up_down=1'bx;
        min_en=0;
        hour_en=0;
        alarm_min_en=0;
        alarm_hour_en=0;  
      end
      end 
      
  //CASE 2
    
 
      
      clk_min: begin
      if (usedoutput == 5'b00100) begin 
        nextstate = alarm_hour;
        LD=5'b10010;
        chooser_clk=clk_200_hz;
        sec_en=0;
        Up_down=1'bx;
        min_en=0;
        hour_en=0;
        alarm_min_en=0;
        alarm_hour_en=0;
        pflag=1;
      end 
       else if (usedoutput == 5'b00010)begin 
        nextstate = clk_hour;
        LD=5'b11000;
        chooser_clk=clk_200_hz;
        sec_en=0;
        Up_down=1'bx;
        min_en=0;
        hour_en=0;
        alarm_min_en=0;
        alarm_hour_en=0;
      end
      else if (usedoutput == 5'b00001) begin 
        nextstate = display_clock;
        LD=5'b00000;
        chooser_clk=clk_out;
        sec_en=1;
        Up_down=1'b1;
        min_en=0;
        hour_en=0;
        alarm_min_en=0;
        alarm_hour_en=0; 
      end
      else if (usedoutput == 5'b10000) begin 
        nextstate = clk_min;
        LD=5'b10100;
        chooser_clk=clk_200_hz;
        sec_en=0;
        Up_down=1'b1;
        min_en=1;
        hour_en=0;
        alarm_min_en=0;
        alarm_hour_en=0;
      end
      else if (usedoutput == 5'b01000)begin 
        nextstate = clk_min;
        LD=5'b10100;
        chooser_clk=clk_200_hz;
        sec_en=0;
        Up_down=1'b0;
        min_en=1;
        hour_en=0;
        alarm_min_en=0;
        alarm_hour_en=0;
      end
      else begin 
        nextstate = clk_min;
        LD=5'b10100;
        chooser_clk=clk_200_hz;
        sec_en=0;
        Up_down=1'bx;
        min_en=0;
        hour_en=0;
        alarm_min_en=0;
        alarm_hour_en=0;
      end
      end
      
      
      // CASE 3 
      
      alarm_hour: begin        
      if (usedoutput == 5'b00100) begin 
        nextstate = alarm_min;
        LD=5'b10001;
        chooser_clk=clk_200_hz;
        sec_en=0;
        Up_down=1'bx;
        min_en=0;
        hour_en=0;
        alarm_min_en=0;
        alarm_hour_en=0; 
        pflag=1;
      end
      
       else if (usedoutput == 5'b00010) begin 
        nextstate = clk_min;
        LD=5'b10100;
        chooser_clk=clk_200_hz;
        sec_en=0;
        Up_down=1'bx;
        min_en=0;
        hour_en=0;
        alarm_min_en=0;
        alarm_hour_en=0;
      end
      else if (usedoutput == 5'b00001) begin 
        nextstate = display_clock;
        LD=5'b00000;
        chooser_clk=clk_out;
        sec_en=1;
        Up_down=1'b1;
        min_en=0;
        hour_en=0;
        alarm_min_en=0;
        alarm_hour_en=0; 
      end
      else if (usedoutput == 5'b10000) begin 
        nextstate = alarm_hour;
        LD=5'b10010;
        chooser_clk=clk_200_hz;
        sec_en=0;
        Up_down=1'b1;
        min_en=0;
        hour_en=0;
        alarm_min_en=0;
        alarm_hour_en=1;
        pflag=1;
      end
      else if (usedoutput == 5'b01000) begin 
        nextstate = alarm_hour;
        LD=5'b10010;
        chooser_clk=clk_200_hz;
        sec_en=0;
        Up_down=1'b0;
        min_en=0;
        hour_en=0;
        alarm_min_en=0;
        alarm_hour_en=1;
        pflag=1;
      end
      else begin 
        nextstate = alarm_hour;
        LD=5'b10010;
        chooser_clk=clk_200_hz;
        sec_en=0;
        Up_down=1'bx;
        min_en=0;
        hour_en=0;
        alarm_min_en=0;
        alarm_hour_en=0;
        pflag=1;
      end
      end
      
      // CASE 4 
          
      alarm_min: begin 
      if (usedoutput == 5'b00100)begin 
        nextstate = clk_hour;
        LD=5'b11000;
        chooser_clk=clk_200_hz;
        sec_en=0;
        Up_down=1'bx;
        min_en=0;
        hour_en=0;
        alarm_min_en=0;
        alarm_hour_en=0;
      end
      else if (usedoutput == 5'b00010) begin 
        nextstate = alarm_hour;
        LD=5'b10010;
        chooser_clk=clk_200_hz;
        sec_en=0;
        Up_down=1'bx;
        min_en=0;
        hour_en=0;
        alarm_min_en=0;
        alarm_hour_en=0;
        pflag=1;
      end
      else if (usedoutput == 5'b00001) begin 
        nextstate = display_clock;
        LD=5'b00000;
        chooser_clk=clk_out;
        sec_en=1;
        Up_down=1'b1;
        min_en=0;
        hour_en=0;
        alarm_min_en=0;
        alarm_hour_en=0;  
      end
     
      
      else if (usedoutput == 5'b10000)begin 
        nextstate = alarm_min;
        LD=5'b10001;
        chooser_clk=clk_200_hz;
        sec_en=0;
        Up_down=1'b1;
        min_en=0;
        hour_en=0;
        alarm_min_en=1;
        alarm_hour_en=0;  
        pflag=1;
      end 
      
      else if (usedoutput == 5'b01000)begin
        nextstate = alarm_min;
        LD=5'b10001;
        chooser_clk=clk_200_hz;
        sec_en=0;
        Up_down=1'b0;
        min_en=0;
        hour_en=0;
        alarm_min_en=1;
        alarm_hour_en=0;  
        pflag=1;
      end
      else begin 
        nextstate = alarm_min;
        LD=5'b10001;
        chooser_clk=clk_out;
        sec_en=0;
        Up_down=1'bx;
        min_en=0;
        hour_en=0;
        alarm_min_en=0;
        alarm_hour_en=0; 
        pflag=1; 
      end

      end
      
      
      alarm_mode:
      if (usedoutput != 5'b00000) begin 
        nextstate = display_clock;
        LD=5'b00000;
        chooser_clk=clk_out;
        sec_en=1;
        Up_down=1'b1;
        min_en=0;
        hour_en=0;
        alarm_min_en=0;
        alarm_hour_en=0;  
      end
      
      else begin 
          LD = {0,0,0,0,clk_out};
          nextstate = alarm_mode;
          chooser_clk=clk_out;
          sec_en=1;
          Up_down=1'b1;
          min_en=0;
          hour_en=0;
          alarm_min_en=0;
          alarm_hour_en=0;
      end
      
      default: nextstate = display_clock;

    endcase
  end 
   
reg [3:0] display4 , display3, display2, display1;

always @(state) begin
    case(state)
    alarm_hour:begin
    display4 = ai_4;
    display3 = ai_3;
    display2 = ai_2;
    display1 = ai_1;
    end
    alarm_min: begin
    display4 = ai_4;
    display3 = ai_3;
    display2 = ai_2;
    display1 = ai_1;
    end
    
    clk_hour:begin
    display4 = wi_4;
    display3 = wi_3;
    display2 = wi_2;
    display1 = wi_1;
    end
    clk_min:begin
    display4 = wi_4;
    display3 = wi_3;
    display2 = wi_2;
    display1 = wi_1;
    end
    display_clock:begin
    display4 = wi_4;
    display3 = wi_3;
    display2 = wi_2;
    display1 = wi_1;
    end
    alarm_mode:begin
    display4 = wi_4;
    display3 = wi_3;
    display2 = wi_2;
    display1 = wi_1;
    end
    
    endcase
end

  
always @(posedge clk_200_hz or posedge rst) begin 
    if (rst) begin 
      state <= display_clock; 
    end 
    else begin 
      state <= nextstate; 
    end 
  end 
  
modulo_counters clock(chooser_clk, reset, min_en,hour_en, sec_en, Up_down,wi_2, wi_4, wi_1, wi_3,seconds_OUT);
AlarmCounter alarm(chooser_clk, reset, alarm_min_en, alarm_hour_en, Up_down, ai_2, ai_4, ai_1,ai_3);
counter_x_bit #(2,4) gut(.clk(clk_200_hz), .reset(reset),.en(1'b1),.Up_down(1'b1), .count(sel));
seven_segment display(.inp1(display4),.inp2({display3}),.inp3(display2),.inp4({display1}),.enable(sel),.anode_active(anode_active),.segments(segments)); 
  
endmodule
