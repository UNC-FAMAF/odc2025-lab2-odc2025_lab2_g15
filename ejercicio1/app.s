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
	//---------------- CODE HERE ------------------------------------

	movz x10, 0x94, lsl 16
	movk x10, 0x4A58, lsl 00
	mov x12, 5

Fondo:
	mov x2, 54       // Y Size
loop1:
	mov x1, SCREEN_WIDTH         // X Size
loop0:
	stur w10,[x0]  // Colorear el pixel N
	add x0,x0,4	   // Siguiente pixel
	sub x1,x1,1	   // Decrementar contador X
	cbnz x1,loop0  // Si no terminó la fila, salto
	sub x2,x2,1	   // Decrementar contador Y
	cbnz x2,loop1  // Si no es la última fila, salto
	cbnz x12, cd12

cd12:

	sub x12, x12, 1
	movz x13, 0x12, lsl 16
	add x10,x10,x13
	sub x10,x10,0x060c
	cbnz x12, Fondo

	// edificio 1
	mov x0, 0        // x
	mov x1, 200        // y
	mov x2, 150        // ancho
	mov x3, 280        // alto
	movz x14, 0x78, lsl 16
	movk x14, 0x2828, lsl 00
	bl edificio

	// edificio 2
	mov x0, 150
	mov x1, 220
	mov x2, 100
	mov x3, 300
	movz x14, 0x68, lsl 16
	movk x14, 0x2828, lsl 00
	bl edificio

	// edificio 3
	mov x0, 250
	mov x1, 270
	mov x2, 210
	mov x3, 220
	movz x14, 0x58, lsl 16
	movk x14, 0x2828, lsl 00
	bl edificio

	//edificio 4
	mov x0, 460
	mov x1, 220
	mov x2, 70
	mov x3, 300
	movz x14, 0x48, lsl 16
	movk x14, 0x2828, lsl 00
	bl edificio

    //edificio 5
	mov x0, 530
	mov x1, 120
	mov x2, 110
	mov x3, 370
	movz x14, 0x38, lsl 16
	movk x14, 0x2828, lsl 00
	bl edificio
	
	// Ejemplo de uso de gpios
	mov x9, GPIO_BASE

	// Atención: se utilizan registros w porque la documentación de broadcom
	// indica que los registros que estamos leyendo y escribiendo son de 32 bits

	// Setea gpios 0 - 9 como lectura
	str wzr, [x9, GPIO_GPFSEL0]

	// Lee el estado de los GPIO 0 - 31
	ldr w10, [x9, GPIO_GPLEV0]

	// And bit a bit mantiene el resultado del bit 2 en w10
	and w11, w10, 0b10

	// w11 será 1 si había un 1 en la posición 2 de w10, si no será 0
	// efectivamente, su valor representará si GPIO 2 está activo
	lsr w11, w11, 1

	//---------------------------------------------------------------
	// Infinite Loop

InfLoop:
	b InfLoop
