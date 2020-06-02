/*
  AngelCode Scripting Library
  Copyright (c) 2003-2012 Andreas Jonsson

  This software is provided 'as-is', without any express or implied
  warranty. In no event will the authors be held liable for any
  damages arising from the use of this software.

  Permission is granted to anyone to use this software for any
  purpose, including commercial applications, and to alter it and
  redistribute it freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you
     must not claim that you wrote the original software. If you use
     this software in a product, an acknowledgment in the product
     documentation would be appreciated but is not required.

  2. Altered source versions must be plainly marked as such, and
     must not be misrepresented as being the original software.

  3. This notice may not be removed or altered from any source
     distribution.

  The original version of this library can be located at:
  http://www.angelcode.com/angelscript/

  Andreas Jonsson
  andreas@angelcode.com
*/

/*
   Assembly routines for the ARM call convention
   Written by Fredrik Ehnbom in June 2009

   Adapted to GNUC by darktemplar216 in September 2009

   Modified by Lasse Oorni for 8-byte stack alignment in May 2012
*/

#if defined(__aarch64__)

.global armFunc
.global armFuncR0
.global armFuncR0R1
.global armFuncObjLast
.global armFuncR0ObjLast

armFunc:                                // @armFunc
	sub sp, sp, #48
	stp x29, x30, [sp, #32]
	add x29, sp, #32

	stur x0, [x29, #-8]  // arg1
	str  x1, [sp, #16]   // arg2
	str  x2, [sp, #8]    // arg3

	// #start

	ldur x11, [x29, #-8] // load vector

	ldr x12, [sp, #16]

	cmp x12, #0*4
	ble .L_armFunc_FINISH0_1
	ldr x0, [x11]
	cmp x12, #1*4
	ble .L_armFunc_FINISH0_1
	ldr x1, [x11, #8]
	cmp x12, #2*4
	ble .L_armFunc_FINISH0_1
	ldr x2, [x11, #16]
	cmp x12, #3*4
	ble .L_armFunc_FINISH0_1
	ldr x3, [x11, #24]
	cmp x12, #4*4
	ble .L_armFunc_FINISH0_1
	ldr x4, [x11, #32]
	cmp x12, #5*4
	ble .L_armFunc_FINISH0_1
	ldr x5, [x11, #40]
	cmp x12, #6*4
	ble .L_armFunc_FINISH0_1
	ldr x6, [x11, #48]
	cmp x12, #7*4
	ble .L_armFunc_FINISH0_1
	ldr x7, [x11, #56]

.L_armFunc_FINISH0_1:
	ldr x10, [sp, #8]
	blr x10

	// #end

	ldp x29, x30, [sp, #32]
	add sp, sp, #48

	ret

armFuncR0:                                // @armFunc
	sub sp, sp, #48
	stp x29, x30, [sp, #32]
	add x29, sp, #32
	stur x0, [x29, #-8]
	str x1, [sp, #16]
	str x2, [sp, #8]

	ldr x10, [sp, #8]
	ldur x11, [x29, #-8] // load vector

	ldr x0, [x11]
	ldr x1, [x11, #8]
	ldr x2, [x11, #16]
	ldr x3, [x11, #24]
	ldr x4, [x11, #32]
	ldr x5, [x11, #40]
	ldr x6, [x11, #48]
	ldr x7, [x11, #56]

	blr x10

	ldp x29, x30, [sp, #32]
	add sp, sp, #48
	ret

armFuncR0R1:                                // @armFunc
	sub sp, sp, #48
	stp x29, x30, [sp, #32]
	add x29, sp, #32
	stur x0, [x29, #-8]
	str x1, [sp, #16]
	str x2, [sp, #8]

	ldr x10, [sp, #8]
	ldur x11, [x29, #-8] // load vector

	ldr x0, [x11]
	ldr x1, [x11, #8]
	ldr x2, [x11, #16]
	ldr x3, [x11, #24]
	ldr x4, [x11, #32]
	ldr x5, [x11, #40]
	ldr x6, [x11, #48]
	ldr x7, [x11, #56]

	blr x10

	ldp x29, x30, [sp, #32]
	add sp, sp, #48
	ret

armFuncObjLast:                                // @armFunc
	sub sp, sp, #48
	stp x29, x30, [sp, #32]
	add x29, sp, #32
	stur x0, [x29, #-8]
	str x1, [sp, #16]
	str x2, [sp, #8]
	str x3, [sp]

	ldr x10, [sp, #8]
	ldur x11, [x29, #-8] // load vector

	ldr x12, [sp, #16]
	//ldr x10, [sp]

	ldr x0, [sp]
	cmp x12, #1*4
	ble .L_FINISH0_1
	ldr x0, [x11, #0*8]
	ldr x1, [sp]
	cmp x12, #2*4
	ble .L_FINISH0_1
	ldr x1, [x11, #1*8]
	ldr x2, [sp]
	cmp x12, #3*4
	ble .L_FINISH0_1
	ldr x2, [x11, #2*8]
	ldr x3, [sp]
	cmp x12, #4*4
	ble .L_FINISH0_1
	ldr x3, [x11, #3*8]
	ldr x4, [sp]
	cmp x12, #5*4
	ble .L_FINISH0_1
	ldr x4, [x11, #4*8]
	ldr x5, [sp]
	cmp x12, #6*4
	ble .L_FINISH0_1
	ldr x5, [x11, #5*8]
	ldr x6, [sp]
	cmp x12, #7*4
	ble .L_FINISH0_1
	ldr x6, [x11, #6*8]
	ldr x7, [sp]
	cmp x12, #8*4
	ble .L_FINISH0_1
	ldr x7, [x11, #7*8]
	ldr x8, [sp]
	cmp x12, #9*4
	ble .L_FINISH0_1
	ldr x8, [x11, #8*8]

	ldr x9, [sp]

.L_FINISH0_1:

	blr x10

	ldp x29, x30, [sp, #32]
	add sp, sp, #48
	ret

armFuncR0ObjLast:                                // @armFunc
	sub sp, sp, #48
	stp x29, x30, [sp, #32]
	add x29, sp, #32
	stur x0, [x29, #-8]
	str x1, [sp, #16]
	str x2, [sp, #8]

	ldr x10, [sp, #8]
	ldur x11, [x29, #-8] // load vector

	ldr x0, [x11]
	ldr x1, [x11, #8]
	ldr x2, [x11, #16]
	ldr x3, [x11, #24]
	ldr x4, [x11, #32]
	ldr x5, [x11, #40]
	ldr x6, [x11, #48]
	ldr x7, [x11, #56]

	blr x10

	ldp x29, x30, [sp, #32]
	add sp, sp, #48
	ret
    
//armFunc:
//    stmdb   sp!, {r4-r8, lr}
//    mov     r6, r0  /* arg table */
//    movs    r7, r1  /* arg size (also set the condition code flags so that we detect if there are no arguments) */
//    mov     r4, r2  /* function address */
//    mov     r8, #0
//
//    beq     nomoreargs
//
//    /* Load the first 4 arguments into r0-r3 */
//    cmp     r7, #4
//    ldrge   r0, [r6],#4
//    cmp     r7, #2*4
//    ldrge   r1, [r6],#4
//    cmp     r7, #3*4
//    ldrge   r2, [r6],#4
//    cmp     r7, #4*4
//    ldrge   r3, [r6],#4
//    ble     nomoreargs
//
//    /* Load the rest of the arguments onto the stack */
//    sub     r7, r7, #4*4      /* skip the 4 registers already loaded into r0-r3 */
//    add     r8, r7, #4        /* ensure 8-byte stack alignment */
//    bic     r8, r8, #4
//    sub     sp, sp, r8
//    mov     r12, sp           /* copy size != frame size, so store frame start sp */
//stackargsloop:
//    ldr     r5, [r6], #4
//    str     r5, [sp], #4
//    subs    r7, r7, #4
//    bne     stackargsloop
//    mov     sp, r12
//nomoreargs:
//    blx     r4
//    add     sp, sp, r8
//    ldmia   sp!, {r4-r8, pc}

//armFuncObjLast:
//    stmdb   sp!, {r4-r8, lr}
//    mov     r6, r0  /* arg table */
//    movs    r7, r1  /* arg size (also set the condition code flags so that we detect if there are no arguments) */
//    mov     r4, r2  /* function address */
//    mov     r8, #0
//
//    mov     r0, r3          /* objlast. might get overwritten */
//    mov     r5, r3          /* objlast to temp reg */
//
//    beq     nomoreargsarmFuncObjLast
//
//    /* Load the first 4 arguments into r0-r3 */
//    cmp     r7, #4
//    ldrge   r0, [r6],#4
//    cmp     r7, #2*4
//    ldrge   r1, [r6],#4
//    movlt   r1, r5
//    cmp     r7, #3*4
//    ldrge   r2, [r6],#4
//    movlt   r2, r5
//    cmp     r7, #4*4
//    ldrge   r3, [r6],#4
//    movlt   r3, r5
//    blt     nomoreargsarmFuncObjLast
//
//    /* Load the rest of the arguments onto the stack */
//    sub     r7, r7, #4*4    /* skip the 4 registers already loaded into r0-r3 */
//    add     r8, r7, #8      /* account for the objlast pointer, ensure 8-byte stack alignment */
//    bic     r8, r8, #4
//    str     r5, [sp,#-4]    /* store the objlast on stack, twice in case we adjusted alignment */
//    str     r5, [sp,#-8]
//    sub     sp, sp, r8      /* adjust frame */
//    cmp     r7, #0          /* we may also have come here with no extra params */
//    beq     nomoreargsarmFuncObjLast
//    mov     r12, sp         /* copy size != frame size, so store frame start sp */
//stackargslooparmFuncObjLast:
//    ldr     r5, [r6], #4
//    str     r5, [sp], #4
//    subs    r7, r7, #4
//    bne     stackargslooparmFuncObjLast
//    mov     sp, r12
//nomoreargsarmFuncObjLast:
//    blx     r4
//    add     sp, sp, r8
//    ldmia   sp!, {r4-r8, pc}
//
//armFuncR0ObjLast:
//    stmdb   sp!, {r4-r8, lr}
//    ldr     r5, [sp,#6*4]   /* objlast to temp reg */
//
//    mov     r6, r0  /* arg table */
//    movs    r7, r1  /* arg size (also set the condition code flags so that we detect if there are no arguments) */
//    mov     r4, r2  /* function address */
//    mov     r8, #0
//
//    mov     r0, r3      /* r0 explicitly set */
//    mov     r1, r5      /* objlast.  might get overwritten */
//
//    beq     nomoreargsarmFuncR0ObjLast
//
//    /* Load the first 3 arguments into r1-r3 */
//    cmp     r7, #1*4
//    ldrge   r1, [r6],#4
//    cmp     r7, #2*4
//    ldrge   r2, [r6],#4
//    movlt   r2, r5
//    cmp     r7, #3*4
//    ldrge   r3, [r6],#4
//    movlt   r3, r5
//    blt     nomoreargsarmFuncR0ObjLast
//
//    /* Load the rest of the arguments onto the stack */
//    sub     r7, r7, #3*4    /* skip the 3 registers already loaded into r1-r3 */
//    add     r8, r7, #8      /* account for the objlast pointer, ensure 8-byte stack alignment */
//    bic     r8, r8, #4
//    str     r5, [sp,#-4]    /* store the objlast on stack, twice in case we adjusted alignment */
//    str     r5, [sp,#-8]
//    sub     sp, sp, r8      /* adjust frame */
//    cmp     r7, #0          /* we may also have come here with no extra params */
//    beq     nomoreargsarmFuncR0ObjLast
//    mov     r12, sp         /* copy size != frame size, so store frame start sp */
//stackargslooparmFuncR0ObjLast:
//    ldr     r5, [r6], #4
//    str     r5, [sp], #4
//    subs    r7, r7, #4
//    bne     stackargslooparmFuncR0ObjLast
//    mov     sp, r12
//nomoreargsarmFuncR0ObjLast:
//    blx     r4
//    add     sp, sp, r8
//    ldmia   sp!, {r4-r8, pc}
//
//
//armFuncR0:
//    stmdb   sp!, {r4-r8, lr}
//    mov     r6, r0  /* arg table */
//    movs    r7, r1  /* arg size (also set the condition code flags so that we detect if there are no arguments) */
//    mov     r4, r2  /* function address */
//    mov     r8, #0
//
//    mov     r0, r3  /* r0 explicitly set */
//
//    beq     nomoreargsarmFuncR0
//
//    /* Load the first 3 arguments into r1-r3 */
//    cmp     r7, #1*4
//    ldrge   r1, [r6],#4
//    cmp     r7, #2*4
//    ldrge   r2, [r6],#4
//    cmp     r7, #3*4
//    ldrge   r3, [r6],#4
//    ble     nomoreargsarmFuncR0
//
//    /* Load the rest of the arguments onto the stack */
//    sub     r7, r7, #3*4    /* skip the 3 registers already loaded into r1-r3 */
//    add     r8, r7, #4      /* ensure 8-byte stack alignment */
//    bic     r8, r8, #4
//    sub     sp, sp, r8
//    mov     r12, sp         /* copy size != frame size, so store frame start sp */
//stackargslooparmFuncR0:
//    ldr     r5, [r6], #4
//    str     r5, [sp], #4
//    subs    r7, r7, #4
//    bne     stackargslooparmFuncR0
//    mov     sp, r12
//nomoreargsarmFuncR0:
//    blx     r4
//    add     sp, sp, r8
//    ldmia   sp!, {r4-r8, pc}
//
//
//armFuncR0R1:
//    stmdb   sp!, {r4-r8, lr}
//    mov     r6, r0  /* arg table */
//    movs    r7, r1  /* arg size (also set the condition code flags so that we detect if there are no arguments) */
//    mov     r4, r2  /* function address */
//    mov     r8, #0
//
//    mov     r0, r3          /* r0 explicitly set */
//    ldr     r1, [sp, #6*4]  /* r1 explicitly set too */
//
//    beq     nomoreargsarmFuncR0R1
//
//    /* Load the first 2 arguments into r2-r3 */
//    cmp     r7, #1*4
//    ldrge   r2, [r6],#4
//    cmp     r7, #2*4
//    ldrge   r3, [r6],#4
//    ble     nomoreargsarmFuncR0R1
//
//    /* Load the rest of the arguments onto the stack */
//    sub     r7, r7, #2*4    /* skip the 2 registers already loaded into r2-r3 */
//    add     r8, r7, #4      /* ensure 8-byte stack alignment */
//    bic     r8, r8, #4
//    sub     sp, sp, r8
//    mov     r12, sp         /* copy size != frame size, so store frame start sp */
//stackargslooparmFuncR0R1:
//    ldr     r5, [r6], #4
//    str     r5, [sp], #4
//    subs    r7, r7, #4
//    bne     stackargslooparmFuncR0R1
//    mov     sp, r12
//nomoreargsarmFuncR0R1:
//    blx     r4
//    add     sp, sp, r8
//    ldmia   sp!, {r4-r8, pc}

#endif
