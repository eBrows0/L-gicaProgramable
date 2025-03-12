module chrono (
	input MAX10_CLK1_50,
	input [9:0] SW,
	output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4
);

	localparam fseg = 1;
	localparam fmil = 1000;
	
	reg [5:0] seg;
	reg [9:0] mseg;
	wire clkseg, clkmseg;
	
clkdiv #(.FREQ(fseg)) segunds(
		.clk(MAX10_CLK1_50),
		.rst(SW[0]),
		.clk_div(clkseg)
	);
	
clkdiv #(.FREQ(fmil)) milers(
		.clk(MAX10_CLK1_50),
		.rst(SW[0]),
		.clk_div(clkmseg)
	);
	
	
always@(posedge clkseg or posedge SW[0])
begin
      if (SW[0])
      seg <= 0;
		else
		begin
			if (seg >= 59)
			seg <= 0;
			else if(SW[1])
			seg <= seg;
			else 
			seg <= seg + 1;
		end
end

always@(posedge clkmseg or posedge SW[0])
begin
   if (SW[0])
      mseg <= 0;
		else
		begin
			if (seg >= 999)
			mseg <= 0;
			else if(SW[1])
			mseg <= mseg;
			else 
			mseg <= mseg + 1;
		end
end

	wire [3:0] unidades_seg = seg %10;
	wire [3:0] decenas_seg = (seg/10)%10;

	wire [3:0] unidades_mseg = mseg %10;
	wire [3:0] decenas_mseg = (mseg/10)%10;
	wire [3:0] centenas_mseg = (mseg /100)%10;

decoder s0(
	.deco_in(unidades_mseg),
	.deco_out(HEX0)
);
decoder s1(
	.deco_in(decenas_mseg),
	.deco_out(HEX1)
);
decoder s2(
	.deco_in(centenas_mseg),
	.deco_out(HEX2)
);
decoder s3(
	.deco_in(unidades_seg),
	.deco_out(HEX3)
);
decoder s4(
	.deco_in(decenas_seg),
	.deco_out(HEX4)
);

endmodule