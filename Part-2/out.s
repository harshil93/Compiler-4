main:
move $t0 $sp
addiu $sp $sp -32
li $a0 3
sw $a0 0($t0)
li $a0 5
sw $a0 4($t0)
label1:
lw $a0 4($t0)
sw $a0 0($sp)
addiu $sp $sp -4
li $a0 1
lw $t1 4($sp)
addiu $sp $sp 4
add $a0 $a0 $t1
sw $a0 8($t0)
lw $a0 0($t0)
sw $a0 0($sp)
addiu $sp $sp -4
lw $a0 8($t0)
lw $t1 4($sp)
addiu $sp $sp 4
sub $a0 $a0 $t1
bgtz $a0 _lb0
li $a0 0
b _lb1
_lb0:li $a0 1
_lb1:sw $a0 12($t0)
lw $a0 12($t0)
li $t1 0
bne $a0 $t1 label2
b label3
label2:
lw $a0 0($t0)
sw $a0 0($sp)
addiu $sp $sp -4
li $a0 1
lw $t1 4($sp)
addiu $sp $sp 4
add $a0 $a0 $t1
sw $a0 16($t0)
lw $a0 16($t0)
sw $a0 0($t0)
lw $a0 4($t0)
sw $a0 0($sp)
addiu $sp $sp -4
li $a0 6
lw $t1 4($sp)
addiu $sp $sp 4
sub $a0 $a0 $t1
bgtz $a0 _lb2
li $a0 0
b _lb3
_lb2:li $a0 1
_lb3:sw $a0 20($t0)
lw $a0 20($t0)
li $t1 0
bne $a0 $t1 label4
b label5
label4:
lw $a0 0($t0)
sw $a0 0($sp)
addiu $sp $sp -4
li $a0 1
lw $t1 4($sp)
addiu $sp $sp 4
add $a0 $a0 $t1
sw $a0 24($t0)
lw $a0 24($t0)
sw $a0 0($t0)
label5:
b label1
label3:
jr $ra
