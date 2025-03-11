module Frecuenciometro(
    input MAX10_CLK1_50,
    input SW0,
    input [12:0] ARDUINO_IO,
   output wire [0:6] HEX0, 
	output wire [0:6] HEX1, 
	output wire [0:6] HEX2, 
	output wire [0:6] HEX3, 
	output wire [0:6] HEX4, 
	output wire [0:6] HEX5
);

    reg [31:0] counter = 0;
	 reg [31:0] pulse_count = 0;
	 reg flag = 0;
	 reg [16:0] freq = 0;
    
    localparam base_freq = 50_000_000;
	 
	 
	 max_bcd_wrapper bcd(
		.freq(freq),
		.HEX0(HEX0),
		.HEX1(HEX1),
		.HEX2(HEX2),
		.HEX3(HEX3),
		.HEX4(HEX4),
		.HEX5(HEX5)
	 );

	 
    always @(posedge MAX10_CLK1_50 or posedge SW0) 
    begin
        if(SW0) 
            begin
				counter <= 0;
            flag <= 0;
            end 
			else
				begin
				if(counter == base_freq)
					begin
						flag <= 1;
						counter <= 0;
					end
				else
					begin
						flag <= 0;
						counter <= counter +1;
					end
				
				end
    end
	 
	 always @(posedge ARDUINO_IO[0] or posedge flag)
	 begin
		if(ARDUINO_IO[0])
			pulse_count <= pulse_count + 1;
		else if (flag)
			begin
				freq <= pulse_count;
				pulse_count <= 0;
			
			end
	 end

endmodule