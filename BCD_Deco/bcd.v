module bcd(
	input[9:0] b_in,
	output wire[6:0] un, dec, cent, mil
);
	wire[3:0] un_aux, dec_aux, cent_aux, mil_aux;

	assign un_aux = b_in%10;
	assign dec_aux = b_in%100/10;
	assign cent_aux = b_in%1000/100;
	assign mil_aux = b_in/1000;
	
	decoder uni_deco (
		.deco_in(un_aux),
		.deco_out(un)
	);
	decoder dec_deco (
		.deco_in(dec_aux),
		.deco_out(dec)
	);
	decoder cent_deco (
		.deco_in(cent_aux),
		.deco_out(cent)
	);
	decoder mil_deco (
		.deco_in(mil_aux),
		.deco_out(mil)
	);

endmodule