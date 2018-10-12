# please compile it as : 
# g++ test-spec-lsl.s -o test-spec-lsl-same-r
# This tell us that
# 
# lw r1, [r2]
# sw r1, [r3]  this might also be an address dep
# lw r4, [r3]  this could be reordered earlier than the first load
#  but its value may not get right
#  so aggressive! comment by Hongce Zhang

	.file	"test-spec-lsl.c"
	.globl	table0
	.bss
	.align 8
	.type	table0, @object
	.size	table0, 8
table0:
	.zero	8
	.globl	table_sep
	.align 8
	.type	table_sep, @object
	.size	table_sep, 8
table_sep:
	.zero	8
	.globl	table6
	.align 8
	.type	table6, @object
	.size	table6, 8
table6:
	.zero	8
	.globl	tableCheck
	.align 8
	.type	tableCheck, @object
	.size	tableCheck, 8
tableCheck:
	.zero	8
	.globl	table1
	.align 8
	.type	table1, @object
	.size	table1, 8
table1:
	.zero	8
	.globl	table2
	.align 32
	.type	table2, @object
	.size	table2, 64
table2:
	.zero	64
	.globl	table3
	.align 32
	.type	table3, @object
	.size	table3, 64
table3:
	.zero	64
	.globl	table4
	.align 32
	.type	table4, @object
	.size	table4, 64
table4:
	.zero	64
	.globl	table5
	.align 8
	.type	table5, @object
	.size	table5, 8
table5:
	.zero	8
	.section	.rodata
	.align 4
	.type	_ZL9REPEATCNT, @object
	.size	_ZL9REPEATCNT, 4
_ZL9REPEATCNT:
	.long	100
	.section	.text._Z5probePh,"axG",@progbits,_Z5probePh,comdat
	.weak	_Z5probePh
	.type	_Z5probePh, @function
_Z5probePh:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rcx
#APP
# 59 "test-spec-lsl.c" 1
	 mfence 			
 lfence			
 rdtsc				
 lfence			
 movl %eax, %esi 
 movl (%rcx) , %eax 
 lfence 			
 rdtsc				
 subl %esi, %eax 
 clflush 0(%rcx)     

# 0 "" 2
#NO_APP
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	_Z5probePh, .-_Z5probePh
	.section	.rodata
	.align 8
.LC0:
	.string	"realqi: %d, Time = %ld, %ld, %ld, %ld,  %c\n"
.LC1:
	.string	"Non-prefetched tb1 load: %ld\n"
.LC2:
	.string	"used: %ld vs. unused:%ld\n"
	.align 8
.LC3:
	.string	"store-load did happen correctly, but tb0 not touched:%ld\n"
	.align 8
.LC4:
	.string	"store-load did happen (ic), but tb0 not touched:%ld\n"
	.align 8
.LC5:
	.string	"(store)-load did happen (c/ic), but tb0 not touched:%ld\n"
.LC6:
	.string	"prefetcher effect: %ld\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$216, %rsp
	.cfi_offset 3, -24
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	call	rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$24, %eax
	addl	%eax, %edx
	movzbl	%dl, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movb	%al, -223(%rbp)
	movl	$0, -200(%rbp)
	movl	$0, -196(%rbp)
	movl	$0, -192(%rbp)
	call	rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$24, %eax
	addl	%eax, %edx
	movzbl	%dl, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movb	%al, -222(%rbp)
	call	rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$24, %eax
	addl	%eax, %edx
	movzbl	%dl, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -188(%rbp)
	call	rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$30, %eax
	addl	%eax, %edx
	andl	$3, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -216(%rbp)
	call	rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$24, %eax
	addl	%eax, %edx
	movzbl	%dl, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -212(%rbp)
	movq	$0, -120(%rbp)
	movq	$0, -112(%rbp)
	movq	$0, -104(%rbp)
	movq	$0, -96(%rbp)
	movq	$0, -88(%rbp)
	movq	$0, -80(%rbp)
	movq	$0, -72(%rbp)
	movl	$64, %eax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, table0(%rip)
	movl	$64, %eax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, table1(%rip)
	movl	$256, %eax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, table_sep(%rip)
	movl	$64, %eax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, table6(%rip)
	movl	$64, %eax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, table5(%rip)
	movl	$256, %eax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, tableCheck(%rip)
	movl	$0, -220(%rbp)
