module vga_acelerometro(
    input  clk,
    input [3:0] unidades_x,
    input [3:0] decenas_x,
    input [3:0] centenas_x,
    input [3:0] unidades_y,
    input [3:0] decenas_y,
    input [3:0] centenas_y,
    input [3:0] unidades_z,
    input [3:0] decenas_z,
	 input [3:0] centenas_z,
	input signalx,
	input signaly,
	input signalz,
    
    output reg [3:0] VGA_R,
    output reg [3:0] VGA_G,
    output reg [3:0] VGA_B,
    output VGA_HS,
    output VGA_VS
);
    // Parámetro: palabra de 6 letras (48 bits: 6 x 8 bits)
    // Ejemplo: "HOLA  " (espacios se pueden usar para no dibujar)
    parameter [7:0] X_signal = {"X"};
    parameter [7:0] Y_signal = {"Y"};
    parameter [7:0] Z_signal = {"Z"};
    parameter [7:0] equal_signal = {"="};
    parameter [7:0] negative_signal = {"-"};
    parameter [7:0] zero_signal = {"0"};
    parameter [7:0] one_signal = {"1"};
    parameter [7:0] two_signal = {"2"};
    parameter [7:0] three_signal = {"3"};
    parameter [7:0] four_signal = {"4"};
    parameter [7:0] five_signal = {"5"};
    parameter [7:0] six_signal = {"6"};
    parameter [7:0] seven_signal = {"7"};
    parameter [7:0] eight_signal = {"8"};
    parameter [7:0] nine_signal  = {"9"};

    // Parámetros generales para la posición y tamaño de las letras
    localparam X_START       = 50;   // Posición X inicial
    localparam Y_START       = 50;  // Posición Y inicial
    localparam ESPACIO       = 30;   // Espacio entre letras
    localparam LETTER_HEIGHT = 100;  // Alto de las letras
    localparam LETTER_WIDTH  = 60;   // Ancho de las letras

    // Cálculo de posiciones base para cada letra (índices 0 a 5)
    localparam POS_X0 = X_START;
    localparam POS_X1 = POS_X0 + LETTER_WIDTH + ESPACIO;
    localparam POS_X2 = POS_X1 + LETTER_WIDTH + ESPACIO;
    localparam POS_X3 = POS_X2 + LETTER_WIDTH + ESPACIO;
    localparam POS_X4 = POS_X3 + LETTER_WIDTH + ESPACIO;
    localparam POS_X5 = POS_X4 + LETTER_WIDTH + ESPACIO;

    localparam POS_Y0 = Y_START;
    localparam POS_Y1 = POS_Y0 + LETTER_HEIGHT + ESPACIO;
    localparam POS_Y2 = POS_Y1 + LETTER_HEIGHT + ESPACIO;

    // Señales de sincronización y contadores de píxeles (asumiendo que tienes estos módulos implementados)
    wire in_display_area;
    wire [9:0] counter_x;
    wire [9:0] counter_y;
    wire clk_25;

    clock_divider #(.FREQ(25_000_000)) DIVIDIR (
        .clk(clk),
        .rst(0),
        .clk_div(clk_25)
    );

    hvsync_generator hsync_inst (
        .clk(clk_25),
        .vga_h_sync(VGA_HS),
        .vga_v_sync(VGA_VS),
        .counter_x(counter_x),
        .counter_y(counter_y),
        .in_display_area(in_display_area)
    );

    // Señales de píxel para cada letra
    wire pixel_X, pixel_Y, pixel_Z;
    wire pixel_equal_X, pixel_equal_Y, pixel_equal_Z;
    wire pixel_negative_X, pixel_negative_Y, pixel_negative_Z;
    wire pixel_0_X1, pixel_0_X2, pixel_0_X3;
    wire pixel_0_Y1, pixel_0_Y2, pixel_0_Y3;
    wire pixel_0_Z1, pixel_0_Z2, pixel_0_Z3;
    wire pixel_1_X1, pixel_1_X2, pixel_1_X3;
    wire pixel_1_Y1, pixel_1_Y2, pixel_1_Y3;
    wire pixel_1_Z1, pixel_1_Z2, pixel_1_Z3;
    wire pixel_2_X1, pixel_2_X2, pixel_2_X3;
    wire pixel_2_Y1, pixel_2_Y2, pixel_2_Y3;
    wire pixel_2_Z1, pixel_2_Z2, pixel_2_Z3;
    wire pixel_3_X1, pixel_3_X2, pixel_3_X3;
    wire pixel_3_Y1, pixel_3_Y2, pixel_3_Y3;
    wire pixel_3_Z1, pixel_3_Z2, pixel_3_Z3;
    wire pixel_4_X1, pixel_4_X2, pixel_4_X3;
    wire pixel_4_Y1, pixel_4_Y2, pixel_4_Y3;
    wire pixel_4_Z1, pixel_4_Z2, pixel_4_Z3;
    wire pixel_5_X1, pixel_5_X2, pixel_5_X3;
    wire pixel_5_Y1, pixel_5_Y2, pixel_5_Y3;
    wire pixel_5_Z1, pixel_5_Z2, pixel_5_Z3;
    wire pixel_6_X1, pixel_6_X2, pixel_6_X3;
    wire pixel_6_Y1, pixel_6_Y2, pixel_6_Y3;
    wire pixel_6_Z1, pixel_6_Z2, pixel_6_Z3;
    wire pixel_7_X1, pixel_7_X2, pixel_7_X3;
    wire pixel_7_Y1, pixel_7_Y2, pixel_7_Y3;
    wire pixel_7_Z1, pixel_7_Z2, pixel_7_Z3;
    wire pixel_8_X1, pixel_8_X2, pixel_8_X3;
    wire pixel_8_Y1, pixel_8_Y2, pixel_8_Y3;
    wire pixel_8_Z1, pixel_8_Z2, pixel_8_Z3;
    wire pixel_9_X1, pixel_9_X2, pixel_9_X3;
    wire pixel_9_Y1, pixel_9_Y2, pixel_9_Y3;
    wire pixel_9_Z1, pixel_9_Z2, pixel_9_Z3;
    reg [7:0] AUX_X1, AUX_X2, AUX_X3, AUX_Y1, AUX_Y2, AUX_Y3, AUX_Z1, AUX_Z2, AUX_Z3;
    reg [7:0] AUX_negx, AUX_negy, AUX_negz;

    always @(posedge clk)
    begin
        case(signalx)
            1'b0:
            begin
                AUX_negx = 1'b0;
            end
            1'b1:
            begin
                AUX_negx = negative_signal;
            end
        endcase
    end

    always @(posedge clk)
    begin
        case(signaly)
            1'b0:
            begin
                AUX_negy = 1'b0;
            end
            1'b1:
            begin
                AUX_negy = negative_signal;
            end
            default:
            begin
                AUX_negy = 1'b0;
            end
        endcase
    end

    always @(posedge clk)
    begin
        case(signalz)
            1'b0:
            begin
                AUX_negz = negative_signal;
            end
            1'b1:
            begin
                AUX_negz = negative_signal;
            end
            default:
            begin
                AUX_negz = negative_signal;
            end
        endcase
    end

    always @(centenas_x)
    begin
        case (centenas_x)
            4'b0000:
            begin
                AUX_X1 = zero_signal;
            end
            4'b0001: 
            begin
                AUX_X1 = one_signal;
            end
            4'b0010:
            begin
                AUX_X1 = two_signal;
            end
            4'b0011:
            begin
                AUX_X1 = three_signal;
            end
            4'b0100:
            begin
                AUX_X1 = four_signal;
            end
            4'b0101:
            begin
                AUX_X1 = five_signal;
            end
            4'b0110:
            begin
                AUX_X1 = six_signal;
            end
            4'b0111:
            begin
                AUX_X1 = seven_signal;
            end
            4'b1000:
            begin
                AUX_X1 = eight_signal;
            end
            4'b1001:
            begin
                AUX_X1 = nine_signal;
            end
            default:
            begin
                AUX_X1 = zero_signal;
            end
        endcase
    end

    always @(decenas_x)
    begin
        case (decenas_x)
            4'b0000:
            begin
                AUX_X2 = zero_signal;
            end
            4'b0001: 
            begin
                AUX_X2 = one_signal;
            end
            4'b0010:
            begin
                AUX_X2 = two_signal;
            end
            4'b0011:
            begin
                AUX_X2 = three_signal;
            end
            4'b0100:
            begin
                AUX_X2 = four_signal;
            end
            4'b0101:
            begin
                AUX_X2 = five_signal;
            end
            4'b0110:
            begin
                AUX_X2 = six_signal;
            end
            4'b0111:
            begin
                AUX_X2 = seven_signal;
            end
            4'b1000:
            begin
                AUX_X2 = eight_signal;
            end
            4'b1001:
            begin
                AUX_X2 = nine_signal;
            end
            default:
            begin
                AUX_X2 = zero_signal;
            end
        endcase
    end

    always @(unidades_x)
    begin
        case (unidades_x)
            4'b0000:
            begin
                AUX_X3 = zero_signal;
            end
            4'b0001: 
            begin
                AUX_X3 = one_signal;
            end
            4'b0010:
            begin
                AUX_X3 = two_signal;
            end
            4'b0011:
            begin
                AUX_X3 = three_signal;
            end
            4'b0100:
            begin
                AUX_X3 = four_signal;
            end
            4'b0101:
            begin
                AUX_X3 = five_signal;
            end
            4'b0110:
            begin
                AUX_X3 = six_signal;
            end
            4'b0111:
            begin
                AUX_X3 = seven_signal;
            end
            4'b1000:
            begin
                AUX_X3 = eight_signal;
            end
            4'b1001:
            begin
                AUX_X3 = nine_signal;
            end
            default:
            begin
                AUX_X3 = zero_signal;
            end
        endcase
    end

    always @(centenas_y)
    begin
        case (centenas_y)
            4'b0000:
            begin
                AUX_Y1 = zero_signal;
            end
            4'b0001: 
            begin
                AUX_Y1 = one_signal;
            end
            4'b0010:
            begin
                AUX_Y1 = two_signal;
            end
            4'b0011:
            begin
                AUX_Y1 = three_signal;
            end
            4'b0100:
            begin
                AUX_Y1 = four_signal;
            end
            4'b0101:
            begin
                AUX_Y1 = five_signal;
            end
            4'b0110:
            begin
                AUX_Y1 = six_signal;
            end
            4'b0111:
            begin
                AUX_Y1 = seven_signal;
            end
            4'b1000:
            begin
                AUX_Y1 = eight_signal;
            end
            4'b1001:
            begin
                AUX_Y1 = nine_signal;
            end
            default:
            begin
                AUX_Y1 = zero_signal;
            end
        endcase
    end

    always @(decenas_y)
    begin
        case (decenas_y)
            4'b0000:
            begin
                AUX_Y2 = zero_signal;
            end
            4'b0001: 
            begin
                AUX_Y2 = one_signal;
            end
            4'b0010: 
            begin
                AUX_Y2 = two_signal;
            end
            4'b0011:
            begin
                AUX_Y2 = three_signal;
            end
            4'b0100:
            begin
                AUX_Y2 = four_signal;
            end
            4'b0101:
            begin
                AUX_Y2 = five_signal;
            end
            4'b0110:
            begin
                AUX_Y2 = six_signal;
            end
            4'b0111:
            begin
                AUX_Y2 = seven_signal;
            end
            4'b1000:
            begin
                AUX_Y2 = eight_signal;
            end
            4'b1001:
            begin
                AUX_Y2 = nine_signal;
            end
            default:
            begin
                AUX_Y2 = zero_signal;
            end
        endcase
    end

    always @(unidades_y)
    begin
        case (unidades_y)
            4'b0000:
            begin
                AUX_Y3 = zero_signal;
            end
            4'b0001: 
            begin
                AUX_Y3 = one_signal;
            end
            4'b0010:
            begin
                AUX_Y3 = two_signal;
            end
            4'b0011:
            begin
                AUX_Y3 = three_signal;
            end
            4'b0100:
            begin
                AUX_Y3 = four_signal;
            end
            4'b0101:
            begin
                AUX_Y3 = five_signal;
            end
            4'b0110:
            begin
                AUX_Y3 = six_signal;
            end
            4'b0111:
            begin
                AUX_Y3 = seven_signal;
            end
            4'b1000:
            begin
                AUX_Y3 = eight_signal;
            end
            4'b1001:
            begin
                AUX_Y3 = nine_signal;
            end
            default:
            begin
                AUX_Y3 = zero_signal;
            end
        endcase
    end

    always @(centenas_z)
    begin
        case (centenas_z)
            4'b0000:
            begin
                AUX_Z1 = zero_signal;
            end
            4'b0001: 
            begin
                AUX_Z1 = one_signal;
            end
            4'b0010: 
            begin
                AUX_Z1 = two_signal;
            end
            4'b0011:
            begin
                AUX_Z1 = three_signal;
            end
            4'b0100:
            begin
                AUX_Z1 = four_signal;
            end
            4'b0101:
            begin
                AUX_Z1 = five_signal;
            end
            4'b0110:
            begin
                AUX_Z1 = six_signal;
            end
            4'b0111:
            begin
                AUX_Z1 = seven_signal;
            end
            4'b1000:
            begin
                AUX_Z1 = eight_signal;
            end
            4'b1001:
            begin
                AUX_Z1 = nine_signal;
            end
            default:
            begin
                AUX_Z1 = zero_signal;
            end
        endcase
    end

    always @(decenas_z)
    begin
        case (decenas_z)
            4'b0000:
            begin
                AUX_Z2 = zero_signal;
            end
            4'b0001: 
            begin
                AUX_Z2 = one_signal;
            end
            4'b0010:
            begin
                AUX_Z2 = two_signal;
            end
            4'b0011:
            begin
                AUX_Z2 = three_signal;
            end
            4'b0100:
            begin
                AUX_Z2 = four_signal;
            end
            4'b0101:
            begin
                AUX_Z2 = five_signal;
            end
            4'b0110:
            begin
                AUX_Z2 = six_signal;
            end
            4'b0111:
            begin
                AUX_Z2 = seven_signal;
            end
            4'b1000:
            begin
                AUX_Z2 = eight_signal;
            end
            4'b1001:
            begin
                AUX_Z2 = nine_signal;
            end
            default:
            begin
                AUX_Z2 = zero_signal;
            end
        endcase
    end

    always @(unidades_z)
    begin
        case (unidades_z)
            4'b0000:
            begin
                AUX_Z3 = zero_signal;
            end
            4'b0001: 
            begin
                AUX_Z3 = one_signal;
            end
            4'b0010: 
            begin
                AUX_Z3 = two_signal;
            end
            4'b0011:
            begin
                AUX_Z3 = three_signal;
            end
            4'b0100:
            begin
                AUX_Z3 = four_signal;
            end
            4'b0101:
            begin
                AUX_Z3 = five_signal;
            end
            4'b0110:
            begin
                AUX_Z3 = six_signal;
            end
            4'b0111:
            begin
                AUX_Z3 = seven_signal;
            end
            4'b1000:
            begin
                AUX_Z3 = eight_signal;
            end
            4'b1001:
            begin
                AUX_Z3 = nine_signal;
            end
            default:
            begin
                AUX_Z3 = zero_signal;
            end
        endcase
    end

    // Instanciación del módulo acelerometro_generator para cada letra
    // Se extrae el carácter correspondiente del parámetro WORD (8 bits por letra)
    acelerometro_generator character_X (
        .character_generator(X_signal),
        .x(counter_x),
        .y(counter_y),
        .base_x(POS_X0),
        .base_y(POS_Y0),
        .pixel(pixel_X)
    );

    acelerometro_generator character_equalX (
        .character_generator(equal_signal),
        .x(counter_x),
        .y(counter_y),
        .base_x(POS_X1),
        .base_y(POS_Y0),
        .pixel(pixel_equal_X)
    );
    
    acelerometro_generator character_negativeX (
        .character_generator(AUX_negx),
        .x(counter_x),
        .y(counter_y),
        .base_x(POS_X2),
        .base_y(POS_Y0),
        .pixel(pixel_negative_X)
    );

    acelerometro_generator character_0_X1 (
        .character_generator(AUX_X1),
        .x(counter_x),
        .y(counter_y),
        .base_x(POS_X3),
        .base_y(POS_Y0),
        .pixel(pixel_0_X1)
    );

    acelerometro_generator character_0_X2 (
        .character_generator(AUX_X2),
        .x(counter_x),
        .y(counter_y),
        .base_x(POS_X4),
        .base_y(POS_Y0),
        .pixel(pixel_0_X2)
    );

    acelerometro_generator character_0_X3 (
        .character_generator(AUX_X3),
        .x(counter_x),
        .y(counter_y),
        .base_x(POS_X5),
        .base_y(POS_Y0),
        .pixel(pixel_0_X3)
    );

    acelerometro_generator character_Y(
        .character_generator(Y_signal),
        .x(counter_x),
        .y(counter_y),
        .base_x(POS_X0),
        .base_y(POS_Y1),
        .pixel(pixel_Y)
    );

    acelerometro_generator character_equalY (
        .character_generator(equal_signal),
        .x(counter_x),
        .y(counter_y),
        .base_x(POS_X1),
        .base_y(POS_Y1),
        .pixel(pixel_equal_Y)
    );

    acelerometro_generator character_negativeY (
        .character_generator(AUX_negy),
        .x(counter_x),
        .y(counter_y),
        .base_x(POS_X2),
        .base_y(POS_Y1),
        .pixel(pixel_negative_Y)
    );

    acelerometro_generator character_0_Y1 (
        .character_generator(AUX_Y1),
        .x(counter_x),
        .y(counter_y),
        .base_x(POS_X3),
        .base_y(POS_Y1),
        .pixel(pixel_0_Y1)
    );

    acelerometro_generator character_0_Y2 (
        .character_generator(AUX_Y2),
        .x(counter_x),
        .y(counter_y),
        .base_x(POS_X4),
        .base_y(POS_Y1),
        .pixel(pixel_0_Y2)
    );

    acelerometro_generator character_0_Y3 (
        .character_generator(AUX_Y3),
        .x(counter_x),
        .y(counter_y),
        .base_x(POS_X5),
        .base_y(POS_Y1),
        .pixel(pixel_0_Y3)
    );

    acelerometro_generator character_Z (
        .character_generator(Z_signal),
        .x(counter_x),
        .y(counter_y),
        .base_x(POS_X0),
        .base_y(POS_Y2),
        .pixel(pixel_Z)
    );

    acelerometro_generator character_equalZ (
        .character_generator(equal_signal),
        .x(counter_x),
        .y(counter_y),
        .base_x(POS_X1),
        .base_y(POS_Y2),
        .pixel(pixel_equal_Z)
    );

    acelerometro_generator character_negativeZ (
        .character_generator(AUX_negz),
        .x(counter_x),
        .y(counter_y),
        .base_x(POS_X2),
        .base_y(POS_Y2),
        .pixel(pixel_negative_Z)
    );

    acelerometro_generator character_0_Z1 (
        .character_generator(AUX_Z1),
        .x(counter_x),
        .y(counter_y),
        .base_x(POS_X3),
        .base_y(POS_Y2),
        .pixel(pixel_0_Z1)
    );

    acelerometro_generator character_0_Z2 (
        .character_generator(AUX_Z2),
        .x(counter_x),
        .y(counter_y),
        .base_x(POS_X4),
        .base_y(POS_Y2),
        .pixel(pixel_0_Z2)
    );

    acelerometro_generator character_0_Z3 (
        .character_generator(AUX_Z3),
        .x(counter_x),
        .y(counter_y),
        .base_x(POS_X5),
        .base_y(POS_Y2),
        .pixel(pixel_0_Z3)
    );



    // Combina las señales de cada letra: si alguna se activa, se dibuja la letra.
    wire word_pixel;
    assign word_pixel = pixel_X | pixel_Y | pixel_Z | pixel_equal_X | pixel_equal_Y | pixel_equal_Z | pixel_negative_X | pixel_negative_Y | pixel_negative_Z | pixel_0_X1 | pixel_0_X2 | pixel_0_X3 | pixel_0_Y1 | pixel_0_Y2 | pixel_0_Y3 | pixel_0_Z1 | pixel_0_Z2 | pixel_0_Z3 | pixel_1_X1 | pixel_1_X2 | pixel_1_X3 | pixel_1_Y1 | pixel_1_Y2 | pixel_1_Y3 | pixel_1_Z1 | pixel_1_Z2 | pixel_1_Z3 | pixel_2_X1 | pixel_2_X2 | pixel_2_X3 | pixel_2_Y1 | pixel_2_Y2 | pixel_2_Y3 | pixel_2_Z1 | pixel_2_Z2 | pixel_2_Z3 | pixel_3_X1 | pixel_3_X2 | pixel_3_X3 | pixel_3_Y1 | pixel_3_Y2 | pixel_3_Y3 | pixel_3_Z1 | pixel_3_Z2 | pixel_3_Z3 | pixel_4_X1 | pixel_4_X2 | pixel_4_X3 | pixel_4_Y1 | pixel_4_Y2 | pixel_4_Y3 | pixel_4_Z1 | pixel_4_Z2 | pixel_4_Z3 | pixel_5_X1 | pixel_5_X2 | pixel_5_X3 | pixel_5_Y1 | pixel_5_Y2 | pixel_5_Y3 | pixel_5_Z1 | pixel_5_Z2 | pixel_5_Z3 | pixel_6_X1 | pixel_6_X2 | pixel_6_X3 | pixel_6_Y1 | pixel_6_Y2 | pixel_6_Y3 | pixel_6_Z1 | pixel_6_Z2 | pixel_6_Z3 | pixel_7_X1 | pixel_7_X2 | pixel_7_X3 | pixel_7_Y1 | pixel_7_Y2 | pixel_7_Y3 | pixel_7_Z1 | pixel_7_Z2 | pixel_7_Z3 | pixel_8_X1 | pixel_8_X2 | pixel_8_X3 | pixel_8_Y1 | pixel_8_Y2 | pixel_8_Y3 | pixel_8_Z1 | pixel_8_Z2 | pixel_8_Z3 | pixel_9_X1 | pixel_9_X2 | pixel_9_X3 | pixel_9_Y1 | pixel_9_Y2 | pixel_9_Y3 | pixel_9_Z1 | pixel_9_Z2 | pixel_9_Z3;
    // Generación de color: si estamos en el área de visualización y el píxel pertenece a alguna letra, se dibuja en rojo.
    always @(posedge clk_25) begin
        if (in_display_area && word_pixel) begin
            VGA_R <= 4'b1111;
            VGA_G <= 4'b1111;
            VGA_B <= 4'b1111;
        end else begin
            VGA_R <= 4'b0000;
            VGA_G <= 4'b0000;
            VGA_B <= 4'b0000;
        end
    end

endmodule