module exp1
    #(parameter x = 3, // Number of bits in the counter
      parameter n = 8) 
    (input clk, reset, enable,
     output reg [x-1:0] count);
    
    always @(posedge clk, posedge reset) begin
        if (reset)
            count <= 0; 
        else if (enable)
            count <= (count == n - 1) ? 0 : count + 1; // Increment the counter if enabled and not at maximum value
    end
endmodule