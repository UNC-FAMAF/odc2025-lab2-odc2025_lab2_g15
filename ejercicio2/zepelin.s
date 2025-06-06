
.globl zepe
.include "ovalo.s"
// x0 : framebuffer
// w1: color del zepelin.
// x2: posicion en x.
// x3: posicion en y.
// x4: ancho del zepelin.
// x5: alto del zepelin.
// w6: color de la aleta.
.equ SCREEN_WIDTH, 		640

zepe:
    sub sp, sp, #8
    stur lr, [sp]
    stp x7, x8, [sp, #-16]!   
    stp x9, x10, [sp, #-16]!   
    stp x11, x12, [sp, #-16]!   
    stp x13, x14, [sp, #-16]!   
    stp x15, x16, [sp, #-16]!    
    stp x17, x18, [sp, #-16]!   
    stp x21, x22, [sp, #-16]!   
    //Aleta del zepelin
    mov x8, x3// 
    ldr x9, =SCREEN_WIDTH // 
    mul x10, x9, x8       // fila mas alta del zepelin.
    lsr x11, x4, #1         //
    sub x12, x2, x11        //  columna donde empezar a dibujar.

    add x13, x10, x12       //  fila y columna.
    lsl x13, x13, #2       // 
    add x13, x13, x0        // tenemos el offset el primer pixel a pintar.

    mov x14, #1            //  contador de los pixeles pintados.
    mov x15, x5             //  cantidad de filas.
    lsr x21, x5, #1        //  mitad de las filas.

.cambio_fila_loop:
    mov x16, x14            //  cantidad de pixeles a pintar.
    mov x17, x13           //  posicion del primer pixel a pintar.
.pintar_fila_loop:
    str w6, [x17], #4      //  pintamos el primer pixel y nos desplazamos hacia el siguiente.
    subs x16, x16, #1       //  descrementamos en uno la cantidad de pixeles a pintar.
    bne .pintar_fila_loop

    add x14, x14, #1       //  incrementamos en uno la cantidad de pixeles a pintar para la siguiente fila.
    mov x18, x9            // 
    lsl x18, x18, #2         // pasamos a bytes el desplazamiento de la fila
    add x13, x13, x18      //  estamos sobre la proxima fila.
    sub x15, x15, #1        //  decrementamos en 1 la cantidad de filas a pintar.
    subs xzr, x15, x21      // 
    bne .cambio_fila_loop

    sub x14, x14, #2            //  contador de los pixeles a pintar.
.otra_fila_loop:    
    mov x16, x14           //  cantidad de pixeles a pintar.
    mov x17, x13            //  posicion del primer pixel a pintar.
.fila_loop:
    str w6, [x17], #4       //pintamos el primer pixel y nos desplazamos hacia el siguiente.
    subs x16, x16, #1       // descrementamos en uno la cantidad de pixeles a pintar.
    bne .fila_loop

    subs x14, x14, #1       // decrementamos en uno la cantidad de pixeles a pintar para la siguiente fila.
    b.eq .end
    mov x18, x9            // 
    lsl x18, x18, #2       //  pasamos a bytes el desplazamiento de la fila
    add x13, x13, x18      // estamos sobre la proxima fila.
    subs x15, x15, #1        //  decrementamos en 1 la cantidad de filas a pintar.
    bne .otra_fila_loop

.end:

    // ovalo 
    bl ovalo_zepelin

    ldp x21, x22, [sp], #16 
    ldp x17, x18, [sp], #16 
    ldp x15, x16, [sp], #16 
    ldp x13, x14, [sp], #16 
    ldp x11, x12, [sp], #16 
    ldp x9, x10, [sp], #16 
    ldp x7, x8, [sp], #16 
    ldur lr, [sp]
    add sp, sp, #8
ret
