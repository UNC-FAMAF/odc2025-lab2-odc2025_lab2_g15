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
	
	mov x0, x20
	bl Fondo
	mov x0, x20
	bl sol
	mov x0, x20
	bl dibujar

	//---------------------------------------------------------------
	// Infinite Loop
	
InfLoop:
	add x25, x25, #1

	mov x0, x20
	bl Fondo
	mov x0, x20
	bl sol
	mov x0, x20
	bl dibujar
	mov x0, x20
	

	b InfLoop

