# please compile it with 
# g++ test-spec-store-reorder-load-mod.s -o test-spec-store-reorder-load-mod
# 

	.file	"test-spec-store-reorder-load.c"
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
# 59 "test-spec-store-reorder-load.c" 1
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
	.string	"v: %d, Time = %ld, %ld, %ld, %ld,  %c\n"
.LC1:
	.string	"Non-prefetched tb1 load: %ld\n"
.LC2:
	.string	"used: %ld vs. unused:%ld\n"
	.align 8
.LC3:
	.string	"store-load did happen, but tb0 not touched:%ld\n"
.LC4:
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
	subq	$200, %rsp
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
	movb	%al, -203(%rbp)
	movl	$0, -180(%rbp)
	movl	$0, -176(%rbp)
	movl	$0, -172(%rbp)
	call	rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$24, %eax
	addl	%eax, %edx
	movzbl	%dl, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movb	%al, -202(%rbp)
	call	rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$24, %eax
	addl	%eax, %edx
	movzbl	%dl, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -168(%rbp)
	call	rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$30, %eax
	addl	%eax, %edx
	andl	$3, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -196(%rbp)
	call	rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$24, %eax
	addl	%eax, %edx
	movzbl	%dl, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -192(%rbp)
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
	movl	$0, -200(%rbp)
.L5:
	cmpl	$63, -200(%rbp)
	jg	.L4
	movq	table1(%rip), %rdx
	movl	-200(%rbp), %eax
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
	movl	-200(%rbp), %eax
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
	movl	-200(%rbp), %eax
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
	movl	-200(%rbp), %eax
	cltq
	movb	%dl, table4(%rax)
	movq	table5(%rip), %rdx
	movl	-200(%rbp), %eax
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
	movl	-200(%rbp), %eax
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
	addl	$1, -200(%rbp)
	jmp	.L5
.L4:
	movl	$table2, %edi
	call	_Z5probePh
	movl	$table3, %edi
	call	_Z5probePh
	movl	$table4, %edi
	call	_Z5probePh
	movq	table1(%rip), %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movq	%rax, -160(%rbp)
	movq	table5(%rip), %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movq	%rax, -136(%rbp)
	movl	$0, -200(%rbp)
.L39:
	cmpl	$99999, -200(%rbp)
	jg	.L6
	call	rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$24, %eax
	addl	%eax, %edx
	movzbl	%dl, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movb	%al, -203(%rbp)
	call	rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$24, %eax
	addl	%eax, %edx
	movzbl	%dl, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movb	%al, -201(%rbp)
	call	rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$30, %eax
	addl	%eax, %edx
	andl	$3, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -196(%rbp)
	call	rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$24, %eax
	addl	%eax, %edx
	movzbl	%dl, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -192(%rbp)
	movq	table1(%rip), %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movq	%rax, -152(%rbp)
	movl	$table2, %edi
	call	_Z5probePh
	movl	$table3, %edi
	call	_Z5probePh
	movl	$table4, %edi
	call	_Z5probePh
	movq	table5(%rip), %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movq	%rax, -160(%rbp)
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
	movzbl	-201(%rbp), %eax
	andl	$63, %eax
	cltq
	movzbl	table4(%rax), %eax
	movb	%al, -201(%rbp)
	movzbl	-201(%rbp), %eax
	andl	$63, %eax
	cltq
	movzbl	table3(%rax), %eax
	movb	%al, -201(%rbp)
	movzbl	-201(%rbp), %eax
	andl	$63, %eax
	cltq
	movzbl	table2(%rax), %eax
	movb	%al, -201(%rbp)
	cmpb	$99, -201(%rbp)
	ja	.L7
	movl	-192(%rbp), %eax
	imull	-192(%rbp), %eax
	movl	%eax, -192(%rbp)
	movl	-192(%rbp), %eax
	imull	-192(%rbp), %eax
	movl	%eax, -192(%rbp)
	movl	-192(%rbp), %eax
	imull	-192(%rbp), %eax
	movl	%eax, -192(%rbp)
	movq	table0(%rip), %rax
	movl	-192(%rbp), %edx
	andl	$15, %edx
	salq	$2, %rdx
	addq	%rdx, %rax
	movl	(%rax), %eax
	movl	%eax, -192(%rbp)
	movq	table1(%rip), %rcx
	movl	-168(%rbp), %eax
	cltd
	shrl	$28, %edx
	addl	%edx, %eax
	andl	$15, %eax
	subl	%edx, %eax
	cltq
	salq	$2, %rax
	leaq	(%rcx,%rax), %rdx
	movl	-196(%rbp), %eax
	movl	%eax, (%rdx)
	# movq	table1(%rip), %rcx
	# movl	-168(%rbp), %eax
	# cltd
	# shrl	$28, %edx
	# addl	%edx, %eax
	# andl	$15, %eax
	# subl	%edx, %eax
	# cltq
	# salq	$2, %rax
	# addq	%rcx, %rax
	movl	(%rdx), %edx
	movl	%edx, -164(%rbp)
	movq	tableCheck(%rip), %rax
	movl	-164(%rbp), %edx
	movslq	%edx, %rdx
	salq	$6, %rdx
	addq	%rdx, %rax
	movl	(%rax), %eax
	movl	%eax, -188(%rbp)
