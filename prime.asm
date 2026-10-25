%include "asm_io.inc"

segment .data
Message db "Rechercher les nombres premiers jusqu'à: ", 0

segment .bss
Limit resd 1                                                ; rechercher les nombres premiers jusqu'à cette limite
Guess resd 1                                                ; candidat courant pour être premier

segment .text
    global _asm_main

_asm_main:
    enter 0,0
    pusha

    mov eax, Message
    call print_string
    call read_int
    mov [Limit], eax                                        ; here we retrive the value entered by the user

    mov eax, 2
    call print_int
    call print_nl
    mov eax, 3
    call print_int
    call print_nl

    mov dword[Guess], 5                                     ; Guess = 5

while_limit:
    mov eax, [Guess]
    cmp eax, [Limit]
    jnbe end_while_limit                                    ; we use jnbe because the numbers are not signed

    mov ebx, 3                                              ; ebx est factor=3

while_factor:
    mov eax, ebx
    mul eax                                                 ; edx:eax = eax*eax
    jo end_while_factor                                     ; if the response is greater than eax only
    cmp eax, [Guess]
    jnb end_while_factor                                    ; if !(factor*factor < Guess)
    mov eax, [Guess]
    mov edx, 0
    div ebx                                                 ; edx = edx:eax % ebx
    cmp edx, 0
    je end_while_factor                                     ; if !(guess % factor != 0)

    add ebx, 2                                              ; factor += 2
    jmp while_factor

end_while_factor:
    je end_if                                               ; if !(guess % factor != 0)
    mov eax, [Guess]                                        ; printf("%u\n")
    call print_int
    call print_nl

end_if:
    add dword[Guess], 2                                     ; guess += 2
    jmp while_limit

end_while_limit:
    popa
    mov eax, 0                                              ; retour au C
    leave
    ret