.ifndef letra_o
.globl letra_o
//w1: color de la letra.
// x0: framebuffer
// x2: posicion en x.
// x3: posicion en y.
// x4: ancho del zepelin.
// x5: alto del zepelin.
//w2: color del fondo.
.include "cuadrado.s"
.equ SCREEN_WIDTH, 		640

letra_o:
    sub sp, sp, #8
    stur lr, [sp]
    stp x7, x8, [sp, #-16]!
    stp x9, x10, [sp, #-16]!
    stp x11, x12, [sp, #-16]!
    stp x13, x14, [sp, #-16]!
    stp x15, x16, [sp, #-16]!
    stp x17, x18, [sp, #-16]!
    stp x19, x20, [sp, #-16]!
    // vamos a crear el cuadrado/rectangulo donde vamos a hacer la letra.
    // por logicas razones tiene que ser mas chico que 

    //pintamos el fondo
    lsr x10, x4, #2        // es la cuarta parte del ancho, entonces tenemos aca la cantidad de pixeles que queremos pintar en la primera fila.
    sub x11, x2, x10
    mov x7, x2
    mov x2, x11
    mov x14, x4
    // guardamos la cuarta parte del ancho.
    mov x17, x10

    lsl x10, x10, #1    // mitad del ancho
    mov x12, x10
    mov x4, x10
    //ancho del cuadrado es.
    mov x16, x4
    // definimos maximo desplazamiento en x.
    mov x18, x10


    bl cuadrado
    //restauramos valores originales.
    mov x2, x7
    mov x4, x14
    // Volvemos a mover los valores de los argumentos.
    mov x7, x5  //alto original.
    mov x5, #1

    mov x9, x2  //x original.

    mov x11, x3 //y original.

    mov x13, x4 // ancho original.

    mov w15, w1 // color original.
    // Contadores.
    // definimos que el ancho de la letra es una ocatab parte del ancho de la imagen.
    lsr x12, x4, #3  // va a ser nuestro parametro para el alto de las filas para el techo y la parte inferior, y el desplazamiento en x para los pilares (parametro de contador).
    mov x8, #0      // Contador de filas.
    sub x2, x2, x12 //Tecnicamente nos desplazamos un ocatvo a la izquierda para empezar a pintar un cuarto del ancho.
    mov w1, w6
    lsr x4, x4, #2
 
.superior_o:
    cmp x8, x12
    b.ge .end_fso           // si ya pintamos todas las filas, salimos

    bl cuadrado             // pintamos fila actual
    add x8, x8, #1          // contador de fila

    cmp x4, x16
    b.ge .repetir_so

    add x4, x4, #4          // aumenta ancho solo si aún no se pasó
    sub x2, x2, #2          // centrar la expansión
    add x3, x3, #1          // siguiente fila
    b .superior_o

.repetir_so:
    mov x4, x16
    sub x2, x9, x18         // reposicionar correctamente
    add x3, x3, #1
    b .superior_o

.end_fso:
    // Restauramos los valores de entrada.
    mov x2, x9
    mov x3, x11
    mov x4, x13
    //Inferior
    // Guardamos algunos valores.
    mov x10, x3             // y origianl.
    mov x9, x2              // x original.
    mov x15, x4
    // Calculamos la altura donde empezar a pintar.
    add x3, x3, x7
    sub x3, x3, #1          // altura mas baja
    mov x8, #0              // contador de filas
    lsr x4, x4, #2
    sub x2, x2, x12 

.inferior_o:
    cmp x8, x12
    b.ge .end_fio           // si ya pintamos todas las filas, salimos

    bl cuadrado             // pintamos fila actual
    add x8, x8, #1          // contador de fila

    cmp x4, x16
    b.ge .repetir_io

    add x4, x4, #4          // aumenta ancho solo si aún no se pasó
    sub x2, x2, #2          // centrar la expansión
    sub x3, x3, #1          // siguiente fila
    b .inferior_o

.repetir_io:
    mov x4, x16
    sub x2, x9, x18         // reposicionar correctamente
    sub x3, x3, #1
    b .inferior_o

.end_fio:

    // Restauramos valores
    mov x3, x10           // y origianl.
    mov x2, x9           // x original.
    mov x4, x15
    mov x5, x7
    // guardamos valores.
    mov x11, x2
    mov x14, x3
     
    add x3, x3, x12
    sub x2, x2, x17
    mov x4, x12

    lsl x9, x12, #1
    sub x9, x7, x9
    mov x5, x9

    bl cuadrado

    // Restauramos valores
    mov x2, x11
    mov x3, x14
    
    add x3, x3, x12
    add x2, x2, x17
    sub x2, x2, x4
    add x2, x2, #1

    bl cuadrado
    
    ldp x19, x20, [sp], #16
    ldp x17, x18, [sp], #16
    ldp x15, x16, [sp], #16
    ldp x13, x14, [sp], #16
    ldp x11, x12, [sp], #16
    ldp x9, x10, [sp], #16
    ldp x7, x8, [sp], #16
    ldur lr, [sp]
    add sp, sp, #8
    ret

.endif
