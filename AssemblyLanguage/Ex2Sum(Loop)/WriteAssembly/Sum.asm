;Johana Duchi 00321980
;Suma de 1 a 10 numeros usando for loops

section .data
    resultado dd 0   ; definir una variable para almacenar el resultado

section .text
    global _start

_start:
    mov eax, 0        ; eax = sum
    mov ebx, 1        ; ebx = i empieza desde 1

loop_start:
    cmp ebx, 10       ; comparar i y 10
    jg loop_end       ; if (i > 10) ir a loop_end
    add eax, ebx      ; sum += i
    inc ebx           ; i++
    jmp loop_start    ; ir a loop_start
  
loop_end:
    mov [resultado], eax   ; almacenar el resultado en la memoria

    ; salir del programa
    mov eax, 1        ; número de sistema para la llamada 'exit'
    xor ebx, ebx      ; código de salida 0
    int 0x80          ; llamar al sistema para salir del programa

