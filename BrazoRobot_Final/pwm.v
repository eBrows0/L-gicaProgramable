module pwm (
    input clk,          
    input select,
	 input rst,
	 input grab,
	 input signx, signy, signz,
	 input [15:0] data_x, data_y, data_z,
    output reg out1, out2, out3, out4
);

localparam FREQ = 100;
localparam PERIOD = 20'd999_999;
localparam MIN_PULSE = 20'd25_000;  
localparam MAX_PULSE = 20'd125_000;  
localparam CENTER_PULSE = 20'd65_000;
localparam COUNTER_CODO = 20'd10_000; 
localparam STEP = 20'd1_000;

reg [19:0] counter = 0;
reg [19:0] target_pulsex = CENTER_PULSE;
reg [19:0] target_pulsey = CENTER_PULSE;
reg [19:0] target_pulsez = CENTER_PULSE;
reg [19:0] target_pulseg = CENTER_PULSE;

wire [19:0] rom_x;
wire [19:0] rom_y;
wire [19:0] rom_z;
//reg prev_left, prev_right;

wire clkdiv;

clock_divider #(.FREQ(FREQ)) clk_div (
	.clk(clk),
	.rst(rst),
	.clk_div(clkdiv)
);

//Instanciar MEMORIA ROM

rom romemory (
	.clk(clk),
	.rst(rst),
	.rom_x(rom_x),
	.rom_y(rom_y),
	.rom_z(rom_z)
);


always @(posedge clk) begin
    if (counter < PERIOD)
        counter <= counter + 1;
    else
        counter <= 0;
end

	

always @(posedge clkdiv) begin
    if (rst) begin
        target_pulsex <= CENTER_PULSE;
		  target_pulsey <= CENTER_PULSE;
		  target_pulsez <= CENTER_PULSE;
    end
	 
	 if(grab)
		target_pulseg <= MAX_PULSE;
	 else
		target_pulseg <= MIN_PULSE;
	 
      
        if (select == 0) begin
		  
				if(signx == 0)
					target_pulsex <= (data_x*185)+75000;
				else
					target_pulsex <= ((data_x*-1)*185)+75000;
				
				if(signy == 0)
					target_pulsey <= (data_y*185)+75000;
				else
					target_pulsey <= ((data_y*-1)*185)+75000;
					
				if(signz == 0)
					target_pulsez <= (data_z*185)+75000;
				else
					target_pulsez <= ((data_z*-1)*185)+75000;
				
				
       end
		 else
		 begin
		 
			target_pulsex <= rom_x;
			target_pulsey <= rom_y;
			target_pulsez <= rom_z;
		 
		 end

    end


always @(*) begin
    out1 = (counter < target_pulsex);
	 out2 = (counter < target_pulsey);
	 out3 = (counter < target_pulsez);
	 out4 = (counter < target_pulseg);
end

endmodule