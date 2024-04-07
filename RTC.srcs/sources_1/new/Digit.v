`timescale 1ns / 1ps

module Digit(
        input wire [3:0]  digit,
        output reg [6:0] seg_digit
    );

   always @(digit)
      if (digit == 0)
        seg_digit = 7'b0000001;
      else if (digit == 1)
        seg_digit = 7'b1001111;
      else if (digit == 2)
        seg_digit = 7'b0010010;
      else if (digit == 3)
        seg_digit = 7'b0000110;
      else if (digit == 4)
        seg_digit = 7'b1001100;
      else if (digit == 5)
        seg_digit = 7'b0100100;
      else if (digit == 6)
        seg_digit = 7'b0100000;
      else if (digit == 7)
        seg_digit = 7'b0001111;
      else if (digit == 8)
        seg_digit = 7'b0000000;
      else if (digit == 9)
        seg_digit = 7'b0000100;

endmodule