.L5:
	cmpl	$63, -220(%rbp)
	jg	.L4
	movq	table1(%rip), %rdx
	movl	-220(%rbp), %eax
	cltq
	leaq	(%rdx,%rax), %rbx
	call	rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$24, %eax
	addl	%eax, %edx
	movzbl	%dl, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movb	%al, (%rbx)
	call	rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$24, %eax
	addl	%eax, %edx
	movzbl	%dl, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, %edx
	movl	-220(%rbp), %eax
	cltq
	movb	%dl, table2(%rax)
	call	rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$24, %eax
	addl	%eax, %edx
	movzbl	%dl, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, %edx
	movl	-220(%rbp), %eax
	cltq
	movb	%dl, table3(%rax)
	call	rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$24, %eax
	addl	%eax, %edx
	movzbl	%dl, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, %edx
	movl	-220(%rbp), %eax
	cltq
	movb	%dl, table4(%rax)
	movq	table5(%rip), %rdx
	movl	-220(%rbp), %eax
	cltq
	leaq	(%rdx,%rax), %rbx
	call	rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$24, %eax
	addl	%eax, %edx
	movzbl	%dl, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movb	%al, (%rbx)
	movq	table6(%rip), %rdx
	movl	-220(%rbp), %eax
	cltq
	leaq	(%rdx,%rax), %rbx
	call	rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$24, %eax
	addl	%eax, %edx
	movzbl	%dl, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movb	%al, (%rbx)
	addl	$1, -220(%rbp)
	jmp	.L5
.L4:
	movl	$0, -220(%rbp)
.L7:
	cmpl	$15, -220(%rbp)
	jg	.L6
	movq	table0(%rip), %rax
	movl	-220(%rbp), %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	leaq	(%rax,%rdx), %rbx
	call	rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$30, %eax
	addl	%eax, %edx
	andl	$3, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, (%rbx)
	addl	$1, -220(%rbp)
	jmp	.L7
.L6:
	movl	$table2, %edi
	call	_Z5probePh
	movl	$table3, %edi
	call	_Z5probePh
	movl	$table4, %edi
	call	_Z5probePh
	movq	table1(%rip), %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movq	%rax, -176(%rbp)
	movq	table5(%rip), %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movq	%rax, -152(%rbp)
	movl	$0, -220(%rbp)
