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

	movz x10, 0x94, lsl 16
	movk x10, 0x4A58, lsl 00
	
	
	mov x12, 1
	mov x13, 1
	mov x14, 1
	mov x15, 1
	
	B fondo


cd12:

	sub x12, x12, 1
	
	movz x10, 0xEE, lsl 16
	movk x10, 0x2E26, lsl 00


fondo:
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
	// Ejemplo de uso de gpios
	mov x9, GPIO_BASE
	
	cbnz x13, cd13
	cbnz x14, cd14
	cbnz x15, cd15
	cbnz x12, cd12


cd13:

	cd13:
	sub x13, x13, 1
	
	movz x10, 0x9C, lsl 16
	movk x10, 0x444C, lsl 00
	B fondo
	
cd14:

	cd14:
	sub x14, x14, 1
	
	movz x10, 0xCA, lsl 16
	movk x10, 0x3834, lsl 00
	B fondo
	
cd15:

	cd15:
	sub x15, x15, 1
	
	movz x10, 0xDC, lsl 16
	movk x10, 0x3228, lsl 00
	B fondo
	

	//---------------- edificios ------------------------------------

	

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
