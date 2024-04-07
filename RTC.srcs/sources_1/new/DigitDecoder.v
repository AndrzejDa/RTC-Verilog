`timescale 1ns / 1ps

module DigitDecoder(
    input [18:0] seconds,
    output reg [3:0] hours_tens,
    output reg [3:0] hours_ones,
    output reg [3:0] minutes_tens, 
    output reg [3:0] minutes_ones
    );

    
    always @(seconds) begin
        hours_tens <= seconds / 36000;
        hours_ones <= (seconds / 3600) % 10;
        minutes_tens <= (seconds / 600) % 6;
        minutes_ones <= (seconds / 60) % 10;
    end
endmodule
