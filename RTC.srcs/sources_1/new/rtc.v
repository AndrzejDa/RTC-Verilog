`timescale 1ns / 1ps

module rtc(clk_i, rst_i, button_hr_i, button_min_i, button_test_i, led7_seg_o, led7_an_o);
    
    input clk_i;
    input rst_i;
    input button_hr_i;
    input button_min_i;
    input button_test_i;
    output [7:0] led7_seg_o;
    output [7:0] led7_an_o;
    
    wire b_hr_deb;
    wire b_min_deb;
    wire b_test_deb;
    wire pclk;
    wire clk_1ms;
    
    Prescaler pres(button_test_i, clk_i, rst_i, pclk);
    Prescaler #(100000) pres_1ms (button_test_i, clk_i, rst_i, clk_1ms); 
    debouncer db_hr(button_hr_i, rst_i, clk_i, b_hr_deb);
    debouncer db_min(button_min_i, rst_i, clk_i, b_min_deb);
    debouncer db_test(button_test_i, rst_i, clk_i, b_test_deb);
    Display seg7(pclk, clk_1ms, rst_i, b_hr_deb, b_min_deb, b_test_deb, led7_seg_o, led7_an_o);
    
    
endmodule
