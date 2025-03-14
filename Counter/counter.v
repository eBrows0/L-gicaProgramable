module counter(clk,rst,enable,count, num2load, load, upordown);

	input clk, rst, enable, upordown, load;
	input[3:0] num2load;
	output reg [3:0] count;



	always @(posedge clk or posedge rst)
	begin
		if(rst == 1)
			count <= 0;
		else if(load == 1)
			count <= num2load;
		else if(enable & upordown)
			count <= count+1;
		else if(enable & !upordown)
			count <= count-1;
		else
			count <= count;
	end
endmodule