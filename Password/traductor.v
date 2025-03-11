module traductor(
    input [9:0] switches,    
    output reg [3:0] num 
);

    integer i;
    reg [3:0] count;  
    reg [3:0] position; 

    always @(*) begin
        count = 0;
        position = 0;
        
        for (i = 0; i < 10; i = i + 1) begin
            if (switches[i]) begin
                count = count + 1;
                position = i;
            end
        end
        
        if (count == 1) begin
            num = position;
        end
        else begin
            num = 10;
        end
    end
endmodule