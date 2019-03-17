	.text
	.file	"test10.c"
	.globl	victim_function_v10     # -- Begin function victim_function_v10
	.p2align	4, 0x90
	.type	victim_function_v10,@function
victim_function_v10:                    # @victim_function_v10
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movl	%esi, -4(%rbp)
	movq	-16(%rbp), %rax
	movq	array1_size, %rcx
	lfence
	cmpq	%rcx, %rax
	jae	.LBB0_4
# %bb.1:                                # %if.then
	movq	-16(%rbp), %rax
	movzbl	array1(,%rax), %eax
	cmpl	-4(%rbp), %eax
	jne	.LBB0_3
# %bb.2:                                # %if.then3
	movzbl	array2, %eax
	movzbl	temp, %ecx
	andl	%eax, %ecx
	movb	%cl, temp
.LBB0_3:                                # %if.end
	jmp	.LBB0_4
.LBB0_4:                                # %if.end7
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	victim_function_v10, .Lfunc_end0-victim_function_v10
	.cfi_endproc
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movabsq	$.L.str, %rdi
	leaq	-16(%rbp), %rsi
	leaq	-4(%rbp), %rdx
	movb	$0, %al
	callq	__isoc99_scanf
	movq	-16(%rbp), %rdi
	movl	-4(%rbp), %esi
	callq	victim_function_v10
	xorl	%eax, %eax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%zu,%d"
	.size	.L.str, 7


	.ident	"clang version 8.0.0 (trunk 342348)"
	.section	".note.GNU-stack","",@progbits
