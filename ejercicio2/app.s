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
	mov x25, #0
	mov x26, #0
	ldr x27, =SCREEN_HEIGH 
	mov x28, #0
	mov x29, #0

	
	mov x0, x20
	bl Fondo
	mov x0, x20
	bl sol
	mov x0, x20
	bl dibujar

	//---------------------------------------------------------------
	// Infinite Loop
	
InfLoop:

	add x29, x29, #2
	add x28, x28, #1
	cmp x27, x25
	b.eq .reset_xy
	add x25, x25, #1
	add x26, x26, #1

	mov x0, x20
	bl Fondo
	mov x0, x20
	bl sol
	mov x0, x20
	bl dibujar
	mov x0, x20

	b InfLoop
.reset_xy:
	mov x25, #0
	mov x26, #0
	b InfLoop
