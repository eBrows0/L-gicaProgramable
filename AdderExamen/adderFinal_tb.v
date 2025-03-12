`timescale 1ns/1ps

module adderFinal_tb;
    reg clk, rst_a_p, enable;
    reg [3:0] count;
    wire [0:6] unidades, decenas, centenas;
    
    // Instancia del módulo a probar
    adderFinal #(.FREQ(1)) uut (
        .clk(clk),
        .rst_a_p(rst_a_p),
        .enable(enable),
        .count(count),
        .unidades(unidades),
        .decenas(decenas),
        .centenas(centenas)
    );

    // Generador de reloj
    always #5 clk = ~clk; // Periodo de 10ns (100MHz)

    initial begin
        // Inicialización de señales
        clk = 0;
        rst_a_p = 1;
        enable = 0;
        count = 4'd5;  // Probar con un valor de count = 5

        // Aplicar reset
        #10 rst_a_p = 0;

        // Esperar un poco y activar enable
        #10 enable = 1;
        
        // Esperar suficiente tiempo para que termine la sumatoria
        #100 enable = 0;

        // Probar otro valor de count
        #20 count = 4'd3;
        enable = 1;
        
        // Esperar
        #100 enable = 0;

        // Finalizar simulación
        #50 $finish;
    end

    // Monitoreo de señales
    initial begin
        $monitor("Time: %0t | State: %d | Counter: %d | Sum: %d | unidades: %b | decenas: %b | centenas: %b", 
                 $time, uut.current_state, uut.counter, uut.sum, unidades, decenas, centenas);
    end
endmodule
