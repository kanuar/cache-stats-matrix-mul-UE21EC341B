# program to find sum of rows in a matrix without loop unrolling 
.data
	mat: .word 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
	rows: .word 4
	columns: .word 4
	row_sum: .zero 4*4

.text
	la x4,row_sum
	lw x2,rows
	lw x3,columns
	la x1,mat

	li x5,0
	li x6,0

	row_loop:
		slli x7,x5,4
		column_loop:
			slli x8,x6,2
			add x9,x8,x7
			add x9,x9,x1
			lw x10,0(x9)
			lw x11,0(x4)
			add x11,x11,x10
			sw x11,0(x4)
			addi x6,x6,1
			bne x6,x3,column_loop
		
		addi x4,x4,4
		addi x5,x5,1
		mv x6,x0
		bne x5,x2,row_loop

	nop