.L7:
	movq	table1(%rip), %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movq	%rax, -144(%rbp)
	movq	table5(%rip), %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movq	%rax, -128(%rbp)
	movq	table6(%rip), %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movq	%rax, -120(%rbp)
	movq	table0(%rip), %rax
	movq	%rax, %rdi
	call	_Z5probePh
	movq	%rax, -112(%rbp)
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
	cmpb	$99, -201(%rbp)
	jbe	.L8
	movq	-144(%rbp), %rax
	cmpq	$99, %rax
	ja	.L8
	movq	-128(%rbp), %rax
	cmpq	$100, %rax
	jbe	.L8
	movq	-120(%rbp), %rax
	cmpq	$100, %rax
	jbe	.L8
	movl	$1, %eax
	jmp	.L9
.L8:
	movl	$0, %eax
.L9:
	testb	%al, %al
	je	.L10
	movq	-96(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -96(%rbp)
.L10:
	movq	-120(%rbp), %rax
	cmpq	$99, %rax
	setbe	%al
	testb	%al, %al
	je	.L11
	movq	-104(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -104(%rbp)
.L11:
	cmpb	$99, -201(%rbp)
	jbe	.L12
	movq	-144(%rbp), %rax
	cmpq	$99, %rax
	ja	.L12
	movq	-128(%rbp), %rax
	cmpq	$100, %rax
	jbe	.L12
	movq	-120(%rbp), %rax
	cmpq	$100, %rax
	jbe	.L12
	movq	-64(%rbp), %rax
	cmpq	$99, %rax
	jbe	.L13
	movq	-56(%rbp), %rax
	cmpq	$99, %rax
	jbe	.L13
	movq	-48(%rbp), %rax
	cmpq	$99, %rax
	jbe	.L13
	movq	-40(%rbp), %rax
	cmpq	$99, %rax
	ja	.L12
.L13:
	movq	-64(%rbp), %rax
	cmpq	$99, %rax
	ja	.L14
	movq	-56(%rbp), %rax
	cmpq	$99, %rax
	jbe	.L12
.L14:
	movq	-64(%rbp), %rax
	cmpq	$99, %rax
	ja	.L15
	movq	-48(%rbp), %rax
	cmpq	$99, %rax
	jbe	.L12
.L15:
	movq	-64(%rbp), %rax
	cmpq	$99, %rax
	ja	.L16
	movq	-40(%rbp), %rax
	cmpq	$99, %rax
	jbe	.L12
.L16:
	movq	-56(%rbp), %rax
	cmpq	$99, %rax
	ja	.L17
	movq	-48(%rbp), %rax
	cmpq	$99, %rax
	jbe	.L12
.L17:
	movq	-56(%rbp), %rax
	cmpq	$99, %rax
	ja	.L18
	movq	-40(%rbp), %rax
	cmpq	$99, %rax
	jbe	.L12
.L18:
	movq	-48(%rbp), %rax
	cmpq	$99, %rax
	ja	.L19
	movq	-40(%rbp), %rax
	cmpq	$99, %rax
	jbe	.L12
.L19:
	movq	-64(%rbp), %rax
	cmpq	$99, %rax
	ja	.L20
	movq	-56(%rbp), %rax
	cmpq	$99, %rax
	ja	.L20
	movq	-48(%rbp), %rax
	cmpq	$99, %rax
	jbe	.L12
.L20:
	movq	-64(%rbp), %rax
	cmpq	$99, %rax
	ja	.L21
	movq	-56(%rbp), %rax
	cmpq	$99, %rax
	ja	.L21
	movq	-40(%rbp), %rax
	cmpq	$99, %rax
	jbe	.L12
.L21:
	movq	-64(%rbp), %rax
	cmpq	$99, %rax
	ja	.L22
	movq	-48(%rbp), %rax
	cmpq	$99, %rax
	ja	.L22
	movq	-40(%rbp), %rax
	cmpq	$99, %rax
	jbe	.L12
.L22:
	movq	-56(%rbp), %rax
	cmpq	$99, %rax
	ja	.L23
	movq	-48(%rbp), %rax
	cmpq	$99, %rax
	ja	.L23
	movq	-40(%rbp), %rax
	cmpq	$99, %rax
	jbe	.L12
.L23:
	movq	-64(%rbp), %rax
	cmpq	$99, %rax
	ja	.L24
	movq	-56(%rbp), %rax
	cmpq	$99, %rax
	ja	.L24
	movq	-48(%rbp), %rax
	cmpq	$99, %rax
	ja	.L24
	movq	-40(%rbp), %rax
	cmpq	$99, %rax
	jbe	.L12
.L24:
	movl	$1, %eax
	jmp	.L25
.L12:
	movl	$0, %eax
.L25:
	testb	%al, %al
	je	.L26
	movb	$1, -204(%rbp)
	movl	$0, -184(%rbp)
.L34:
	cmpl	$3, -184(%rbp)
	jg	.L27
	movl	-184(%rbp), %eax
	cmpl	-196(%rbp), %eax
	jne	.L28
	movl	-184(%rbp), %eax
	cltq
	movq	-64(%rbp,%rax,8), %rax
	cmpq	$99, %rax
	jbe	.L28
	movl	$1, %eax
	jmp	.L29
.L28:
	movl	$0, %eax
.L29:
	testb	%al, %al
	je	.L30
	movb	$0, -204(%rbp)
.L30:
	movl	-184(%rbp), %eax
	cmpl	-196(%rbp), %eax
	je	.L31
	movl	-184(%rbp), %eax
	cltq
	movq	-64(%rbp,%rax,8), %rax
	cmpq	$100, %rax
	ja	.L31
	movl	$1, %eax
	jmp	.L32
.L31:
	movl	$0, %eax
.L32:
	testb	%al, %al
	je	.L33
	movb	$0, -204(%rbp)
.L33:
	addl	$1, -184(%rbp)
	jmp	.L34
.L27:
	cmpb	$0, -204(%rbp)
	je	.L35
	movl	$42, %r8d
	jmp	.L36
.L35:
	movl	$32, %r8d
.L36:
	movq	-40(%rbp), %rdi
	movq	-48(%rbp), %rsi
	movq	-56(%rbp), %rcx
	movq	-64(%rbp), %rdx
	movl	-196(%rbp), %eax
	subq	$8, %rsp
	pushq	%r8
	movq	%rdi, %r9
	movq	%rsi, %r8
	movl	%eax, %esi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	addq	$16, %rsp
	cmpb	$0, -204(%rbp)
	je	.L37
	movq	-88(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -88(%rbp)
	movq	-112(%rbp), %rax
	cmpq	$100, %rax
	seta	%al
	testb	%al, %al
	je	.L26
	movq	-72(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -72(%rbp)
	jmp	.L26
.L37:
	movq	-80(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -80(%rbp)
.L26:
	addl	$1, -200(%rbp)
	jmp	.L39
.L6:
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
	movq	-96(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movq	-80(%rbp), %rdx
	movq	-88(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC2, %edi
	movl	$0, %eax
	call	printf
	movq	-72(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC3, %edi
	movl	$0, %eax
	call	printf
	movq	-104(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	-168(%rbp), %edx
	movl	-196(%rbp), %eax
	addl	%eax, %edx
	movl	-188(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, %edx
	movl	-192(%rbp), %eax
	addl	%edx, %eax
	movq	-24(%rbp), %rbx
	xorq	%fs:40, %rbx
	je	.L41
	call	__stack_chk_fail
.L41:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
