	.text
	.file	"test6.c"
	.globl	victim_function_v06     # -- Begin function victim_function_v06
	.p2align	4, 0x90
	.type	victim_function_v06,@function
victim_function_v06:                    # @victim_function_v06
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	andq	array_size_mask, %rax
	movq	-8(%rbp), %rcx
	lfence
	cmpq	%rcx, %rax
	jne	.LBB0_2
# %bb.1:                                # %if.then
	movq	-8(%rbp), %rax
	movzbl	array1(,%rax), %eax
	shll	$9, %eax
	cltq
	movzbl	array2(,%rax), %eax
	movzbl	temp, %ecx
	andl	%eax, %ecx
	movb	%cl, temp
.LBB0_2:                                # %if.end
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	victim_function_v06, .Lfunc_end0-victim_function_v06
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
	leaq	-8(%rbp), %rsi
	movb	$0, %al
	callq	__isoc99_scanf
	movq	-8(%rbp), %rdi
	callq	victim_function_v06
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
	.asciz	"%zu"
	.size	.L.str, 4


	.ident	"clang version 8.0.0 (trunk 342348)"
	.section	".note.GNU-stack","",@progbits
