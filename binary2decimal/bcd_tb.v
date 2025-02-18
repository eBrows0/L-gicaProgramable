module bcd_tb #(parameter N = 10, iteraciones = 5)();

reg [N-1:0] BCD_in_sw;

wire [0:6] disp_unidad;
wire [0:6] disp_decena;
wire [0:6] disp_centena;
wire [0:6] disp_miles;

bcd DUT(
	.b_in(BCD_in_sw),
	.un(disp_unidad),
	.dec(disp_decena),
	.cent(disp_centena),
	.mil(disp_miles)
);

task set_input();
begin

	BCD_in_sw = $urandom_range(0, 2**N-1);
	$display("Valor a probar = %d", BCD_in_sw);
	#10;
end
endtask 

integer i;

initial
begin
	for(i=0; i<iteraciones; i = i+1)
	begin
		set_input();
	end
end

endmodule
