module pwm (
    input clk,          
    input btn_left,     
    input rst,           
    input btn_right,     
    output reg pwm_out   
);


localparam PERIOD = 20'd999_999;     
localparam MIN_PULSE = 20'd25_000;  
localparam MAX_PULSE = 20'd125_000;  
localparam CENTER_PULSE = 20'd65_000;
localparam STEP = 20'd29_778;         

reg [19:0] counter = 0;
reg [19:0] target_pulse = CENTER_PULSE;
reg prev_left, prev_right;


always @(posedge clk) begin
    if (counter < PERIOD)
        counter <= counter + 1;
    else
        counter <= 0;
end


always @(posedge clk) begin
    prev_left <= btn_left;
    prev_right <= btn_right;
end


always @(posedge clk) begin
    if (rst) begin
        target_pulse <= CENTER_PULSE;
    end
    else begin
      
        if (btn_left && !prev_left) begin
            if (target_pulse > MIN_PULSE)
                target_pulse <= target_pulse - STEP;
        end
        
        
        if (btn_right && !prev_right) begin
            if (target_pulse < MAX_PULSE)
                target_pulse <= target_pulse + STEP;
        end
    end
end


always @(*) begin
    pwm_out = (counter < target_pulse);
end

endmodule