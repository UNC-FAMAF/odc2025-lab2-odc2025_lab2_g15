.globl sol

sol:
    // Parámetros del círculo
    mov     x0, 340          // Centro X
    mov     x1, 270          // Centro Y
    mov     x2, 40           // Radio
	mov 	x16, 640
    
    movz    x14, 0xFF, lsl 16	// Color 
    movk    x14, 0xB906, lsl 0

    mov     x13, 0	// Inicializar Y = 0 (fila)

loop_y:
    cmp     x13, 480
    b.ge    end

    mov     x12, 0 // Inicializar X = 0 (columna)

loop_x:
    cmp     x12, 640
    b.ge    next_row

    // Calcular (dx = x - cx), (dy = y - cy)
    sub     x5, x12, x0      // dx = x - cx
    sub     x6, x13, x1      // dy = y - cy

    // Calcular dx*dx y dy*dy
    smull   x7, w5, w5       // dx²
    smull   x8, w6, w6       // dy²

    // Comparar con radio²
    add     x9, x7, x8       // dx² + dy²
    mul     x10, x2, x2      // radio²

    cmp     x9, x10
    b.gt    skip_pixel       // Si fuera del círculo, salta

    // Calcular dirección en framebuffer
    // addr = framebuffer + ((y * 640 + x) * 4)
    mul     x15, x13, x16   // y * 640
    add     x15, x15, x12    // + x
    lsl     x15, x15, 2      // * 4 (bytes por pixel)
    add     x15, x20, x15    // dirección absoluta

    
    str     w14, [x15]		// Escribir color

skip_pixel:
    add     x12, x12, 1
    b       loop_x

next_row:
    add     x13, x13, 1
    b       loop_y

end:
    ret
