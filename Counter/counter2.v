module counter2(clk,rst,enable,count, upordown);

	input clk, rst, enable, upordown;
	output reg [3:0] count;



	always @(posedge clk or posedge rst)
	begin
		if(rst == 1)
			count <= 0;
		else if(enable & upordown)
			count <= count+1;
		else if(enable & !upordown)
			count <= count-1;
		else
			count <= count;
	end
endmodule