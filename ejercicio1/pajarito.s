.globl pajarito

pajarito:
mov x10, 4          // alto
mov x11, 3         // ancho
mov x12, x1          // y inicial
mov x13, x0          // x inicial
mov x14, 0        // color (ya está cargado en app.s)
mov x18, 640         // el maximo de la pantalla
	
mov x9,2
mov x19,2

lineloopy:
mov x15, x11         // contador x
mov x16, x13         // x actual
mov x17, x12         // y actual

lineloopx:
mul x0, x17, x18     // offset = y * (maximo de pantalla)
add x0, x0, x16      // + x
lsl x0, x0, 2        // * 4 bytes por píxel
add x0, x20, x0      // dirección final
stur x14, [x0]       // pintar píxel

add x16, x16, 1
sub x15, x15, 1
cbnz x15, lineloopx

add x12, x12, 1
sub x10, x10, 1
cbnz x10, lineloopy

mov x17, x12
add x12, x12, 0   // espacion entre luces
mov x10, 10
sub x9, x9, 1
cbnz x9, lineloopy


pajarito1:
mov x10, 5          // alto
mov x11, 12         // ancho
sub x13,x13,3
sub x12,x12,5      // y inicial          
mov x14, 0        // color (ya está cargado en app.s)
mov x18, 640         // el maximo de la pantalla
	

lineloopy2:
mov x15, x11         // contador x
mov x16, x13         // x actual
mov x17, x12         // y actual

lineloopx2:
mul x0, x17, x18     // offset = y * (maximo de pantalla)
add x0, x0, x16      // + x
lsl x0, x0, 2        // * 4 bytes por píxel
add x0, x20, x0      // dirección final
stur x14, [x0]       // pintar píxel

add x16, x16, 1
sub x15, x15, 1
cbnz x15, lineloopx2

add x12, x12, 1
sub x10, x10, 1
cbnz x10, lineloopy2

ret
