module hvsync_generator(
    input clk,
    output vga_h_sync,
    output vga_v_sync,
    output reg in_display_area,
    output reg [9:0] counter_x,
    output reg [9:0] counter_y
);

    reg vga_HS;
    reg vga_VS;

    wire counter_x_max = (counter_x == 800);
    wire counter_y_max = (counter_y == 525);

    always @(posedge clk)
    begin
        if (counter_x_max)
        begin
            counter_x <= 0;
            if (counter_y_max)
            begin
                counter_y <= 0;
            end
            else
            begin
                counter_y <= counter_y + 1;
            end
        end
        else
        begin
            counter_x <= counter_x + 1;
        end 
    end

    always @(posedge clk)
    begin
        vga_HS <= ((counter_x > (640+16)) && (counter_x <= (640+16+96)));
        vga_VS <= ((counter_y > (480+10)) && (counter_y <= (480+10+2)));
    end

    always @(posedge clk)
    begin
        in_display_area <= (counter_x <= 640) && (counter_y <= 480);
    end

    assign vga_h_sync = vga_HS;
    assign vga_v_sync = vga_VS;

endmodule