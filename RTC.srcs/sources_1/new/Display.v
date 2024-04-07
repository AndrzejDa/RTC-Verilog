`timescale 1ns / 1ps

module Display(
    input clk_i,
    input sync,
    input wire [6:0] hours_tens,
    input wire [6:0] hours_ones,
    input wire [6:0] minutes_tens,
    input wire [6:0] minutes_ones,
    output reg [7:0] led7_seg_o,
    output reg [7:0] led7_an_o
    );
    
    reg dot;
    reg [1:0] n_seg;
    
    initial dot <= 0;
    
    always @(posedge clk_i) dot = ~dot;          
    
    always @(posedge sync) begin
        if (n_seg <= 3)
            begin                 
             led7_an_o = ~(8'b1 << (3 - n_seg));
             if (n_seg == 0) begin
                led7_seg_o = {hours_tens, 1'b1};
             end else if (n_seg == 1) begin
                led7_seg_o = {hours_ones, dot};
             end else if (n_seg == 2) begin
                led7_seg_o = {minutes_tens, 1'b1};
             end else if (n_seg == 3) begin
                led7_seg_o = {minutes_ones, 1'b1};
             end
             n_seg = n_seg + 1;
            end
        else
            n_seg = 0;
    end
    
    
endmodule
