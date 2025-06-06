	.equ SCREEN_WIDTH, 		640
	.equ SCREEN_HEIGH, 		480
	.equ BITS_PER_PIXEL,  	32

	.equ GPIO_BASE,      0x3f200000
	.equ GPIO_GPFSEL0,   0x00
	.equ GPIO_GPLEV0,    0x34

.globl main

main:
	// x0 contiene la direccion base del framebuffer
 	mov x20, x0	// Guarda la dirección base del framebuffer en x20
	//---------------- Fondo ------------------------------------

	bl Fondo
	bl sol
	//---------------- edificios ------------------------------------


	// edificio 1
	// caracteristicas del edificio
	mov x0, x20
	ldr w1, =0xff582828
	mov x2, #250
	mov x3, #269
	mov x4, #140
	mov x5, #280
	ldr w6, =0xffF0BE46
	mov x7, #6
	mov x8, #28
	ldr w9, =0xFF111111
	mov x10, #261
	mov x11, #12
	ldr w12, =0xFF4A8FB4
	bl edificio
	// edificio 2
	// caracteristicas del edificio
	mov x0, x20
	ldr w1, =0xFF682828
	mov x2, #124
	mov x3, #250
	mov x4, #132
	mov x5, #280
	ldr w6, =0xFFF0BE46
	mov x7, #6
	mov x8, #30
	ldr w9, =0xFF333333
	mov x10, #242
	mov x11, #13
	ldr w12, =0xFF93C2DB
	bl edificio
	// edificio 3
	// caracteristicas del edificio
	mov x0, x20
	ldr w1, =0xFF682828
	mov x2, #384
	mov x3, #200
	mov x4, #132
	mov x5, #280
	ldr w6, =0xFFF0BE46
	mov x7, #7
	mov x8, #34
	ldr w9, =0xFF333333
	mov x10, #192
	mov x11, #13
	ldr w12, =0xFF93C2DB
	bl edificio
	// edificio 4
	// caracteristicas del edificio
	mov x0, x20
	ldr w1, =0xFF782828
	mov x2, #0
	mov x3, #200
	mov x4, #128
	mov x5, #280
	ldr w6, =0xffF0BE46
	mov x7, #7
	mov x8, #34
	ldr w9, =0xFF444444
	mov x10, #192
	mov x11, #14
	ldr w12, =0xFFD0E6F5
	bl edificio
	// edificio 5
	// caracteristicas del edificio
	mov x0, x20
	ldr w1, =0xFF782828
	mov x2, #512
	mov x3, #188
	mov x4, #128
	mov x5, #290
	ldr w6, =0xFFF0BE46
	mov x7, #8
	mov x8, #32
	ldr w9, =0xFF444444
	mov x10, #180
	mov x11, #14
	ldr w12, =0xFFD0E6F5
	bl edificio	
	// zepelin 1
	// caracteristicas del zepelin con la letra O
	mov x0, x20
	ldr w1, =0xFFA8E6A3
	ldr w6, =0xFF444444
	mov x2, #50
	mov x3, #50
	mov x4, #30
	mov x5, #20
	bl zepe
	mov x0, x20
	ldr w1, =0xFFD0E6F5
	ldr w6, =0xff582828
	mov x2, #50
	mov x3, #50
	mov x4, #30
	mov x5, #20
	bl letra_o
	// zepelin 2
	// caracteristicas del zepelin
	mov x0, x20
	ldr w1, =0xFFA8E6A3
	ldr w6, =0xFF444444
	mov x2, #85
	mov x3, #50
	mov x4, #30
	mov x5, #20
	bl zepe
	ldr w1, =0xFFD0E6F5
	ldr w6, =0xff582828
	mov x2, #85
	mov x3, #50
	mov x4, #30
	mov x5, #20
	bl letra_d
	// zepelin 3
	// caracteristicas del zepelin
	mov x0, x20
	ldr w1, =0xFFA8E6A3
	ldr w6, =0xFF444444
	mov x2, #120
	mov x3, #50
	mov x4, #30
	mov x5, #20
	bl zepe
	ldr w1, =0xFFD0E6F5
	ldr w6, =0xff582828
	mov x2, #120
	mov x3, #50
	mov x4, #30
	mov x5, #20
	bl letra_c
	// zepelin 4
	// caracteristicas del zepelin
	mov x0, x20
	ldr w1, =0xFF7EDC84
	ldr w6, =0xFF444444
	mov x2, #32
	mov x3, #75
	mov x4, #30
	mov x5, #20
	bl zepe
	ldr w1, =0xFFD0E6F5
	ldr w6, =0xff582828
	mov x2, #32
	mov x3, #75
	mov x4, #30
	mov x5, #20
	bl numero_2
	// zepelin 5
	// caracteristicas del zepelin
	mov x0, x20
	ldr w1, =0xFF7EDC84
	ldr w6, =0xFF444444
	mov x2, #67
	mov x3, #75
	mov x4, #30
	mov x5, #20
	bl zepe
	ldr w1, =0xFFD0E6F5
	ldr w6, =0xff582828
	mov x2, #67
	mov x3, #75
	mov x4, #30
	mov x5, #20
	bl letra_o
	// zepelin 6
	// caracteristicas del zepelin
	mov x0, x20
	ldr w1, =0xFF7EDC84
	ldr w6, =0xFF444444
	mov x2, #102
	mov x3, #75
	mov x4, #30
	mov x5, #20
	bl zepe
	ldr w1, =0xFFD0E6F5
	ldr w6, =0xff582828
	mov x2, #102
	mov x3, #75
	mov x4, #30
	mov x5, #20
	bl numero_2
	// zepelin 7
	// caracteristicas del zepelin
	mov x0, x20
	ldr w1, =0xFF7EDC84
	ldr w6, =0xFF444444
	mov x2, #137
	mov x3, #75
	mov x4, #30
	mov x5, #20
	bl zepe
	ldr w1, =0xFFD0E6F5
	ldr w6, =0xff582828
	mov x2, #137
	mov x3, #75
	mov x4, #30
	mov x5, #20
	bl numero_5

	//---------------------------------------------------------------
	// Infinite Loop
	mov x25, #0
