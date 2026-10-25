%include "asm_io.inc"

segment .data
; les données initialisées sont placées dans ce segment de données

segment .bss
; les données non initialisées sont placées dans ce segment de données

segment .text
    global _asm_main
_asm_main:
    enter 0,0               ; initialisation
    pusha

; le code est placé dans le segment .text
; na pas modifier le code placé avant ou après ce commentaire

    popa
    mov eax, 0             ; retour au C
    leave
    ret