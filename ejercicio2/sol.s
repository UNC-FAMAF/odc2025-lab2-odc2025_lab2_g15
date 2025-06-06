.globl sol

sol:
    sub sp, sp, #8
    stur lr, [sp]
    stp x0, x1, [sp, #-16]!
    stp x2, x3, [sp, #-16]!
    stp x4, x5, [sp, #-16]!
    stp x6, x7, [sp, #-16]!
    stp x8, x9, [sp, #-16]!
    stp x10, x11, [sp, #-16]!
    stp x12, x13, [sp, #-16]!
    // Parámetros del círculo
    mov x0, #300          // Centro X
    mov x1, #310          // Centro Y
    mov x2, #40           // Radio
	mov x3, #640

    // Desplazamiento
    add x0, x0, x25 // en x.
    sub x1, x1, x26 // en y.
    
    ldr x4, =0xFFB906

    mov x13, #0	// Inicializar Y = 0 (fila) x15

loop_y:
    cmp x13, #480   //Controlador del ancho de la figura.
    b.ge end        // Si x13 >= #480 entonces salta a la etiqueta end

    mov x12, #0 // Actualizamos el contador del alto de la figura.

loop_x:
    cmp x12, #640   //Controlamos que no nos excedemos el alto e la figura.
    b.ge next_row


    sub x5, x12, x0      
    sub x6, x13, x1      

    
    smull x7, w5, w5       
    smull x8, w6, w6       

    
    add x9, x7, x8      
    mul x10, x2, x2     

    cmp x9, x10
    b.gt skip_pixel       

    // Calcular dirección en framebuffer 

    mul x11, x13, x3  
    add x11, x11, x12    
    lsl x11, x11, 2      // bytes por pixel
    add x11, x20, x11   // dirección absoluta

    
    str w4, [x11]		// Escribir color


skip_pixel:
    add x12, x12, #1
    b loop_x

next_row:
    add x13, x13, #1
    b loop_y

end:

    ldp x12, x13, [sp], #16
    ldp x10, x11, [sp], #16
    ldp x8, x9, [sp], #16
    ldp x6, x7, [sp], #16
    ldp x4, x5, [sp], #16
    ldp x2, x3, [sp], #16
    ldp x0, x1, [sp], #16

    ldur lr, [sp]
    add sp, sp, #8
    ret
