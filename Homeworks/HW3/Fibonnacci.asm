.text
.globl main
main:
    # Calcular el número Fibonacci en la posición 50
    li $t0, 50   # Número 50
    li $t1, 0    # Número Fibonacci anterior F(n-1)
    li $t2, 1    # Número Fibonacci actual F(n)
    li $t3, 2    # Contador del bucle

    fibonacci_loop:
        beq $t3, $t0, fibonacci_done   # Verificar si el contador del bucle es igual a 50

        # Calcular el siguiente número Fibonacci
        addu $t4, $t1, $t2   # F(n) = F(n-1) + F(n)
        move $t1, $t2        # Actualizar F(n-1) a F(n)
        move $t2, $t4        # Actualizar F(n) al nuevo número Fibonacci

        addiu $t3, $t3, 1    # Incrementar el contador del bucle
        j fibonacci_loop

    fibonacci_done:
        # Imprimir el resultado
        move $a0, $t2   # Mover el número Fibonacci a $a0
        li $v0, 1       # Código de llamada al sistema para imprimir un entero
        syscall

        # Salir del programa
        li $v0, 10
        syscall




