.globl edificio

.include "cuadrado.s"
.equ SCREEN_HEIGH, 		480
// w12: color del cristal.
// x11: grosor de las luces.
// x10: posicion en y, de la luz mas alta.
// w9: color del marco del edificio.
// x8: espacio entre luces.
// x7: cantidad de luces.
// w6: color de las luces.
// x5: alto.
// x4: ancho.
// x3: posicion en y.
// x2: posicion en x.
// w1: color del edificio.
// x0: framebuffer.

edificio:
    stp x30, x29, [sp, #-16]!       // guardar direcciones de retorno.
    stp x28, x27, [sp, #-16]!
    stp x21, x22, [sp, #-16]!
    
    mov x22, x2
    mov x28, x3


    //dibujamos el marco de los edificios.
    mov w29, w1
    mov w1, w9
    

    bl cuadrado
    
    // dibujamos la pared del edificio.
    mov w1, w29
    //para dar efecto de borde ajustamos donde se comienza a pintar la pared y las luces.
    add x2, x2, #4  
    add x3, x3, #4
    sub x4, x4, #8

    bl cuadrado    

    // dibujamos las luces.
    mov x5, x11     // grosor de la luz.
    mov w1, w6     // color de la luz.
    mov x21, #0    // contador de luces.
    mov x3, x10

luzp:
    add x3, x3, x8   //espacio entre luces.
    bl cuadrado
    add x21, x21, #1
    cmp x21, x7
    blt luzp

endi:

    // dibujamos una puerta de crital
    mov x4, #26   // ancho del cristal
    ldr x29, =SCREEN_HEIGH
    sub x3, x29, x11
    sub x27, x29, x3
    mov x5, x27          // Guardamos la cantidad de lineas a colorear de las puertas.
    add x2, x22, #51
    mov w1, w12
    
    bl cuadrado
 

    ldp x21, x22, [sp], #16
    ldp x28, x27, [sp], #16
    ldp x30, x29, [sp], #16        // restaurar dirección de retorno.
    ret

