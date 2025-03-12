module clkdiv#(parameter FREQ = 1)(
    input clk, rst,
    output reg clk_div
    );

    localparam constantN = 50_000_000;
    localparam countMax = (constantN/(2*FREQ));

    // Compute the log2 value using a localparam
    function integer ceillog2;
        input integer data;
        integer i, result;
        begin
            result = 0;
            for(i=0; 2**i < data; i=i+1)
                result = i+1;
            ceillog2 = result;
        end
    endfunction

    // Store the computed width in a localparam
    localparam COUNT_WIDTH = ceillog2(countMax);

    // Now use COUNT_WIDTH instead of dynamic computation
    reg [COUNT_WIDTH-1:0] count;

    always@(posedge clk or posedge rst)
    begin
        if (rst)
            count <= 0;
        else if (count == countMax - 1)
            count <= 0;
        else
            count <= count + 1;
    end

    always@(posedge clk or posedge rst)
    begin
        if (rst)
            clk_div <= 0;
        else if (count == countMax - 1)
            clk_div <= ~clk_div;
    end

endmodule
