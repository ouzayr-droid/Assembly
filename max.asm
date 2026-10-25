%include "asm_io.inc"

segment .data

message1 db "Veuillez entrer un nombre: ", 0
message2 db "Veuillez entrer un autre nombre: ", 0
message3 db "Le plus grand nombre est: ", 0

segment .bss

input1 resd 1           ; ici on stocke l'input de l'utilisateur
input2 resd 1

segment .text
    global _asm_main

_asm_main:
    enter 0,0           ; routine d'initialisation
    pusha

    mov eax, message1   ; affichage du premier message pour qu'il puisse entrer la première valeur à comparer
    call print_string
    call read_int       ; on lit la première valeur de comparaison
    mov [input1], eax

    mov eax, message2   ; affichage du deuxième message
    call print_string
    call read_int       ; on lit la deuxième valeur de comparaison

    xor ebx, ebx        ; ebx = 0
    cmp eax, [input1]   ; ici on compare eax(deuxième valeur entré) [input1] qui contient la première valeur entré
    setg bl             ; ebx = (input2 > input1) ? 1:0
    neg ebx             ; ebx = (input2 > input1) ? 0xFFFFFFFF:0
    mov ecx, ebx        ; ecx = (input2 > input1) ? 0xFFFFFFFF:0
    and ecx, eax        ; ecx = (input2 > input1) ? input2 : 0
    not ebx             ; ebx = (input2 > input1) ? 0:0xFFFFFFFF
    and ebx, [input1]   ; ebx = (input2 > input1) ? 0:input1
    or ecx, ebx         ; ecx = (input2 > input1) ? input2 : input1

    mov eax, message3   ; affichage du résultat
    call print_string
    mov eax, ecx
    call print_int
    call print_nl

    popa
    mov eax, O          ; retour au C
    leave
    ret