`timescale 1ns / 1ps

module Prescaler #(parameter N = 100000000)(
    input button_test_i,
    input clk_i,
    output reg pres_o
);
    
    reg[31:0] counter;
    always @(posedge clk_i) begin
        if (clk_i) begin
            if (counter < (N/(999*button_test_i + 1)))
                counter = counter + 1;
            else
                counter = 1;

            if (counter > ((N/(999*button_test_i + 1)) / 2))
                pres_o = 1'b1;
            else
                pres_o = 1'b0;
        end
    end
endmodule
