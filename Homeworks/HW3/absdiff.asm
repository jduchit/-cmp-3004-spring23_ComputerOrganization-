# Implement a function named abs_diff that calculates the absolute value of the difference of two inputs a and b 
# (i.e., |a-b|), and get the assembly code output

.data
result: .word 0                     
msg_a: .asciiz "Ingrese el valor de a: "                 
msg_b: .asciiz "Ingrese el valor de b: "                
msg_continue: .asciiz "\n\nIngrese 1 para continuar, 0 para salir: "  

.text
.globl main
main:
    # Loop hasta que el usuario ingrese 0
    loop:
        # Solicitar input para a
        li $v0, 4                   # Cargar el codigo de la llamada al sistema para imprimir una cadena
        la $a0, msg_a               # Cargar la direccion del mensaje para ingresar a en $a0
        syscall                     # Realizar la llamada al sistema para imprimir el mensaje

        # Leer input para a
        li $v0, 5                   # Cargar el codigo de la llamada al sistema para leer un entero
        syscall                     # Realizar la llamada al sistema para leer el valor de a
        move $s0, $v0               # Almacenar el valor de a en $s0

        # Solicitar input para b
        li $v0, 4                   # Cargar el codigo de la llamada al sistema para imprimir una cadena
        la $a0, msg_b               # Cargar la direccion del mensaje para ingresar b en $a0
        syscall                     # Realizar la llamada al sistema para imprimir el mensaje

        # Leer input para b
        li $v0, 5                   # Cargar el codigo de la llamada al sistema para leer un entero
        syscall                     # Realizar la llamada al sistema para leer el valor de b
        move $s1, $v0               # Almacenar el valor de b en $s1

        # Llamar a la funcion abs_diff
        move $a0, $s0               # Pasar el valor de a en $a0
        move $a1, $s1               # Pasar el valor de b en $a1
        jal abs_diff                # Realizar la llamada a la funcion abs_diff

        # Mostrar el resultado
        move $a0, $v0               # Pasar el resultado en $v0 como argumento para imprimir
        li $v0, 1                   # Cargar el codigo de la llamada al sistema para imprimir un entero
        syscall                     # Realizar la llamada al sistema para imprimir el resultado

        # Solicitar input para continuar o salir
        li $v0, 4                   # Cargar el codigo de la llamada al sistema para imprimir una cadena
        la $a0, msg_continue        # Cargar la direccion del mensaje para continuar o salir en $a0
        syscall                     # Realizar la llamada al sistema para imprimir el mensaje

        # Leer input para continuar o salir
        li $v0, 5                   # Cargar el codigo de la llamada al sistema para leer un entero
        syscall                     # Realizar la llamada al sistema para leer el valor de continuar o salir
        move $s2, $v0               # Almacenar el valor de continuar o salir en $s2

        # Verificar si el usuario desea salir
        beq $s2, 0, end_loop        # Si el valor es igual a 0, salir del loop

        # Repetir el loop
        j loop                      # Saltar al inicio del loop

    end_loop:
        # Salir del programa
        li $v0, 10                  # Cargar el codigo de la llamada al sistema para salir
        syscall                     # Realizar la llamada al sistema para salir del programa

abs_diff:
    subu $v0, $a0, $a1              # Calcular la diferencia entre a y b y almacenarla en $v0
    bltz $v0, negative              # Saltar si la diferencia es menor que cero
    jr $ra                          # Retornar al punto de llamada

negative:
    negu $v0, $v0                   # Calcular el valor absoluto de la diferencia negativa y almacenarla en $v0
    jr $ra                          # Retornar al punto de llamada
