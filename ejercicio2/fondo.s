.globl Fondo
.equ SCREEN_WIDTH, 640

Fondo:  
    sub sp, sp, #8
    stur lr, [sp]
    stp x0, x1, [sp, #-16]!
    stp x2, x3, [sp, #-16]!
    stp x4, x5, [sp, #-16]!

    ldr w3, =0xff944A58
    mov x4, #5

.repetir_fondo:
    mov x2, #54       // Y Size
.loop1:
    mov x1, SCREEN_WIDTH
.loop0:
    stur w3, [x0]
    add x0, x0, #4
    sub x1, x1, #1
    cbnz x1, .loop0
    sub x2, x2, #1
    cbnz x2, .loop1

    sub x4, x4, #1
    movz x5, 0x12, lsl #16
    add x3, x3, x5
    sub x3, x3, #0x060c
    cbnz x4, .repetir_fondo

    ldp x4, x5, [sp], #16
    ldp x2, x3, [sp], #16
    ldp x0, x1, [sp], #16
    ldur lr, [sp]
    add sp, sp, #8
    
    ret