.L44:
	cmpl	$99999, -220(%rbp)
	jg	.L8
	call	rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$24, %eax
	addl	%eax, %edx
	movzbl	%dl, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movb	%al, -223(%rbp)
	call	rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$24, %eax
	addl	%eax, %edx
	movzbl	%dl, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movb	%al, -221(%rbp)
	call	rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$30, %eax
	addl	%eax, %edx
	andl	$3, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -216(%rbp)
	call	rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$24, %eax
	addl	%eax, %edx
	movzbl	%dl, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -212(%rbp)
	movl	-212(%rbp), %eax
	movl	%eax, -184(%rbp)
	movl	-184(%rbp), %eax
	leal	1(%rax), %edx
	movl	-184(%rbp), %eax
	imull	%edx, %eax
	movl	%eax, -184(%rbp)
	addl	$1, -184(%rbp)
	movl	-184(%rbp), %eax
	leal	1(%rax), %edx
	movl	-184(%rbp), %eax
	imull	%edx, %eax
	movl	%eax, -184(%rbp)
	movl	-184(%rbp), %eax
	leal	1(%rax), %edx
	movl	-184(%rbp), %eax
	addl	$2, %eax
	imull	%edx, %eax
	movl	%eax, -184(%rbp)
	movq	table0(%rip), %rax
	movl	-184(%rbp), %edx
	andl	$15, %edx
	salq	$2, %rdx
	addq	%rdx, %rax
	movl	(%rax), %eax
	movl	%eax, -184(%rbp)
	movq	table1(%rip), %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movq	%rax, -168(%rbp)
	movl	$table2, %edi
	call	_Z5probePh
	movl	$table3, %edi
	call	_Z5probePh
	movl	$table4, %edi
	call	_Z5probePh
	movq	table5(%rip), %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movq	%rax, -176(%rbp)
	movq	table6(%rip), %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movq	table_sep(%rip), %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movq	table_sep(%rip), %rax
	addq	$64, %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movq	table_sep(%rip), %rax
	subq	$-128, %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movq	table_sep(%rip), %rax
	addq	$192, %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movq	tableCheck(%rip), %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movq	tableCheck(%rip), %rax
	addq	$64, %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movq	tableCheck(%rip), %rax
	subq	$-128, %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movq	tableCheck(%rip), %rax
	addq	$192, %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movq	table0(%rip), %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movzbl	-221(%rbp), %eax
	andl	$63, %eax
	cltq
	movzbl	table4(%rax), %eax
	movb	%al, -221(%rbp)
	movzbl	-221(%rbp), %eax
	andl	$63, %eax
	cltq
	movzbl	table3(%rax), %eax
	movb	%al, -221(%rbp)
	movzbl	-221(%rbp), %eax
	andl	$63, %eax
	cltq
	movzbl	table2(%rax), %eax
	movb	%al, -221(%rbp)
	cmpb	$99, -221(%rbp)
	ja	.L9
	movl	-212(%rbp), %eax
	leal	1(%rax), %edx
	movl	-212(%rbp), %eax
	imull	%edx, %eax
	movl	%eax, -212(%rbp)
	addl	$1, -212(%rbp)
	movl	-212(%rbp), %eax
	leal	1(%rax), %edx
	movl	-212(%rbp), %eax
	imull	%edx, %eax
	movl	%eax, -212(%rbp)
	movl	-212(%rbp), %eax
	leal	1(%rax), %edx
	movl	-212(%rbp), %eax
	addl	$2, %eax
	imull	%edx, %eax
	movl	%eax, -212(%rbp)
	movq	table0(%rip), %rax
	movl	-212(%rbp), %edx
	andl	$15, %edx
	salq	$2, %rdx
	addq	%rdx, %rax
	movl	(%rax), %eax
	movl	%eax, -212(%rbp)
	movq	table1(%rip), %rcx
	movl	-188(%rbp), %eax
	cltd
	shrl	$28, %edx
	addl	%edx, %eax
	andl	$15, %eax
	subl	%edx, %eax
	cltq
	salq	$2, %rax
	leaq	(%rcx,%rax), %rdx
	movl	-212(%rbp), %eax
	movl	%eax, (%rdx)
	# movq	table1(%rip), %rcx
	# movl	-188(%rbp), %eax
	# cltd
	# shrl	$28, %edx
	# addl	%edx, %eax
	# andl	$15, %eax
	# subl	%edx, %eax
	# cltq
	# salq	$2, %rax
	# addq	%rcx, %rax
	movl	(%rdx), %edx
	movl	%edx, -180(%rbp)
	movq	tableCheck(%rip), %rax
	movl	-180(%rbp), %edx
	movslq	%edx, %rdx
	salq	$6, %rdx
	addq	%rdx, %rax
	movl	(%rax), %eax
	movl	%eax, -208(%rbp)
.L9:
	movq	table1(%rip), %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movq	%rax, -160(%rbp)
	movq	table5(%rip), %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movq	%rax, -144(%rbp)
	movq	table6(%rip), %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movq	%rax, -136(%rbp)
	movq	table0(%rip), %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movq	%rax, -128(%rbp)
	movq	tableCheck(%rip), %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movq	%rax, -64(%rbp)
	movq	tableCheck(%rip), %rax
	addq	$64, %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movq	%rax, -56(%rbp)
	movq	tableCheck(%rip), %rax
	subq	$-128, %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movq	%rax, -48(%rbp)
	movq	tableCheck(%rip), %rax
	addq	$192, %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movq	%rax, -40(%rbp)
	cmpb	$99, -221(%rbp)
	jbe	.L10
	movq	-160(%rbp), %rax
	cmpq	$99, %rax
	ja	.L10
	movq	-144(%rbp), %rax
	cmpq	$100, %rax
	jbe	.L10
	movq	-136(%rbp), %rax
	cmpq	$100, %rax
	jbe	.L10
	movl	$1, %eax
	jmp	.L11
