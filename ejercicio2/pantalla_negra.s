.globl pantalla_negra
pantalla_negra:
    sub sp, sp, #8
    stur lr, [sp]
    stp x3, x4, [sp, #-16]!
    // x0: framebuffer
    ldr w1, =0xFF000000     // color negro
    mov x2, #0              // contador
    mov x3, #640
    mov x4, #480
    mul x3, x3, x4

.loop_clear:
    str w1, [x0], #4
    add x2, x2, #1
    cmp x2, x3
    bne .loop_clear

    ldp x3, x4, [sp], #16
    ldur lr, [sp]
    add sp, sp, 38

    ret
