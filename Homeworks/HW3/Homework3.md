#  <center> UNIVERSIDAD SAN FRANCISCO DE QUITO </center>
#  <center> COLEGIO: CIENCIAS E INGENIERIAS </center>
#  <center> ORGANIZACIÓN DE COMPUTADORES </center> 
### **Nombre:** Johana Duchi Tipán                          
### **Código Banner:** 00321980
### **Fecha de entrega:** 17 de mayo del 2023.         
### **NRC:** 2359
## <center>**Homework 3** <center>

#### **1) Use assembly to solve the following problems:**


```
a) Obtain the 50th Fibonacci number                             
```


```python
# Obtain the 50th Fibonacci number 

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
```

```
b) Find out if a given year is leap                           
```


```python
# Find out if a given year is leap

.data
    msg_menu: .asciiz "\nIngrese un year (o ingrese 0 para salir): "
    msg_leap: .asciiz "year bisiesto\n"
    not_msg_leap: .asciiz "No es un year bisiesto\n"

.text
.globl main
main:
    li $v0, 4               # Carga el valor 4 en la llamada al sistema para imprimir un mensaje
    la $a0, msg_menu        # Carga la direccion del mensaje para ingresar un year en $a0
    syscall                 # Imprime el mensaje

loop:
    li $v0, 5               # Carga el valor 5 en la llamada al sistema para leer un entero
    syscall                 # Lee el year ingresado y lo guarda en $v0
    move $s0, $v0           # Guarda el year ingresado en $s0

    beqz $s0, exit          # Salta a la etiqueta exit si el year ingresado es igual a cero

    li $t0, 4                           # Carga el valor 4 en $t0
    div $s0, $t0                        # Divide $s0 por $t0
    mfhi $t1                            # Obtiene el resto de la division y lo guarda en $t1
    bne $t1, $zero, not_divisible_by_4  # Salta a not_divisible_by_4 si el resto de la division no es cero

    li $t0, 100                                         # Carga el valor 100 en $t0
    div $s0, $t0                                        # Divide $s0 por $t0
    mfhi $t1                                            # Obtiene el resto de la division y lo guarda en $t1
    bne $t1, $zero, divisible_by_4_not_divisible_by_100 # Salta a divisible_by_4_not_divisible_by_100 si el resto de la division no es cero

    li $t0, 400              # Carga el valor 400 en $t0
    div $s0, $t0             # Divide $s0 por $t0
    mfhi $t1                 # Obtiene el resto de la division y lo guarda en $t1
    bne $t1, $zero, not_leap # Salta a not_leap si el resto de la división no es cero

    li $v0, 4               # Carga el valor 4 en la llamada al sistema para imprimir un mensaje
    la $a0, msg_leap        # Carga la direccion del mensaje "year bisiesto" en $a0
    syscall                 # Imprime el mensaje
    j continue_loop         # Salta a la etiqueta continue_loop

not_divisible_by_4:
    li $v0, 4               # Carga el valor 4 en la llamada al sistema para imprimir un mensaje
    la $a0, not_msg_leap    # Carga la direccion del mensaje "No es un year bisiesto" en $a0
    syscall                 # Imprime el mensaje
    j continue_loop         # Salta a la etiqueta continue_loop

divisible_by_4_not_divisible_by_100:
    li $v0, 4               # Carga el valor 4 en la llamada al sistema para imprimir un mensaje
    la $a0, msg_leap        # Carga la direccion del mensaje "year bisiesto" en $a0
    syscall                 # Imprime el mensaje
    j continue_loop         # Salta a la etiqueta continue_loop

not_leap:
    li $v0, 4               # Carga el valor 4 en la llamada al sistema para imprimir un mensaje
    la $a0, not_msg_leap    # Carga la direccion del mensaje "No es un year bisiesto" en $a0
    syscall                 # Imprime el mensaje
    j continue_loop         # Salta a la etiqueta continue_loop

continue_loop:
    li $v0, 4               # Carga el valor 4 en la llamada al sistema para imprimir un mensaje
    la $a0, msg_menu          # Carga la direccion del mensaje para ingresar un year en $a0
    syscall                 # Imprime el mensaje
    j loop                  # Salta a la etiqueta loop para repetir el ciclo

exit:
    li $v0, 10              # Carga el valor 10 en la llamada al sistema para salir del programa
    syscall                 # Termina el programa
```

##### Referencias:

Anónimo. (2023). rekad’s solution for Leap in MIPS Assembly on Exercism. Exercism. https://exercism.org/tracks/mips/exercises/leap/solutions/60b67cdfd6fb4863b9e13650aebaf83e



```
c) Given an array of integers, calculate the average                                                    
```


```python
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
```

##### Referencias:

McQuain,F.,Ribbens.(2009).Arrays. https://vbrunell.github.io/docs/MIPS%20Arrays.pdf

```
d) Write a program to transform from Celsius to Fahrenheit and vice versa                                                 
```


```python
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
```

#### **2) For the following memory space, what would it look like after executing the assembly code below:**



