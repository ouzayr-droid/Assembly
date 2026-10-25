; fichier: first.asm
; Premier programme assembleur. Ce programme attend la saisie de deux
; entiers et affiche leur somme.
; Pour creer l’executable en utilisant djgpp :
; nasm -f coff first.asm
; gcc -o first first.o driver.c asm_io.o
%include "asm_io.inc"
;
; Les donnees initialisees sont placees dans le segment .data
;
segment .data
;
; Ces labels referencent les chaines utilisees pour l’affichage
;
prompt1 db "Entrez un nombre : ", 0
prompt2 db "Entrez un autre nombre : ", 0
outmsg1 db "Vous avez entre ", 0
outmsg2 db " et ", 0
outmsg3 db ", leur sommevaut ", 0

; les données non initialisées sont placées dans le segment .bss
segment .bss

input1 resd 1
input2 resd 1

; le code est placé dans le segment .text
segment .text
    global _asm_main
_asm_main:
    enter 0,0       ; initialisation
    pusha

    mov eax, prompt1       ; chargement du message d'affichage
    call print_string      ; affichage du message

    call read_int          ; récupération de la saisie de l'utilisateur
    mov [input1], eax      ; le stocke dans input1

    mov eax, prompt2       ; chargement de prompt2 dans eax
    call print_string      ; affichage de prompt2 à l'écran de l'utilisateur

    call read_int          ; récupération de la saisie de l'utilisateur
    mov [input2], eax      ; puis le stocke dans input2

    mov eax, [input1]      ; eax = input1
    add eax, [input2]      ; eax += input2
    mov ebx, eax           ; ebx = eax

    dump_regs 1            ; affichage des régistres
    dump_mem 2, outmsg1, 1

    ; ce qui suit affiche le message resultat en plusieurs étapes

    mov eax, outmsg1
    call print_string      ; affiche le premier message
    mov eax, [input1]
    call print_int
    mov eax, outmsg2
    call print_string
    mov eax, [input2]
    call print_int
    mov eax, outmsg3
    call print_string
    mov eax, ebx
    call print_int
    call print_nl

    popa
    mov eax, 0
    leave
    ret