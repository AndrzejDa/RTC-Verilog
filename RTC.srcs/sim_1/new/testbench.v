`timescale 1ns / 1ps


module testbench;
    reg clk_i = 0;
    reg rst_i = 0;
    reg button_hr_i = 0;
    reg button_min_i = 0;
    reg button_test_i = 1;
    wire [7:0] led7_seg_o;
    wire [7:0] led7_an_o;
    
    rtc uut (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .button_hr_i(button_hr_i),
        .button_min_i(button_min_i),
        .button_test_i(button_test_i),
        .led7_seg_o(led7_seg_o),
        .led7_an_o(led7_an_o)
    );
    
    always begin
        #5;
        clk_i <= ~clk_i;
    end
    
    initial begin
        #100;
        button_hr_i = 1;
        #55000000
        button_hr_i = 0;
        #10000000
        button_hr_i = 1;
        #40000000
        button_hr_i = 0;
    end
    
endmodule
