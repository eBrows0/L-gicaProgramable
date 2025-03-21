module acelerometro_generator(
    input [7:0] character_generator,
    input [9:0] x,
    input [9:0] y,
    input [9:0] base_x,
    input [9:0] base_y,
    output pixel
);
    // Parámetros internos para el tamaño de la letra
    localparam LETTER_HEIGHT = 100;
    localparam LETTER_WIDTH  = 60;
    localparam LINE_WIDTH    = 20;

    reg pix;
    
    always @(*) begin
        // Por defecto, no se dibuja nada
        pix = 1'b0;
        case(character_generator)
            // X
8'h58: if ((x - base_x) >= ((y - base_y) * (LETTER_WIDTH - LINE_WIDTH)) / LETTER_HEIGHT &&
            (x - base_x) <= ((y - base_y) * (LETTER_WIDTH - LINE_WIDTH)) / LETTER_HEIGHT + LINE_WIDTH &&
            (y >= base_y) && (y < base_y + LETTER_HEIGHT)) 
            pix = 1'b1;
        else if ((x - base_x) >= (((LETTER_HEIGHT - (y - base_y)) * (LETTER_WIDTH - LINE_WIDTH)) / LETTER_HEIGHT) &&
                 (x - base_x) <= (((LETTER_HEIGHT - (y - base_y)) * (LETTER_WIDTH - LINE_WIDTH)) / LETTER_HEIGHT + LINE_WIDTH) &&
                 (y >= base_y) && (y < base_y + LETTER_HEIGHT))
            pix = 1'b1;

				//Y
				8'h59: begin
    // Línea diagonal izquierda (desde esquina superior izquierda hasta el centro)
    if ((x >= base_x + (y - base_y) * (LETTER_WIDTH/2 - LINE_WIDTH/2) / (LETTER_HEIGHT/2)) &&
        (x < base_x + (y - base_y) * (LETTER_WIDTH/2 - LINE_WIDTH/2) / (LETTER_HEIGHT/2) + LINE_WIDTH) &&
        (y >= base_y) && (y < base_y + LETTER_HEIGHT/2))
        pix = 1'b1;

    // Línea diagonal derecha (desde esquina superior derecha hasta el centro)
    else if ((x >= base_x + LETTER_WIDTH - (y - base_y) * (LETTER_WIDTH/2 - LINE_WIDTH/2) / (LETTER_HEIGHT/2) - LINE_WIDTH) &&
             (x < base_x + LETTER_WIDTH - (y - base_y) * (LETTER_WIDTH/2 - LINE_WIDTH/2) / (LETTER_HEIGHT/2)) &&
             (y >= base_y) && (y < base_y + LETTER_HEIGHT/2))
        pix = 1'b1;

    // Línea vertical central (desde el centro hasta la base)
    else if ((x >= base_x + LETTER_WIDTH/2 - LINE_WIDTH/2) &&
             (x < base_x + LETTER_WIDTH/2 + LINE_WIDTH/2) &&
             (y >= base_y + LETTER_HEIGHT/2) && (y < base_y + LETTER_HEIGHT))
        pix = 1'b1;
end
// Z
8'h5A: begin
    // Línea horizontal superior
    if ((x >= base_x) && (x < base_x + LETTER_WIDTH) && (y >= base_y) && (y < base_y + LINE_WIDTH))
        pix = 1'b1;
    
    // Línea horizontal inferior
    else if ((x >= base_x) && (x < base_x + LETTER_WIDTH) &&
             (y >= base_y + LETTER_HEIGHT - LINE_WIDTH) && (y < base_y + LETTER_HEIGHT))
        pix = 1'b1;

    // Línea diagonal (corregida para ir de superior derecha a inferior izquierda)
    else if ((x >= base_x + LETTER_WIDTH - (y - base_y) * LETTER_WIDTH / LETTER_HEIGHT - LINE_WIDTH/2) &&
             (x < base_x + LETTER_WIDTH - (y - base_y) * LETTER_WIDTH / LETTER_HEIGHT + LINE_WIDTH/2) &&
             (y > base_y) && (y < base_y + LETTER_HEIGHT))
        pix = 1'b1;
