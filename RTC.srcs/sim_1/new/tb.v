`timescale 1ns / 1ps

module tb;
    reg clk_i = 1'b0;
    reg rst_i = 1'b0;
    reg button_hr_i = 1'b0;
    wire sw_o;
    wire pclk;
    
    rtc uut (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .button_hr_i(button_hr_i),
        .sw_o(sw_o),
        .pclk(pclk)    
    );
    
    always begin
        #5;
        clk_i <= ~clk_i;
    end
    
endmodule
