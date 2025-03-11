module password#(parameter FREQ = 1)(
	input clk,
	input [0:9] switches,
	output reg [6:0] hex0, hex1, hex2, hex3, hex4
	);
	
	parameter Idle=0, dig1=1, dig2=2, dig3=3, dig4=4, error=5, correct = 6;
	
	wire [0:9] os_Switches;
	
	reg [2:0] current_state, next_state, counter;
	
	wire [0:3] inputNum;
	
	reg reset = 0;
	wire clk_div;
	
	clkdiv clok(
		.clk(clk),
		.rst(reset),
		.clk_div(clk_div)
		
	);

	oneshot o1(
		.a(switches[0]),
		.clk(clk_div),
		.outS(os_Switches[0])
	);
	oneshot o2(
		.a(switches[1]),
		.clk(clk_div),
		.outS(os_Switches[1])
	);
	oneshot o3(
		.a(switches[2]),
		.clk(clk_div),
		.outS(os_Switches[2])
	);
	oneshot o4(
		.a(switches[3]),
		.clk(clk_div),
		.outS(os_Switches[3])
	);
	oneshot o5(
		.a(switches[4]),
		.clk(clk_div),
		.outS(os_Switches[4])
	);
	oneshot o6(
		.a(switches[5]),
		.clk(clk_div),
		.outS(os_Switches[5])
	);
	oneshot o7(
		.a(switches[6]),
		.clk(clk_div),
		.outS(os_Switches[6])
	);
	oneshot o8(
		.a(switches[7]),
		.clk(clk_div),
		.outS(os_Switches[7])
	);
	oneshot o9(
		.a(switches[8]),
		.clk(clk_div),
		.outS(os_Switches[8])
	);
	oneshot o10(
		.a(switches[9]),
		.clk(clk_div),
		.outS(os_Switches[9])
	);
	
	
	traductor tradu (
		.switches(os_Switches),
		.num(inputNum)
	);
		
	always @(posedge clk_div or posedge reset)
	begin
		if(reset)
		begin
				current_state <= Idle;
				counter <= 0;
		end
				
		else
		begin
			current_state <= next_state;
				
				case (next_state)
                dig1: counter <= 1;
                dig2: counter <= 2;
                dig3: counter <= 3;
                dig4: counter <= 4;
                correct, error: counter <= 0;
                default: counter <= counter;
            endcase
			end
	end
	
	always @(current_state or inputNum)
	begin
		case(current_state)
		Idle:
		begin
				hex4 = 7'b1111_111;
            hex3 = 7'b1111_111;
            hex2 = 7'b1111_111;
            hex1 = 7'b1111_111;
            hex0 = 7'b1111_111;
		
			if(inputNum == 10)
				next_state = Idle;
			else if(inputNum == 2 && counter == 0)
				next_state = dig1;
			else if(inputNum == 0 && counter == 1)
				next_state = dig2;
			else if(inputNum == 1 && counter == 2)
				next_state = dig3;
			else if(inputNum == 6 && counter == 3)
				next_state = dig4;
			else
				next_state = error;
		end
		dig1:
		begin
		hex0 = 0;
				next_state = Idle;
		end
		dig2:
		begin
		hex1 = 0;
				next_state = Idle;
		end
		dig3:
		begin
		hex2 = 0;
				next_state = Idle;
		end
		dig4:
		begin
		hex3 = 0;
				next_state = correct;
		end
		correct:
		begin
				hex4 = 7'b1111_111;
            hex3 = 7'b0100_001;
            hex2 = 7'b1000_000;
            hex1 = 7'b1001_000;
            hex0 = 7'b0000_110;
		
				if(inputNum == 10)
					next_state = correct;
				else
					next_state = Idle;
		end
		error:
		begin
				hex4 = 7'b0000_110;
            hex3 = 7'b0101_111;
            hex2 = 7'b0101_111;
            hex1 = 7'b0100_011;
            hex0 = 7'b0101_111;
				
				if(inputNum == 10)
					next_state = error;
				else
					next_state = Idle;
		end
		
		
	endcase
	end
	
	
endmodule