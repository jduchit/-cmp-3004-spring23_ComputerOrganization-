# Given an array of integers, calculate the average

.data
array:  .word 1,2,3,4,5        # Arreglo prueba
size: .word 5                  # Numero de elementos del arreglo
result: .word 0                # Variable para almacenar el average

.text
.globl main
main:
    la $t0, array      # Carga la dirección del arreglo en $t0
    lw $t1, size     # Carga la longitud del arreglo en $t1

    li $t2, 0          # Inicializa la suma en 0
    li $t3, 0          # Inicializa el índice en 0

loop:
    beq $t3, $t1, calculate_average  # Si el índice es igual a la longitud, salta a calculate_average

    lw $t4, ($t0)      # Carga el elemento actual en $t4
    add $t2, $t2, $t4  # Suma el elemento actual a la suma

    addi $t0, $t0, 4   # Mueve al siguiente elemento en el arreglo
    addi $t3, $t3, 1   # Incrementa el índice

    j loop # Salta de vuelta a loop

calculate_average:
    div $t2, $t1       # Divide la suma por la longitud
    mflo $t2           # Almacena el cociente en $t2

    sw $t2, result     # Almacena el promedio en la variable resultado

     # Imprime el promedio
    li $v0, 1          # Imprime el promedio
    lw $a0, result     # Carga el promedio desde la variable resultado
    syscall            # Realiza la llamada al sistema para imprimir el promedio

    li $v0, 10         # Sale del programa
    syscall