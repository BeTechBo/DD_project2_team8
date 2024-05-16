module seven_segment(
input [3:0] num,
input [1:0] enable,
output reg [3:0] anode_active,
output reg [6:0] segments
);
integer x=0;
integer z=0;
always @ (num, enable) begin
    case(enable)
        4'b0000: begin
            anode_active = 4'b0111;
        end
        4'b0001: begin
            anode_active = 4'b1011;
        end
        4'b0010: begin
            anode_active = 4'b1101;
           
            
        end
        4'b0011: begin
            anode_active = 4'b1110;
        end
    endcase



 case(num)
  4'b0000: segments = 7'b0000001; // Complement of 1111110
  4'b0001: segments = 7'b1001111; // Complement of 0110000
  4'b0010: segments = 7'b0010010; // Complement of 1101101
  4'b0011: segments = 7'b0000110; // Complement of 1111001
  4'b0100: segments = 7'b1001100; // Complement of 0110011
  4'b0101: segments = 7'b0100100; // Complement of 1011011
  4'b0110: segments = 7'b0100000; // Complement of 1011111
  4'b0111: segments = 7'b0001111; // Complement of 1110000
  4'b1000: segments = 7'b0000000; // Complement of 1111111
  4'b1001: segments = 7'b0000100; // Complement of 1111011
  default: segments = 7'b1111111;
  endcase

end
endmodule