InfLoop:
	
	bl Fondo
	bl sol
	//---------------- edificios ------------------------------------


	// edificio 1
	// caracteristicas del edificio
	mov x0, x20
	ldr w1, =0xff582828
	mov x2, #250
	mov x3, #269
	mov x4, #140
	mov x5, #280
	ldr w6, =0xffF0BE46
	mov x7, #6
	mov x8, #28
	ldr w9, =0xFF111111
	mov x10, #261
	mov x11, #12
	ldr w12, =0xFF4A8FB4
	bl edificio
	// edificio 2
	// caracteristicas del edificio
	mov x0, x20
	ldr w1, =0xFF682828
	mov x2, #124
	mov x3, #250
	mov x4, #132
	mov x5, #280
	ldr w6, =0xFFF0BE46
	mov x7, #6
	mov x8, #30
	ldr w9, =0xFF333333
	mov x10, #242
	mov x11, #13
	ldr w12, =0xFF93C2DB
	bl edificio
	// edificio 3
	// caracteristicas del edificio
	mov x0, x20
	ldr w1, =0xFF682828
	mov x2, #384
	mov x3, #200
	mov x4, #132
	mov x5, #280
	ldr w6, =0xFFF0BE46
	mov x7, #7
	mov x8, #34
	ldr w9, =0xFF333333
	mov x10, #192
	mov x11, #13
	ldr w12, =0xFF93C2DB
	bl edificio
	// edificio 4
	// caracteristicas del edificio
	mov x0, x20
	ldr w1, =0xFF782828
	mov x2, #0
	mov x3, #200
	mov x4, #128
	mov x5, #280
	ldr w6, =0xffF0BE46
	mov x7, #7
	mov x8, #34
	ldr w9, =0xFF444444
	mov x10, #192
	mov x11, #14
	ldr w12, =0xFFD0E6F5
	bl edificio
	// edificio 5
	// caracteristicas del edificio
	mov x0, x20
	ldr w1, =0xFF782828
	mov x2, #512
	mov x3, #188
	mov x4, #128
	mov x5, #290
	ldr w6, =0xFFF0BE46
	mov x7, #8
	mov x8, #32
	ldr w9, =0xFF444444
	mov x10, #180
	mov x11, #14
	ldr w12, =0xFFD0E6F5
	bl edificio	
	// zepelin 1
	// caracteristicas del zepelin con la letra O
	mov x0, x20
	ldr w1, =0xFFA8E6A3
	ldr w6, =0xFF444444
	mov x2, #50
	add x2, x2, x25
	mov x3, #50
	mov x4, #30
	mov x5, #20
	bl zepe
	mov x0, x20
	ldr w1, =0xFFD0E6F5
	ldr w6, =0xff582828
	mov x2, #50
	add x2, x2, x25
	mov x3, #50
	mov x4, #30
	mov x5, #20
	bl letra_o
	// zepelin 2
	// caracteristicas del zepelin
	mov x0, x20
	ldr w1, =0xFFA8E6A3
	ldr w6, =0xFF444444
	mov x2, #85
	add x2, x2, x25
	mov x3, #50
	mov x4, #30
	mov x5, #20
	bl zepe
	ldr w1, =0xFFD0E6F5
	ldr w6, =0xff582828
	mov x2, #85
	add x2, x2, x25
	mov x3, #50
	mov x4, #30
	mov x5, #20
	bl letra_d
	// zepelin 3
	// caracteristicas del zepelin
	mov x0, x20
	ldr w1, =0xFFA8E6A3
	ldr w6, =0xFF444444
	mov x2, #120
	add x2, x2, x25
	mov x3, #50
	mov x4, #30
	mov x5, #20
	bl zepe
	ldr w1, =0xFFD0E6F5
	ldr w6, =0xff582828
	mov x2, #120
	add x2, x2, x25
	mov x3, #50
	mov x4, #30
	mov x5, #20
	bl letra_c
	// zepelin 4
	// caracteristicas del zepelin
	mov x0, x20
	ldr w1, =0xFF7EDC84
	ldr w6, =0xFF444444
	mov x2, #32
	add x2, x2, x25
	mov x3, #75
	mov x4, #30
	mov x5, #20
	bl zepe
	ldr w1, =0xFFD0E6F5
	ldr w6, =0xff582828
	mov x2, #32
	add x2, x2, x25
	mov x3, #75
	mov x4, #30
	mov x5, #20
	bl numero_2
	// zepelin 5
	// caracteristicas del zepelin
	mov x0, x20
	ldr w1, =0xFF7EDC84
	ldr w6, =0xFF444444
	mov x2, #67
	add x2, x2, x25
	mov x3, #75
	mov x4, #30
	mov x5, #20
	bl zepe
	ldr w1, =0xFFD0E6F5
	ldr w6, =0xff582828
	mov x2, #67
	add x2, x2, x25
	mov x3, #75
	mov x4, #30
	mov x5, #20
	bl letra_o
	// zepelin 6
	// caracteristicas del zepelin
	mov x0, x20
	ldr w1, =0xFF7EDC84
	ldr w6, =0xFF444444
	mov x2, #102
	add x2, x2, x25
	mov x3, #75
	mov x4, #30
	mov x5, #20
	bl zepe
	ldr w1, =0xFFD0E6F5
	ldr w6, =0xff582828
	mov x2, #102
	add x2, x2, x25
	mov x3, #75
	mov x4, #30
	mov x5, #20
	bl numero_2
	// zepelin 7
	// caracteristicas del zepelin
	mov x0, x20
	ldr w1, =0xFF7EDC84
	ldr w6, =0xFF444444
	mov x2, #137
	add x2, x2, x25
	mov x3, #75
	mov x4, #30
	mov x5, #20
	bl zepe
	ldr w1, =0xFFD0E6F5
	ldr w6, =0xff582828
	mov x2, #137
	add x2, x2, x25
	mov x3, #75
	mov x4, #30
	mov x5, #20
	bl numero_5
	mov x0, #5
	bl delay
	mov x0, x20

	add x25, x25, #1

	b InfLoop

