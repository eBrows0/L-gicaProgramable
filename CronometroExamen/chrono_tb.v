`timescale 1ns/1ps

module chrono_tb;

    reg clk;
    reg rst;
    wire [0:6] HEX0, HEX1, HEX2, HEX3, HEX4;


    chrono DUT (
        .MAX10_CLK2_50(clk),
        .SW0(rst),
        .HEX0(HEX0),
        .HEX1(HEX1),
        .HEX2(HEX2),
        .HEX3(HEX3),
        .HEX4(HEX4)
    );
    

    always #10 clk = ~clk; 
    
    initial begin

        clk = 0;
        rst = 1;
        #50; 
        rst = 0; 
    
      
        #1000000000; 
    
        $stop; 
    end
endmodule
