`timescale 1ns / 1ps

module Prescaler(
    input button_test_i,
    input clk_i,
    input rst_i,
    input button_hr_i,
    input button_min_i,
    output reg pres_o
);
    parameter N = 100000000;
    integer counter = 0;
    integer seconds = 0;
    reg temp = 0;
    always @(posedge clk_i or posedge rst_i or posedge button_test_i or posedge button_hr_i or posedge button_min_i) begin
        if (rst_i) begin
            counter <= 0;
            temp <= 0;
        end else if (clk_i) begin
            if (counter == N/2) begin
                temp <= ~temp;
                counter <= 1;
            end else begin
                if(seconds < 86400)
                    seconds = seconds + 1;
                else seconds = 1;
                pres_o = temp;    
            end
        end else if (button_hr_i) begin
            if (seconds < 82800)
              seconds = seconds + 3600;
            else seconds = seconds - 82800;
        end else if (button_min_i) begin
            if (seconds < 86340)
              seconds = seconds + 60;
            else
              seconds = seconds - 86340;
        end else if (button_test_i) begin
            if (counter == N/2000) begin
                temp <= ~temp;
                seconds = seconds + 1;
                counter <= 1;
            end else begin
                if(seconds < 86400)
                    seconds = seconds + 1;
                else seconds = 1;
                pres_o = temp;
            end    
        end 
    end
    
endmodule
