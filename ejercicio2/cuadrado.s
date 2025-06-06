// x0: framebuffer
// w1: color
// x2: x
// x3: y
// x4: width
// x5: height
.equ SCREEN_WIDTH, 		640

cuadrado:
  // Guardar registros usados
  sub sp, sp, #8
  stur lr, [sp]
  stp x6, x7, [sp, #-16]!
	stp x8, x9, [sp, #-16]!
	stp x10, x11, [sp, #-16]!
	stp x12, x13, [sp, #-16]!

  mov x6, x3
  ldr x8, =SCREEN_WIDTH
  mul x6, x6, x8
  add x6, x6, x2
  lsl x6, x6, #2              // convertir a offset en bytes.
  add x6, x0, x6              // x6 = dirección inicial del primer píxel.

  mov x9, x5                  // contador de filas.
.dsrow_loop:
  mov x10, x4                 // contador de pixeles a pintar sobre la fila.
  mov x11, x6                 // dirección base de la fila actual.
.dscol_loop:
  str w1, [x11], #4           // pintamos el píxel y avanzamos al siguiente.
  subs x10, x10, #1           // como ya pintamos un pixel, descontamos la cantidad a pintar.
  bne .dscol_loop

  ldr x12, =SCREEN_WIDTH
  lsl x12, x12, #2            // ancho en bytes de una fila.
  add x6, x6, x12             // avanzar a siguiente fila.
  subs x9, x9, #1             // como ya pintamos un fila, decrementamos en 1 la cantidad a pintar.
  bne .dsrow_loop

  // Restaurar registros
	ldp x12, x13, [sp], #16
	ldp x10, x11, [sp], #16
	ldp x8, x9, [sp], #16
	ldp x6, x7, [sp], #16
  ldur lr, [sp]
  add sp, sp, #8
  ret
  
