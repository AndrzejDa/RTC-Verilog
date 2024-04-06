`timescale 1ns / 1ps

module Display(
    input clk_i,
    input sync,
    input rst_i,
    input button_hr_i,
    input button_min_i,
    input button_test_i,
    output reg [7:0] led7_seg_o,
    output reg [7:0] led7_an_o
    );
    
    reg dot;
    reg [1:0] n_seg;
    reg [6:0] numbers;
    integer hours_tens;   
    integer hours_ones;   
    integer minutes_tens; 
    integer minutes_ones; 
    integer seconds = 0;
    integer counter = 0;
    
    
    
    
    initial begin      
        numbers[0] <= 7'b0000001;
        numbers[1] <= 7'b1001111;
        numbers[2] <= 7'b0010010;
        numbers[3] <= 7'b0000110;
        numbers[4] <= 7'b1001100;
        numbers[5] <= 7'b0100100;
        numbers[6] <= 7'b0100000;
        numbers[7] <= 7'b0001111;
        numbers[8] <= 7'b0000000;
        numbers[9] <= 7'b0000100;
        hours_tens <= 1;
        hours_ones <= 2;
        minutes_tens <= 0;
        minutes_ones <= 0;
        n_seg <= 1;
        dot <= 1;
    end
    
    always @(posedge clk_i or posedge rst_i or posedge button_hr_i or posedge button_min_i) begin
        if(rst_i) begin
 
        end else if (clk_i)begin
            if(seconds < 86400)
                seconds = seconds + 1;
            else seconds = 1;            
        end else if (button_hr_i) 
            if (seconds < 82800)
              seconds = seconds + 3600;
            else
              seconds = seconds - 82800;
        else if (button_min_i)
            if (seconds < 86340)
              seconds = seconds + 60;
            else
              seconds = seconds - 86340;
    end
    
    
    always @* begin
        hours_tens   = hours_tens + (seconds / 36000); 
        hours_ones   = hours_ones + ((seconds / 3600) % 10); 
        minutes_tens = minutes_tens + ((seconds / 600) % 6); 
        minutes_ones = minutes_ones + ((seconds / 60) % 10);   
    end
    
    always @(posedge sync) begin
        case(n_seg)
            1: begin
                led7_an_o = 8'b11110111;
                led7_seg_o = {numbers[hours_tens], 1'b1};
                n_seg = 2;            
            end
            2: begin
                led7_an_o = 8'b11111011;
                led7_seg_o = {numbers[hours_ones], dot};
                n_seg = 3;
            end
            3: begin
                led7_an_o = 8'b11111101;
                led7_seg_o = {numbers[minutes_tens], 1'b1};
                n_seg = 4;
            end
            4: begin
                led7_an_o = 8'b11111110;
                led7_seg_o = {numbers[minutes_ones], 1'b1};
                n_seg = 0;        
            end        
        endcase
    end
    
    
endmodule