.L10:
	movl	$0, %eax
.L11:
	testb	%al, %al
	je	.L12
	movq	-112(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -112(%rbp)
.L12:
	movq	-136(%rbp), %rax
	cmpq	$99, %rax
	setbe	%al
	testb	%al, %al
	je	.L13
	movq	-120(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -120(%rbp)
.L13:
	cmpb	$99, -221(%rbp)
	jbe	.L14
	movq	-160(%rbp), %rax
	cmpq	$99, %rax
	ja	.L14
	movq	-144(%rbp), %rax
	cmpq	$100, %rax
	jbe	.L14
	movq	-136(%rbp), %rax
	cmpq	$100, %rax
	jbe	.L14
	movq	-128(%rbp), %rax
	cmpq	$100, %rax
	jbe	.L14
	movl	$1, %eax
	jmp	.L15
.L14:
	movl	$0, %eax
.L15:
	testb	%al, %al
	je	.L16
	movq	-80(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -80(%rbp)
.L16:
	cmpb	$99, -221(%rbp)
	jbe	.L17
	movq	-160(%rbp), %rax
	cmpq	$99, %rax
	ja	.L17
	movq	-144(%rbp), %rax
	cmpq	$100, %rax
	jbe	.L17
	movq	-136(%rbp), %rax
	cmpq	$100, %rax
	jbe	.L17
	movq	-64(%rbp), %rax
	cmpq	$99, %rax
	jbe	.L18
	movq	-56(%rbp), %rax
	cmpq	$99, %rax
	jbe	.L18
	movq	-48(%rbp), %rax
	cmpq	$99, %rax
	jbe	.L18
	movq	-40(%rbp), %rax
	cmpq	$99, %rax
	ja	.L17
.L18:
	movq	-64(%rbp), %rax
	cmpq	$99, %rax
	ja	.L19
	movq	-56(%rbp), %rax
	cmpq	$99, %rax
	jbe	.L17
.L19:
	movq	-64(%rbp), %rax
	cmpq	$99, %rax
	ja	.L20
	movq	-48(%rbp), %rax
	cmpq	$99, %rax
	jbe	.L17
.L20:
	movq	-64(%rbp), %rax
	cmpq	$99, %rax
	ja	.L21
	movq	-40(%rbp), %rax
	cmpq	$99, %rax
	jbe	.L17
.L21:
	movq	-56(%rbp), %rax
	cmpq	$99, %rax
	ja	.L22
	movq	-48(%rbp), %rax
	cmpq	$99, %rax
	jbe	.L17
.L22:
	movq	-56(%rbp), %rax
	cmpq	$99, %rax
	ja	.L23
	movq	-40(%rbp), %rax
	cmpq	$99, %rax
	jbe	.L17
.L23:
	movq	-48(%rbp), %rax
	cmpq	$99, %rax
	ja	.L24
	movq	-40(%rbp), %rax
	cmpq	$99, %rax
	jbe	.L17
.L24:
	movq	-64(%rbp), %rax
	cmpq	$99, %rax
	ja	.L25
	movq	-56(%rbp), %rax
	cmpq	$99, %rax
	ja	.L25
	movq	-48(%rbp), %rax
	cmpq	$99, %rax
	jbe	.L17
.L25:
	movq	-64(%rbp), %rax
	cmpq	$99, %rax
	ja	.L26
	movq	-56(%rbp), %rax
	cmpq	$99, %rax
	ja	.L26
	movq	-40(%rbp), %rax
	cmpq	$99, %rax
	jbe	.L17
.L26:
	movq	-64(%rbp), %rax
	cmpq	$99, %rax
	ja	.L27
	movq	-48(%rbp), %rax
	cmpq	$99, %rax
	ja	.L27
	movq	-40(%rbp), %rax
	cmpq	$99, %rax
	jbe	.L17
.L27:
	movq	-56(%rbp), %rax
	cmpq	$99, %rax
	ja	.L28
	movq	-48(%rbp), %rax
	cmpq	$99, %rax
	ja	.L28
	movq	-40(%rbp), %rax
	cmpq	$99, %rax
	jbe	.L17
.L28:
	movq	-64(%rbp), %rax
	cmpq	$99, %rax
	ja	.L29
	movq	-56(%rbp), %rax
	cmpq	$99, %rax
	ja	.L29
	movq	-48(%rbp), %rax
	cmpq	$99, %rax
	ja	.L29
	movq	-40(%rbp), %rax
	cmpq	$99, %rax
	jbe	.L17
.L29:
	movl	$1, %eax
	jmp	.L30
.L17:
	movl	$0, %eax
.L30:
	testb	%al, %al
	je	.L31
	movb	$1, -224(%rbp)
	movl	$0, -204(%rbp)
.L39:
	cmpl	$3, -204(%rbp)
	jg	.L32
	movl	-204(%rbp), %eax
	cmpl	-184(%rbp), %eax
	jne	.L33
	movl	-204(%rbp), %eax
	cltq
	movq	-64(%rbp,%rax,8), %rax
	cmpq	$99, %rax
	jbe	.L33
	movl	$1, %eax
	jmp	.L34
.L33:
	movl	$0, %eax
.L34:
	testb	%al, %al
	je	.L35
	movb	$0, -224(%rbp)
.L35:
	movl	-204(%rbp), %eax
	cmpl	-184(%rbp), %eax
	je	.L36
	movl	-204(%rbp), %eax
	cltq
	movq	-64(%rbp,%rax,8), %rax
	cmpq	$100, %rax
	ja	.L36
	movl	$1, %eax
	jmp	.L37
.L36:
	movl	$0, %eax
.L37:
	testb	%al, %al
	je	.L38
	movb	$0, -224(%rbp)
.L38:
	addl	$1, -204(%rbp)
	jmp	.L39
.L32:
	cmpb	$0, -224(%rbp)
	je	.L40
	movl	$42, %r8d
	jmp	.L41
.L40:
	movl	$32, %r8d
.L41:
	movq	-40(%rbp), %rdi
	movq	-48(%rbp), %rsi
	movq	-56(%rbp), %rcx
	movq	-64(%rbp), %rdx
	movl	-184(%rbp), %eax
	subq	$8, %rsp
	pushq	%r8
	movq	%rdi, %r9
	movq	%rsi, %r8
	movl	%eax, %esi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	addq	$16, %rsp
	cmpb	$0, -224(%rbp)
	je	.L42
	movq	-104(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -104(%rbp)
	movq	-128(%rbp), %rax
	cmpq	$100, %rax
	seta	%al
	testb	%al, %al
	je	.L31
	movq	-88(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -88(%rbp)
	jmp	.L31
.L42:
	movq	-96(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -96(%rbp)
	movq	-128(%rbp), %rax
	cmpq	$100, %rax
	seta	%al
	testb	%al, %al
	je	.L31
	movq	-72(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -72(%rbp)
.L31:
	addl	$1, -220(%rbp)
	jmp	.L44
.L8:
	movq	table1(%rip), %rax
	movq	%rax, %rdi
	call	free
	movq	table5(%rip), %rax
	movq	%rax, %rdi
	call	free
	movq	table6(%rip), %rax
	movq	%rax, %rdi
	call	free
	movq	table_sep(%rip), %rax
	movq	%rax, %rdi
	call	free
	movq	table0(%rip), %rax
	movq	%rax, %rdi
	call	free
	movq	-112(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movq	-96(%rbp), %rdx
	movq	-104(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC2, %edi
	movl	$0, %eax
	call	printf
	movq	-88(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC3, %edi
	movl	$0, %eax
	call	printf
	movq	-72(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movq	-80(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC5, %edi
	movl	$0, %eax
	call	printf
	movq	-120(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC6, %edi
	movl	$0, %eax
	call	printf
	movl	-188(%rbp), %edx
	movl	-216(%rbp), %eax
	addl	%eax, %edx
	movl	-208(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, %edx
	movl	-212(%rbp), %eax
	addl	%edx, %eax
	movq	-24(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L46
	call	__stack_chk_fail
.L46:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
