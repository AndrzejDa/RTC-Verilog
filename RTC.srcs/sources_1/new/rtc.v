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
    //wire [18:0] seconds;
    wire [3:0] hours_tens;
    wire [3:0] hours_ones;
    wire [3:0] minutes_tens;
    wire [3:0] minutes_ones;
    
    wire [27:0] display4digits;
    
    debouncer db_hr(button_hr_i, rst_i, clk_i, b_hr_deb);
    debouncer db_min(button_min_i, rst_i, clk_i, b_min_deb);
    debouncer db_test(button_test_i, rst_i, clk_i, b_test_deb);
    
    Prescaler pres(button_test_i, clk_i, rst_i, b_hr_deb, b_min_deb, pclk);
    DisplaySync dync(clk_i, clk_1ms);     
    DigitDecoder decoder(pclk, hours_tens, hours_ones, minutes_tens, minutes_ones);
    Digit d1(hours_tens, display4digits[27:21]);
    Digit d2(hours_ones, display4digits[20:14]);
    Digit d3(minutes_tens, display4digits[13:7]);
    Digit d4(minutes_ones, display4digits[6:0]);
    Display seg7(pclk, clk_1ms, rst_i, display4digits[27:21], display4digits[20:14], display4digits[13:7], display4digits[6:0], led7_seg_o, led7_an_o);
    
    
endmodule
