.ifndef delay_guard
#define delay_guard

.globl delay
delay:
    sub sp, sp, #8
    stur lr, [sp]

    stp x0, x1, [sp, #-16]!
    stp x2, x3, [sp, #-16]!

    mov x1, #10000
    mul x1, x0, x1
    lsl x1, x1, #10
    lsr x1, x1, #2

    mov x2, #0
.delay_loop:
    add x2, x2, #1
    cmp x2, x1
    b.lo .delay_loop

    ldp x2, x3, [sp], #16
    ldp x0, x1, [sp], #16

    ldur lr, [sp]
    add sp, sp, #8

    ret

.endif



