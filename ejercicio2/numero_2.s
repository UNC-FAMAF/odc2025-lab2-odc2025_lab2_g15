.ifndef numero_2
.globl numero_2
//w1: color de la letra.
// x0: framebuffer
// x2: posicion en x.
// x3: posicion en y.
// x4: ancho del zepelin.
// x5: alto del zepelin.
//w2: color del fondo.
.include "cuadrado.s"
.equ SCREEN_WIDTH, 		640

numero_2:
    sub sp, sp, #8
    stur lr, [sp]
    stp x7, x8, [sp, #-16]!
    stp x9, x10, [sp, #-16]!
    stp x11, x12, [sp, #-16]!
    stp x13, x14, [sp, #-16]!
    stp x15, x16, [sp, #-16]!
    stp x17, x18, [sp, #-16]!

    // Va a constar de 3 rectagulos horizontal y 2 columnas.
    // Establecemos el ancho de cada rectangulo horizontal.
    lsr x7, x4, #3 // cantidad de filas, nos sirve como comparar con algun contador.
    // Establecemos el largo de los rectangulos horizontales.
    lsr x8, x4, #1 // Nos sirve para compararlo con un contador.
    sub x8, x8, #1
    // Establecemos los x correspondientes a cada estructura.
        // Calculamos el alto de cada pilar.
        lsr x9, x5, #1
        //-----------------------------------------------------------------------------------------
    //Para el primer ractangulo 
        //Posicion en x
        lsr x10, x4, #2     //Desplazamiento para pintar el largo solicitado. 
        sub x10, x2, x10    // Nos paramos en la primera columna a pintar, (nos sirve para los 3 redtangulos horizontales y unos de los pilares).
    // calculamos los y, para los rectangulos y pilares (la parte mas complicada)
        //primero debemos definir el espacio (fila) entre cada rectangulos horizontal.
        // 1er rectangulo.
        mov x11, x3
        // 2do rectangulo.
        add x12, x3, x9     // estamos parados en la mitad del numero.
        lsr x13, x4, #4     // Es la mitad del grosor que vamos a pintar.
        sub x12, x12,x13    // Tenemos la altura del segundo pilar.
        //3ro rectangulo.
        add x14, x3, x5     // estamos parados sobre la ultima fila del numero.
        sub x14, x14, x7    // Estamos en la fila para pintar el ultimo rectangulo.
    // Nos falta calcular el ultimo x para el pilar de mas a la derecha.
        lsr x15, x4, #2     //Desplazamiento para pintar el largo solicitado. 
        add x15, x2, x15    // Nos paramos en la primera columna a pintar.
        sub x15, x15, x7    // Posicion encontrada.
    // Guardamos la informacion original.
    mov x16, x2
    mov x17, x3
    mov x18, x4
    // Pintamos el fondo.
        mov x2, x10
        mov x3, x11
        mov x4, x8
        bl cuadrado

    //Primer rectangulo.
        mov x2, x10
        mov x3, x11
        mov x4, x8
        mov x5, x7
        mov w1, w6
        bl cuadrado
    // Segundo rectangulo.
        mov x2, x10
        mov x3, x12
        mov x4, x8
        mov x5, x7
        bl cuadrado
    // Tercer rectangulo.
        mov x2, x10
        mov x3, x14
        mov x4, x8
        mov x5, x7
        bl cuadrado
    // primer pilar
        mov x2, x15
        mov x3, x11
        mov x4, x7
        mov x5, x9
        bl cuadrado
    // segundo pilar
        mov x2, x10
        mov x3, x12
        mov x4, x7
        mov x5, x9
        bl cuadrado


    ldp x17, x18, [sp], #16
    ldp x15, x16, [sp], #16
    ldp x13, x14, [sp], #16
    ldp x11, x12, [sp], #16
    ldp x9, x10, [sp], #16
    ldp x7, x8, [sp], #16
    ldur lr, [sp]
    add sp, sp, #8

.endif

ret

