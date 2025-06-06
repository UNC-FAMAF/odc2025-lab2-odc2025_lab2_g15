
// x0 : framebuffer
// w1: color del zepelin.
// x2: posicion en x.
// x3: posicion en y.
// x4: ancho del zepelin.
// x5: alto del zepelin.
// w6: color de la aleta.

.equ SCREEN_WIDTH, 		640

ovalo_zepelin:
    // Guardar registros usados
    sub sp, sp, #8
    stur lr, [sp]
    stp x7, x8, [sp, #-16]!
    stp x9, x10, [sp, #-16]!
    stp x11, x12, [sp, #-16]!
    stp x13, x14, [sp, #-16]!
    stp x15, x16, [sp, #-16]!
    stp x17, x18, [sp, #-16]!
    stp x21, x22, [sp, #-16]!
    //queremos que la primera fila pinte la mitad del ancho del zepelin
    //el dato x2 estara en la mitad, entonces tengo que desplazar esa mitad atras, osea 
    mov x7, x3// 
    ldr x8, =SCREEN_WIDTH // 
    mul x9, x7, x8       // fila mas alta del zepelin.
    lsr x10, x4, #2        // es la cuarta parte del ancho, entonces tenemos aca la cantidad de pixeles que queremos pintar en la primera fila.
    sub x11, x2, x10      //  columna donde empezar a dibujar.
    lsr x22, x4, #1

    add x13, x11, x9
    lsl x13, x13, #2       // Pasamos de bits a bytes.
    add x13, x13, x0       // posicion del primer pixel a pintar.

    // definimos ahora los contadores.
    lsr x14, x5, #1 //Calculamos la mitad de las filas de pintar.
    mov x15, #0     // Contador de filas pintadas.
    lsl x18, x10, #1

.superior:
    mov x16, x18
    mov x17, x13
.fila:
    str w1, [x17], #4
    subs x16, x16, #1
    bne .fila

    add x15, x15, #1    // pintamos una fila
    subs xzr, x14, x15  //controlamos la cantidad de filas
    b.eq .fin_superior
    add x18, x18, #4   // Definimos cuantos pixeles va a pintar en la proxima fila.
    cmp x18, x4
    b.ge .limite
    sub x11, x11, #2   // nos movemos uno a la izquierda en las columnas.
    add x7, x7, #1      // avanzamos en la filas.
    mul x9, x7, x8
    add x13, x9, x11
    lsl x13, x13, #2       // Pasamos de bits a bytes.
    add x13, x13, x0       // posicion del primer pixel a pintar.
    b .superior
.limite:
    mov x18, x4
    sub x11, x2, x22    // nos movemos uno a la izquierda en las columnas.
    add x7, x7, #1      // avanzamos en la filas.
    mul x9, x7, x8
    add x13, x9, x11
    
    lsl x13, x13, #2       // Pasamos de bits a bytes.
    add x13, x13, x0       // posicion del primer pixel a pintar.
    b .superior

.fin_superior:

    add x7, x3, x5
    sub x7, x7, #1
    mul x9, x7, x8   

    lsr x10, x4, #2        
    sub x11, x2, x10

    add x13, x11, x9
    lsl x13, x13, #2      
    add x13, x13, x0 

 // definimos ahora los contadores.
    lsr x14, x5, #1 //Calculamos la mitad de las filas de pintar.
    mov x15, #0     // Contador de filas pintadas.
    lsl x18, x10, #1

.inferior:
    mov x16, x18
    mov x17, x13
.fila2:
    str w1, [x17], #4
    subs x16, x16, #1
    bne .fila2

    add x15, x15, #1    // pintamos una fila
    subs xzr, x14, x15
    b.eq .end_zepe

    add x18, x18, #2   // Definimos cuantos pixeles va a pintar en la proxima fila.
    cmp x18, x4
    b.ge .tope

    sub x11, x11, #1   // nos movemos uno a la izquierda en las columnas.
    sub x7, x7, #1      // avanzamos en la filas.
    mul x9, x7, x8
    add x13, x9, x11
    lsl x13, x13, #2       // Pasamos de bits a bytes.
    add x13, x13, x0       // posicion del primer pixel a pintar.
    b .inferior
.tope:
    mov x18, x4
    sub x11, x2, x22    // nos movemos uno a la izquierda en las columnas.
    sub x7, x7, #1      // avanzamos en la filas.
    mul x9, x7, x8
    add x13, x9, x11
    
    lsl x13, x13, #2       // Pasamos de bits a bytes.
    add x13, x13, x0       // posicion del primer pixel a pintar.
    b .inferior

.end_zepe:
    // Restaurar registros

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