end

    // Igual "="
    8'h3D: if (((x >= base_x) && (x < base_x + LETTER_WIDTH) &&
            (y >= base_y + LETTER_HEIGHT / 3) && (y < base_y + LETTER_HEIGHT / 3 + LINE_WIDTH)) ||                       ((x >= base_x) && (x < base_x + LETTER_WIDTH) &&
            (y >= base_y + 2 * LETTER_HEIGHT / 3) && (y < base_y + 2 * LETTER_HEIGHT / 3 + LINE_WIDTH)))
    pix = 1'b1;
	 
	 //"-"
	 8'h2D: if ((x >= base_x) && (x < base_x + LETTER_WIDTH) &&
           (y >= base_y + LETTER_HEIGHT / 2 - LINE_WIDTH / 2) && 
           (y < base_y + LETTER_HEIGHT / 2 + LINE_WIDTH / 2))
    pix = 1'b1;

    // Números 0-9
    // 0
    8'h30: if (((x >= base_x) && (x < base_x + LINE_WIDTH) && (y >= base_y) && (y < base_y + LETTER_HEIGHT)) ||  // Borde izquierdo
               ((x >= base_x + LETTER_WIDTH - LINE_WIDTH) && (x < base_x + LETTER_WIDTH) && (y >= base_y) && (y < base_y + LETTER_HEIGHT)) || // Borde derecho
               ((x >= base_x) && (x < base_x + LETTER_WIDTH) && (y >= base_y) && (y < base_y + LINE_WIDTH)) || // Línea superior
               ((x >= base_x) && (x < base_x + LETTER_WIDTH) && (y >= base_y + LETTER_HEIGHT - LINE_WIDTH) && (y < base_y + LETTER_HEIGHT))) // Línea inferior
        pix = 1'b1;

    // 1
    8'h31: if (((x >= base_x + LETTER_WIDTH / 2 - LINE_WIDTH / 2) && (x < base_x + LETTER_WIDTH / 2 + LINE_WIDTH / 2) && (y >= base_y) && (y < base_y + LETTER_HEIGHT)) || // Línea vertical
               ((y >= base_y + LETTER_HEIGHT - LINE_WIDTH) && (y < base_y + LETTER_HEIGHT) && (x >= base_x) && (x < base_x + LETTER_WIDTH))) // Base del 1
        pix = 1'b1;

   // 2
    8'h32: if (((y >= base_y) && (y < base_y + LINE_WIDTH) && (x >= base_x) && (x < base_x + LETTER_WIDTH)) ||  // Línea superior
               ((y >= base_y + LETTER_HEIGHT - LINE_WIDTH) && (y < base_y + LETTER_HEIGHT) && (x >= base_x) && (x < base_x + LETTER_WIDTH)) || // Línea inferior
               ((x >= base_x + LETTER_WIDTH - LINE_WIDTH) && (x < base_x + LETTER_WIDTH) && (y >= base_y) && (y < base_y + LETTER_HEIGHT / 2)) || // Lado derecho arriba
               ((x >= base_x) && (x < base_x + LINE_WIDTH) && (y >= base_y + LETTER_HEIGHT / 2) && (y < base_y + LETTER_HEIGHT))) // Lado izquierdo abajo
        pix = 1'b1;


    // 3
    8'h33: if (((x >= base_x) && (x < base_x + LETTER_WIDTH) && (y >= base_y) && (y < base_y + LINE_WIDTH)) || // Línea superior
               ((x >= base_x) && (x < base_x + LETTER_WIDTH) && (y >= base_y + LETTER_HEIGHT / 2 - LINE_WIDTH / 2) && (y < base_y + LETTER_HEIGHT / 2 + LINE_WIDTH / 2)) || // Línea media
               ((x >= base_x) && (x < base_x + LETTER_WIDTH) && (y >= base_y + LETTER_HEIGHT - LINE_WIDTH) && (y < base_y + LETTER_HEIGHT)) || // Línea inferior
               ((x >= base_x + LETTER_WIDTH - LINE_WIDTH) && (x < base_x + LETTER_WIDTH) && (y >= base_y) && (y < base_y + LETTER_HEIGHT))) // Lado derecho
        pix = 1'b1;

    // 4
    8'h34: if (((x >= base_x) && (x < base_x + LINE_WIDTH) && (y >= base_y) && (y < base_y + LETTER_HEIGHT / 2)) || // Lado izquierdo
               ((x >= base_x) && (x < base_x + LETTER_WIDTH) && (y >= base_y + LETTER_HEIGHT / 2 - LINE_WIDTH / 2) && (y < base_y + LETTER_HEIGHT / 2 + LINE_WIDTH / 2)) || // Línea media
               ((x >= base_x + LETTER_WIDTH - LINE_WIDTH) && (x < base_x + LETTER_WIDTH) && (y >= base_y) && (y < base_y + LETTER_HEIGHT))) // Lado derecho
        pix = 1'b1;

    // 5
    8'h35: if (((x >= base_x) && (x < base_x + LETTER_WIDTH) && (y >= base_y) && (y < base_y + LINE_WIDTH)) || // Línea superior
               ((x >= base_x) && (x < base_x + LINE_WIDTH) && (y >= base_y) && (y < base_y + LETTER_HEIGHT / 2)) || // Lado izquierdo arriba
               ((x >= base_x) && (x < base_x + LETTER_WIDTH) && (y >= base_y + LETTER_HEIGHT / 2 - LINE_WIDTH / 2) && (y < base_y + LETTER_HEIGHT / 2 + LINE_WIDTH / 2)) || // Línea media
               ((x >= base_x + LETTER_WIDTH - LINE_WIDTH) && (x < base_x + LETTER_WIDTH) && (y >= base_y + LETTER_HEIGHT / 2) && (y < base_y + LETTER_HEIGHT)) || // Lado derecho abajo
               ((x >= base_x) && (x < base_x + LETTER_WIDTH) && (y >= base_y + LETTER_HEIGHT - LINE_WIDTH) && (y < base_y + LETTER_HEIGHT))) // Línea inferior
        pix = 1'b1;

    // 6
    8'h36: if (((x >= base_x) && (x < base_x + LINE_WIDTH) && (y >= base_y) && (y < base_y + LETTER_HEIGHT)) || // Lado izquierdo
               ((x >= base_x + LETTER_WIDTH - LINE_WIDTH) && (x < base_x + LETTER_WIDTH) && (y >= base_y + LETTER_HEIGHT / 2) && (y < base_y + LETTER_HEIGHT)) || // Lado derecho abajo
               ((x >= base_x) && (x < base_x + LETTER_WIDTH) && (y >= base_y + LETTER_HEIGHT / 2 - LINE_WIDTH / 2) && (y < base_y + LETTER_HEIGHT / 2 + LINE_WIDTH / 2)) || // Línea media
               ((x >= base_x) && (x < base_x + LETTER_WIDTH) && (y >= base_y + LETTER_HEIGHT - LINE_WIDTH) && (y < base_y + LETTER_HEIGHT))) // Línea inferior
        pix = 1'b1;

    // 7
    8'h37: if (((x >= base_x) && (x < base_x + LETTER_WIDTH) && (y >= base_y) && (y < base_y + LINE_WIDTH)) || // Línea superior
               ((x >= base_x + LETTER_WIDTH - LINE_WIDTH) && (x < base_x + LETTER_WIDTH) && (y >= base_y) && (y < base_y + LETTER_HEIGHT))) // Lado derecho
        pix = 1'b1;

    // 8
