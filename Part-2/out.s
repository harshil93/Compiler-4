main:
move $t0 $sp
addiu $sp $sp -24
li $a0 5
sw $a0 0($t0)
lw $a0 0($t0)
sw $a0 0($sp)
addiu $sp $sp -4
li $a0 0
lw $t1 4($sp)
addiu $sp $sp 4
sub $a0 $t1 $a0
bgtz $a0 _lb0
li $a0 0
b _lb1
_lb0:li $a0 1
_lb1:sw $a0 4($t0)
lw $a0 4($t0)
li $t1 0
bne $a0 $t1 label1
b label2
label1:
li $a0 10
sw $a0 8($t0)
lw $a0 8($t0)
sw $a0 0($sp)
addiu $sp $sp -4
li $a0 1
lw $t1 4($sp)
addiu $sp $sp 4
sub $a0 $t1 $a0
sw $a0 12($t0)
lw $a0 12($t0)
sw $a0 8($t0)
label2:
lw $a0 0($t0)
sw $a0 0($sp)
addiu $sp $sp -4
li $a0 2
lw $t1 4($sp)
addiu $sp $sp 4
sub $a0 $t1 $a0
sw $a0 16($t0)
lw $a0 16($t0)
sw $a0 0($t0)
jr $ra
