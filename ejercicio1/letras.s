.globl letras

    letras:
	mov x10, x3          // alto
	mov x11, x2          // ancho
	mov x12, x1          // y inicial
	mov x13, x0          // x inicial
	mov x14, x14         // color (ya está cargado en app.s)
	mov x18, 640         // el maximo de la pantalla

	mov x9,x4
	

letraloopy:
	mov x15, x11         // contador x
	mov x16, x13         // x actual
	mov x17, x12         // y actual

letraloopx:
	mul x0, x17, x18     // offset = y * (maximo de pantalla)
	add x0, x0, x16      // + x
	lsl x0, x0, 2        // * 4 bytes por píxel
	add x0, x20, x0      // dirección final
	stur x14, [x0]       // pintar píxel

	add x16, x16, 1
	sub x15, x15, 1
	cbnz x15, letraloopx

	add x12, x12, 1
	sub x10, x10, 1
	cbnz x10, letraloopy

	mov x17, x12
	add x12, x12, 45   // espacion entre luces
	mov x10, x3
	sub x9, x9, 1
	cbnz x9, letraloopy

	ret
