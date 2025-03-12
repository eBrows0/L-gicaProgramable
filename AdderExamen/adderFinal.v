module adderFinal#(parameter FREQ = 1)(
	input clk, rst_a_p, enable,
	input [3:0] count, 
	output [0:6] unidades, decenas, centenas
	);
	
	parameter IDLE=0, SUM=1, PRINT=2;
	reg [3:0] current_state, next_state;
	reg [4:0] counter;
	reg [7:0] sum;
	reg flag;
	wire s0;
	
	clkdiv #(.FREQ(FREQ)) divider(
		.clk(clk),
		.rst(rst_a_p),
		.clk_div(s0)
	);
	
	wire [3:0] unis = sum %10;
	wire [3:0] decs = (sum/10)%10;
	wire [3:0] cents = (sum/100)%10;
	
	decoder uni(
		.deco_in(unis),
		.deco_out(unidades)
	);
	decoder dec(
		.deco_in(decs),
		.deco_out(decenas)
	);
	decoder cent(
		.deco_in(cents),
		.deco_out(centenas)
	);
	
	
	
	always @(posedge s0 or posedge rst_a_p)
	begin
		if(rst_a_p)
				current_state <= IDLE;
		else
			current_state <= next_state;		
	end
	
	always @(posedge s0)
	begin
	if (current_state == SUM)
		begin
			if(counter <= count)
			begin
			counter <= counter + 1;
			sum <= sum + counter;
			end
			else
			flag <= 1;
		end
			
		if (current_state == IDLE)
		begin
		flag <= 0;
			counter <= 0;
			sum <= 0;
		end
	end
	
	always @(current_state or enable)
	begin
		case(current_state)
		IDLE:
		begin
			if(enable == 0)
				next_state = IDLE;
			else
				next_state = SUM;
		end
		SUM:
		begin
			if(!flag)
				next_state = SUM;
			else
				next_state = PRINT;
		end
		PRINT:
		begin
			if(!enable)
				next_state = IDLE;
			else
				next_state = PRINT;
		end
	endcase
	end
endmodule