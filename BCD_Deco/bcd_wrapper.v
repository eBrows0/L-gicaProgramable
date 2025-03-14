module bcd_wrapper (
	input MAX10_CLK1_50,
	input [9:0] SW,
	output [0:6] HEX0, HEX1, HEX2, HEX3
);

	wire[3:0] un_aux, dec_aux, cent_aux, mil_aux;

	assign un_aux = SW%10;
	assign dec_aux = SW%100/10;
	assign cent_aux = SW%1000/100;
	assign mil_aux = SW/1000;
	
	decoder uni_deco (
		.deco_in(un_aux),
		.deco_out(HEX0)
	);
	decoder dec_deco (
		.deco_in(dec_aux),
		.deco_out(HEX1)
	);
	decoder cent_deco (
		.deco_in(cent_aux),
		.deco_out(HEX2)
	);
	decoder mil_deco (
		.deco_in(mil_aux),
		.deco_out(HEX3)
	);

endmodule