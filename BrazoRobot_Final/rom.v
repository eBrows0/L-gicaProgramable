module rom (
    input clk,
    input rst,
    output reg [19:0] rom_x, rom_y, rom_z  
);
    reg [15:0] rom [0:29]; 
    reg [4:0] index_x = 0;
	 reg [4:0] index_y = 1;
	 reg [4:0] index_z = 2;
	 
	 

	wire clkdiv;

	clock_divider #(.FREQ(1)) clk_div (
		.clk(clk),
		.rst(rst),
		.clk_div(clkdiv)
	);
	  
    initial begin
        $readmemb("xyz.bin", rom);
    end
	
	always @(posedge clk)
	begin
			 rom_x <= rom[index_x];
			 rom_y <= rom[index_y];
			 rom_z <= rom[index_z];
	
	end
		
    
    always @(posedge clkdiv or posedge rst) begin
        if (rst) begin
            index_x <= 0;
				index_y <= 1;
				index_z <= 2;
        end 
        else begin
            if (index_z <= 30) begin  
               index_x <= index_x + 3;
					index_y <= index_y + 3;
					index_z <= index_z + 3;
					end
					else begin
					index_x <= 0;
				   index_y <= 1;
				   index_z <= 2;
				   end
          end
				    	
        end
    
endmodule