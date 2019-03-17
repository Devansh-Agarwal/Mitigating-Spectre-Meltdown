	.text
	.file	"example1.c"
	.globl	number                  # -- Begin function number
	.p2align	4, 0x90
	.type	number,@function
number:                                 # @number
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -24(%rbp)
	movl	%esi, -8(%rbp)
	movl	%edx, -16(%rbp)
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	addl	$2, %eax
	movl	%eax, -4(%rbp)
	movl	-8(%rbp), %eax
	addl	-8(%rbp), %eax
	movl	%eax, -8(%rbp)
	movl	-16(%rbp), %eax
	addl	-4(%rbp), %eax
	movl	%eax, -4(%rbp)
	movl	-8(%rbp), %eax
	addl	-4(%rbp), %eax
	movl	%eax, -4(%rbp)
	movl	-8(%rbp), %eax
	addl	$2, %eax
	movl	%eax, -8(%rbp)
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	lfence
	cmpl	$2132, %eax             # imm = 0x854
	jle	.LBB0_2
# %bb.1:                                # %if.then
	movl	-4(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -4(%rbp)
.LBB0_2:                                # %if.end
	movl	-4(%rbp), %eax
	movl	%eax, -12(%rbp)
	movl	-12(%rbp), %eax
	addl	$2, %eax
	movl	%eax, -12(%rbp)
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	number, .Lfunc_end0-number
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
	subq	$48, %rsp
	movl	$0, -36(%rbp)
	movl	$22, -20(%rbp)
	movl	$121, -4(%rbp)
	movl	$222, -12(%rbp)
	movl	$2321, -32(%rbp)        # imm = 0x911
	movabsq	$.L.str, %rdi
	leaq	-16(%rbp), %rsi
	leaq	-28(%rbp), %rdx
	movb	$0, %al
	callq	__isoc99_scanf
	movabsq	$.L.str.1, %rdi
	leaq	-16(%rbp), %rsi
	movb	$0, %al
	callq	__isoc99_scanf
	movabsq	$.L.str, %rdi
	leaq	-24(%rbp), %rsi
	leaq	-8(%rbp), %rdx
	movb	$0, %al
	callq	__isoc99_scanf
	movl	-16(%rbp), %eax
	movl	-28(%rbp), %ecx
	lfence
	cmpl	%ecx, %eax
	jle	.LBB1_2
# %bb.1:                                # %if.then
	movl	$7, -24(%rbp)
.LBB1_2:                                # %if.end
	movl	-8(%rbp), %eax
	addl	$22, %eax
	movl	%eax, -20(%rbp)
	movl	$321321, -4(%rbp)       # imm = 0x4E729
	movl	-20(%rbp), %esi
	movl	-8(%rbp), %edx
	leaq	-16(%rbp), %rdi
	callq	number
	cmpl	$2112, -12(%rbp)        # imm = 0x840
	jge	.LBB1_4
# %bb.3:                                # %if.then4
	imull	$21, -12(%rbp), %eax
	movl	%eax, -12(%rbp)
.LBB1_4:                                # %if.end5
	cmpl	$2112, -12(%rbp)        # imm = 0x840
	jge	.LBB1_6
# %bb.5:                                # %if.then7
	imull	$21, -8(%rbp), %eax
	movl	%eax, -8(%rbp)
	imull	$21, -4(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB1_6:                                # %if.end10
	cmpl	$222, -4(%rbp)
	jle	.LBB1_8
# %bb.7:                                # %if.then12
	movl	-4(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -4(%rbp)
.LBB1_8:                                # %if.end13
	movl	-4(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jle	.LBB1_10
# %bb.9:                                # %if.then15
	movl	-4(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -4(%rbp)
.LBB1_10:                               # %if.end17
	xorl	%eax, %eax
	addq	$48, %rsp
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
	.asciz	"%d, %d"
	.size	.L.str, 7

	.type	.L.str.1,@object        # @.str.1
.L.str.1:
	.asciz	"%d"
	.size	.L.str.1, 3


	.ident	"clang version 8.0.0 (trunk 342348)"
	.section	".note.GNU-stack","",@progbits