8'h38: if (((x >= base_x) && (x < base_x + LETTER_WIDTH) && (y >= base_y) && (y < base_y + LINE_WIDTH)) || // Línea superior
           ((x >= base_x) && (x < base_x + LETTER_WIDTH) && (y >= base_y + LETTER_HEIGHT - LINE_WIDTH) && (y < base_y + LETTER_HEIGHT)) || // Línea inferior
           ((x >= base_x) && (x < base_x + LINE_WIDTH) && (y >= base_y) && (y < base_y + LETTER_HEIGHT)) || // Lado izquierdo
           ((x >= base_x + LETTER_WIDTH - LINE_WIDTH) && (x < base_x + LETTER_WIDTH) && (y >= base_y) && (y < base_y + LETTER_HEIGHT)) || // Lado derecho
           ((x >= base_x) && (x < base_x + LETTER_WIDTH) && (y >= base_y + LETTER_HEIGHT / 2 - LINE_WIDTH / 2) && (y < base_y + LETTER_HEIGHT / 2 + LINE_WIDTH / 2))) // Línea media
    pix = 1'b1;
	 
// 9
8'h39: if (((x >= base_x + LETTER_WIDTH - LINE_WIDTH) && (x < base_x + LETTER_WIDTH) && (y >= base_y) && (y < base_y + LETTER_HEIGHT)) || // Lado derecho
           ((x >= base_x) && (x < base_x + LINE_WIDTH) && (y >= base_y) && (y < base_y + LETTER_HEIGHT / 2)) || // Lado izquierdo arriba
           ((x >= base_x) && (x < base_x + LETTER_WIDTH) && (y >= base_y + LETTER_HEIGHT / 2 - LINE_WIDTH / 2) && (y < base_y + LETTER_HEIGHT / 2 + LINE_WIDTH / 2)) || // Línea media
           ((x >= base_x) && (x < base_x + LETTER_WIDTH) && (y >= base_y && y < base_y + LINE_WIDTH))) // Línea superior
    pix = 1'b1;

        endcase
    end
    
    assign pixel = pix;

endmodule
