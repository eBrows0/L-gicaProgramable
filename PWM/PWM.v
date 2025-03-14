module PWM(
    input button_inc,
    input button_dec,
    input clk,
    input rst,
    output reg pwm_out
);

wire neg_button_inc = ~button_inc;
wire neg_button_dec = ~button_dec;
wire slow_clk;
wire debounced_button_inc, debounced_button_dec;

parameter base_freq = 'd50_000_000;
parameter target_freq = 'd50;
parameter counts = base_freq / target_freq;

//Cantidad de counts
reg [31:0] DC;

clock_divider u1( clk, rst, slow_clk);

button_debouncer d0( neg_button_inc, slow_clk, rst, debounced_button_inc);
button_debouncer d1( neg_button_dec, slow_clk, rst, debounced_button_dec);

//Generar duty cycle
always @(posedge slow_clk or posedge rst)
    begin
        if(debounced_button_dec)
            begin
            DC <= DC - //El porcentaje a cacmbiar;
            end
        else
            
    end

endmodule

module button_debouncer(
    input clk,
    input button_in,
    input rst,
    output reg button_out
);

wire Q0, Q1, Q2, Q2_bar;
wire slow_clk;

clock_divider u1( clk, rst, slow_clk);

d_ff d0( slow_clk, button_in, Q0);
d_ff d1( slow_clk, Q0, Q1);
d_ff d2( slow_clk, Q1, Q2);

assign Q2_bar = ~Q2;
assign button_out = Q1 & Q2_bar;

endmodule

module d_ff(
    input slow_clk,
    input D,
    output reg Q
);

always @(posedge slow_clk)
    begin
        Q <= D;
    end

endmodule

//Comentar lo siguiente para simular
'`timescale 1ns/1ps
module button_debouncer_tb;

reg button_in;
reg clk;
reg rst;
wire button_out;

button_debouncer DUT(
    .button_in(button_in),
    .clk(clk),
    .rst(rst),
    .button_out(button_out)
);

always # 10 clk <= ~clk;

initial begin
    rst = 0;
    # 100;
    rst = 1;
    # 100;
    rst = 0;

    # 100;
    button_in = 1;
    # 100;
    button_in = 0;
    # 100;
    button_in = 1;
    # 100;
    button_in = 0;
end
endmodule