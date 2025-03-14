module clock_divider #(parameter freq = 2)
(
    input clk,
    input rst,
    output reg clk_div
);

localparam clk_freq = 50_000_000; //Cambiar a 3 para probar
localparam count_max = clk_freq/(2*freq);

reg [31:0] count;
//reg [ceillog2(count_max)-1:0] count;

//Este always cuenta a 32
always @(posedge clk or posedge rst)
    begin
        if(rst==1'b1)
            begin
            count <= 32'b0;
            end
        else if(count == count_max-1)
            begin
            count <= 32'b0;
            end
        else
            begin
            count <= count + 1;
            end
    end
	 
	
//Este always actualiza cada que se llega a 32
always @(posedge clk or posedge rst)
    begin
        if(rst==1)
            begin
            clk_div <= 1'b0;
            end
        else if(count == count_max-1)// == clk_freq/2 para que pase cada segundo
            begin
            clk_div <= ~clk_div;
            end
        else
            begin
            clk_div <= clk_div;
            end
    end

endmodule