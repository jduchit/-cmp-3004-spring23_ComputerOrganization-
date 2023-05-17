# Write a program to transform from Celsius to Fahrenheit and vice versa

.data
msg_menu: .asciiz "\n\nSelecciona una opcion:\n1. Convertir Celsius a Fahrenheit\n2. Convertir Fahrenheit a Celsius\n3. Salir\n"
tempCelsius: .asciiz "Ingresa la temperatura en Celsius: "
tempFahrenheit: .asciiz "Ingresa la temperatura en Fahrenheit: "
resultFahrenheit: .asciiz "Resultado Fahrenheit: "
resultCelsius:    .asciiz "Resultado Celsius: "
msg_invalidOption: .asciiz "Opcion invalida. Por favor, intenta nuevamente.\n"

.text
.globl main

main:
    j displayMenu  # Saltar a la funcion displayMenu

displayMenu:
    li $v0, 4          # Cargar el codigo del servicio de impresion de cadena
    la $a0, msg_menu   # Cargar la direccion del mensaje de seleccion de opcion
    syscall	       # Imprime el mensaje

    li $v0, 5          # Cargar el codigo del servicio de lectura de entero
    syscall
    move $t0, $v0      # Almacenar la opcion seleccionada en $t0

    beq $t0, 1, celsiusToFahrenheit   # Si la opcion es 1, saltar a la funcion celsiusToFahrenheit
    beq $t0, 2, fahrenheitToCelsius   # Si la opcion es 2, saltar a la funcion fahrenheitToCelsius
    beq $t0, 3, exitProgram           # Si la opcion es 3, saltar a la funcion exitProgram
    j invalidOption                   # Si la opcion no es valida, saltar a la funcion invalidOption

celsiusToFahrenheit:
    # Convertir Celsius a Fahrenheit
    li $v0, 4             # Cargar el codigo del servicio de impresion de cadena
    la $a0, tempCelsius   # Cargar la direccion del mensaje para ingresar la temperatura en Celsius
    syscall               # Imprime el mensaje

    li $v0, 5          # Cargar el codigo del servicio de lectura de entero
    syscall            # Lee la temperatura en Celsius
    move $t1, $v0      # Almacenar la temperatura en Celsius en $t1

    mul $t2, $t1, 9    # Multiplicar Celsius por 9
    div $t2, $t2, 5    # Dividir entre 5
    addi $t2, $t2, 32  # Sumar 32 para obtener Fahrenheit

    li $v0, 4                  # Cargar el codigo del servicio de impresion de cadena
    la $a0, resultFahrenheit   # Cargar la direccion del mensaje de resultado en Fahrenheit
    syscall                    # Imprime el mensaje

    li $v0, 1          # Cargar el codigo del servicio de impresion de entero
    move $a0, $t2      # Cargar el resultado en Fahrenheit en $a0
    syscall            # Imprime el mensaje

    j displayMenu      # Volver a la funcion displayMenu

fahrenheitToCelsius:
    # Convertir Fahrenheit a Celsius
    li $v0, 4                # Cargar el codigo del servicio de impresion de cadena
    la $a0, tempFahrenheit   # Cargar la direccion del mensaje para ingresar la temperatura en Fahrenheit
    syscall                  # Imprime el mensaje

    li $v0, 5          # Cargar el codigo del servicio de lectura de entero
    syscall            # Lee la temperatura en Fahrenheit
    move $t3, $v0      # Almacenar la temperatura en Fahrenheit en $t3

    sub $t4, $t3, 32   # Restar 32 a Fahrenheit
    mul $t4, $t4, 5    # Multiplicar por 5
    div $t4, $t4, 9    # Dividir entre 9

    li $v0, 4          # Cargar el codigo del servicio de impresion de cadena
    la $a0, resultCelsius   # Cargar la direccion del mensaje de resultado en Celsius
    syscall

    li $v0, 1          # Cargar el codigo del servicio de impresion de entero
    move $a0, $t4      # Cargar el resultado en Celsius en $a0
    syscall            # Imprime el mensaje

    j displayMenu      # Volver a la funcion displayMenu

exitProgram:
    li $v0, 10         # Cargar el codigo del servicio de salida del programa
    syscall            # Salir del programa

invalidOption:
    li $v0, 4          # Cargar el codigo del servicio de impresion de cadena
    la $a0, msg_invalidOption   # Cargar la direccion del mensaje de opcion invalida
    syscall

    j displayMenu      # Volver a la funcion displayMenu