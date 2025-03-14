module mainCounter (
	clk, a, disp
);

	input clk, a;
	output wire[6:0] disp;
	
	
	wire[3:0] count;
	reg rst = 0;
	wire s0, s1;
	
	debouncer deb(
	 .clk(clk),
	 .rst_a_p(rst),
	 .debouncer_in(a),
	 .debouncer_out(s0)
	);
	
	oneshot onesh(
	.clk(clk),
	.a(s0),
	.outS(s1)
	);
	
	counter coun(
	.clk(clk),
	.rst(rst),
	.enable(s1),
	.count(count)
	);
	
	decoder deco(
	.deco_in(count),
	.deco_out(disp)
	);
	
	endmodule