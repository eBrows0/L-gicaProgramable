module counter_tb();
	reg clk, enable, rst;
	wire[3:0] count_wire;
	
	counter DUT(.clk(clk),.enable(enable),.rst(rst), .count(count_wire));

initial begin
	clk = 0;
	enable =0;
	rst =0;


# 5 rst = 1;
# 10 rst = 0;

# 10 enable = 1;
	end
	always
	begin
	# 5 clk = !clk;
	end

endmodule