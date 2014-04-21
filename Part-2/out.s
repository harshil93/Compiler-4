main:
move $t0 $sp
addiu $sp $sp -12
lw $a0 4($t0)
sw $a0 0($sp)
addiu $sp $sp -4
li $a0 98
lw $t1 4($sp)
addiu $sp $sp 4
beq $a0 $t1 _lb0
li $a0 0
b _lb1
_lb0:li $a0 1
_lb1:sw $a0 0($t0)
jr $ra