```python
import pandas as pd 
tabla = pd.DataFrame(data = [[10,1],[11,4],[12,5],[13,112],[14,7]], columns = ['Address','Contents'])
tabla
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Address</th>
      <th>Contents</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>10</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>11</td>
      <td>4</td>
    </tr>
    <tr>
      <th>2</th>
      <td>12</td>
      <td>5</td>
    </tr>
    <tr>
      <th>3</th>
      <td>13</td>
      <td>112</td>
    </tr>
    <tr>
      <th>4</th>
      <td>14</td>
      <td>7</td>
    </tr>
  </tbody>
</table>
</div>



```
LOAD 14
ADD (12)
STORE 12
```

##### Espacio de memoria inicial:


```python
import pandas as pd 
tabla = pd.DataFrame(data = [[10,1],[11,4],[12,5],[13,112],[14,7]], columns = ['Address','Contents'])
tabla
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Address</th>
      <th>Contents</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>10</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>11</td>
      <td>4</td>
    </tr>
    <tr>
      <th>2</th>
      <td>12</td>
      <td>5</td>
    </tr>
    <tr>
      <th>3</th>
      <td>13</td>
      <td>112</td>
    </tr>
    <tr>
      <th>4</th>
      <td>14</td>
      <td>7</td>
    </tr>
  </tbody>
</table>
</div>



###### **LOAD 14:**

```
La instrucción "LOAD 14" carga el valor de la dirección de memoria 14 directamente en la dirección de memoria de destino especificada en las instrucciones posteriores.
```

###### **ADD (12):**

```
La instrucción "ADD(12)" suma el valor almacenado en la dirección de memoria 12 al valor cargado desde la dirección de memoria 14.
```

###### **STORE 12:**

```
La instrucción "STORE 12" almacena el resultado de la suma directamente en la dirección de memoria 12.
```

```
Por lo tanto, el espacio de memoria sería:
```


```python
import pandas as pd 
tabla = pd.DataFrame(data = [[10,1],[11,4],[12,12],[13,112],[14,7]], columns = ['Address','Contents'])
tabla
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Address</th>
      <th>Contents</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>10</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>11</td>
      <td>4</td>
    </tr>
    <tr>
      <th>2</th>
      <td>12</td>
      <td>12</td>
    </tr>
    <tr>
      <th>3</th>
      <td>13</td>
      <td>112</td>
    </tr>
    <tr>
      <th>4</th>
      <td>14</td>
      <td>7</td>
    </tr>
  </tbody>
</table>
</div>




Por lo tanto, el valor final en la dirección de memoria 12 es 12. La instrucción "STORE 12" simplemente almacena el valor y reemplaza el valor anterior.

#### **3) Implement a function named abs_diff that calculates the absolute value of the difference of two inputs a and b (i.e., |a-b|), and get the assembly code output.**


```python
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
```

#### **4) What are the differences among sequential access, direct access, and random access?**

El acceso secuencial implica acceder a los datos en una secuencia lineal específica, donde los datos se organizan en registros y se debe acceder a ellos en el orden en que se almacenan. El acceso directo, por otro lado, permite acceder a bloques o registros específicos dirigiéndose a su ubicación física única, sin necesidad de atravesar los datos precedentes. Este método implica especificar la dirección directamente para llegar a la ubicación deseada. El acceso aleatorio, por su parte permite el acceso inmediato a cualquier ubicación de la memoria, ya que cada ubicación direccionable tiene un mecanismo de direccionamiento único. El tiempo necesario para acceder a una ubicación específica en el acceso aleatorio es constante e independiente de los accesos anteriores. En resumen, el acceso secuencial sigue un orden predefinido, el acceso directo permite acceder a ubicaciones específicas en función de sus direcciones y el acceso aleatorio permite la recuperación inmediata desde cualquier ubicación de la memoria.

##### Referencias:

Proaño, A. (2023). Access Method. GitHub. https://github.com/aproano2/cmp-3004-spring23-aproano/blob/main/week10/mem.ipynb

‌

#### **5) What common characteristics are shared by all RAID levels?**

Todos los niveles de RAID comparten características comunes que contribuyen a su funcionalidad y beneficios. En primer lugar, se utilizan varios discos en configuraciones RAID, lo que permite una mayor capacidad de almacenamiento y un mejor rendimiento. Al distribuir los datos en varios discos, los niveles de RAID pueden gestionar las solicitudes de I/O en paralelo, lo que mejora el rendimiento general del sistema.
En segundo lugar, los niveles de RAID incorporan la redundancia que se utiliza para almacenar información de paridad o datos duplicados, lo que garantiza la capacidad de recuperación de los datos en caso de que falle la unidad. Esta redundancia proporciona una capa adicional de protección y ayuda a mantener la integridad y disponibilidad de los datos.
Además, la data striping es una característica común en los niveles de RAID. Implica dividir los datos en bloques y distribuirlos en varios discos, lo que permite mejorar las velocidades de lectura y escritura al permitir el acceso simultáneo a los datos.

En general, dentro de las características compartidas por todos los niveles de RAID estan la utilización de varios discos, la incorporación de redundancia para la protección de datos y la distribución de datos para mejorar el rendimiento. Estas características hacen de RAID una tecnología eficaz para optimizar la capacidad de almacenamiento, la confiabilidad de los datos y el rendimiento del sistema.

##### Referencias:

Proaño, A. (2023). RAID. GitHub. https://github.com/aproano2/cmp-3004-spring23-aproano/blob/main/week11/mem-pt2.ipynb

