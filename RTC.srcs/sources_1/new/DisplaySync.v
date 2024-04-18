`timescale 1ns / 1ps

module DisplaySync(
    input clk_i,
    //input rst_i,
    output reg pres_o
);
    parameter N = 100000;
    integer counter = 0;
    reg temp = 0;
    always @(posedge clk_i) begin
        if (counter == N/2) begin
            temp <= ~temp;
            counter <= 1;
        end else begin
            counter <= counter + 1;    
        end; 
    end
    
    always @* begin
        pres_o = temp;
    end
endmodule
