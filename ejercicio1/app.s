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


	bl sol

	//---------------- edificios ------------------------------------
	// edificio 1
	
	mov x0, 0        // x
	mov x1, 200        // y
	mov x2, 150        // ancho
	mov x3, 280        // alto
	movz x14, 0x78, lsl 16
	movk x14, 0x2828, lsl 00
	bl edificio
	mov x0, 0        	// x
	mov x1, 250        // y
	movz w14, 0xF0 , lsl 16		
	movk w14, 0xBE46, lsl 00	// color de las luces  		
	mov x4,4					// cantidad de lineas (luces)
	bl lineas

	// edificio 2
	mov x0, 150
	mov x1, 220
	mov x2, 100
	mov x3, 300
	movz x14, 0x68, lsl 16
	movk x14, 0x2828, lsl 00
	bl edificio
	mov x0, 150      	// x
	mov x1, 270     // y
	movz w14, 0xF0 , lsl 16		
	movk w14, 0xBE46, lsl 00	// color de las luces  		
	mov x4,3					// cantidad de lineas (luces)
	bl lineas

	// edificio 3
	mov x0, 250
	mov x1, 270
	mov x2, 210
	mov x3, 220
	movz x14, 0x58, lsl 16
	movk x14, 0x2828, lsl 00
	bl edificio
	mov x0, 250       	// x
	mov x1, 310      // y
	movz w14, 0xF0 , lsl 16		
	movk w14, 0xBE46, lsl 00	// color de las luces  		
	mov x4,3					// cantidad de lineas (luces)
	bl lineas

	//edificio 4
	mov x0, 460
	mov x1, 220
	mov x2, 70
	mov x3, 300
	movz x14, 0x48, lsl 16
	movk x14, 0x2828, lsl 00
	bl edificio
	mov x0, 460       	// x
	mov x1, 270    // y
	movz w14, 0xF0 , lsl 16		
	movk w14, 0xBE46, lsl 00	// color de las luces  		
	mov x4,3				// cantidad de lineas (luces)
	bl lineas

    //edificio 5
	mov x0, 530
	mov x1, 120
	mov x2, 110
	mov x3, 370
	movz x14, 0x38, lsl 16
	movk x14, 0x2828, lsl 00
	bl edificio

	//---------------- letras ------------------------------------
 
	//Letras
	mov x3, 50 // altura de las letras
	mov x0, 550       	// x
	mov x1, 130    // y
	mov x2, 30
	movz w14, 0xFf , lsl 16		
	movk w14, 0x00ff, lsl 00 		
	mov x4,3				
	
	bl letras
	mov x0, 600       	// x
	mov x1, 130    // y
	mov x2, 30
	 		
	mov x4,4				
	bl letras
	// COCO TFT2

	mov x0, 600       	// x
	mov x1, 130    // y
	mov x2, 30
	 		
	mov x4,1				

	//O
	bl letras
	mov x0, 557       	// x
	mov x1, 137    // y
	mov x2, 16
	mov x3, 34
	movz w14, 0x38 , lsl 16		
	movk w14, 0x2828, lsl 00	  		
	mov x4,1				

	//D
	bl letras
	mov x0, 562       	// x
	mov x1, 230    // y
	mov x2, 16
	mov x3, 40
			
	mov x4,1
	bl letras

	//C
	mov x0, 557       	// x
	mov x1, 330    // y
	mov x2, 42
	mov x3, 30
			
	mov x4,1
	bl letras

	// 2
	mov x0, 590       	// x
	mov x1, 135    // y
	mov x2, 30
	mov x3, 15
	 		
	mov x4,1
	bl letras
	//2.1
	mov x0, 610       	// x
	mov x1, 160    // y
	mov x2, 30
	mov x3, 15
			
	mov x4,1
	bl letras

	// 0
	mov x0, 607       	// x
	mov x1, 230    // y
	mov x2, 16
	mov x3, 40
	 		
	mov x4,1
	bl letras

	// 2.2
	mov x0, 590       	// x
	mov x1, 330    // y
	mov x2, 30
	mov x3, 15
			
	mov x4,1
	bl letras
	//2.3
	mov x0, 610       	// x
	mov x1, 350    // y
	mov x2, 30
	mov x3, 15
			
	mov x4,1
	bl letras

	//5
	mov x0, 610       	// x
	mov x1, 420    // y
	mov x2, 30
	mov x3, 15
	  		
	mov x4,1
	bl letras
	//5.1
	mov x0, 590       	// x
	mov x1, 440    // y
	mov x2, 30
	mov x3, 15

	mov x4,1
	bl letras

	mov x1, 36
	mov x0, 50
	bl pajarito

	mov x1 , 50
    mov x0, 68
	bl pajarito
	
	mov x1 , 64
	mov x0, 50
	bl pajarito
	

InfLoop:
	b InfLoop
