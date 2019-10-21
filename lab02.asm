; somador de dois números de 32 bits
;   - as duas double-words (32 bits) são formadas pelas duas
;     partes de cada uma numX1 e numX2;
;   - fazer a soma dos números e alocar num terceiro
;     bloco de memória;
;   - a soma é feita somando a parte baixa de cada palavra
;     e depois somando as duas partes altas das palavras
;     considerando a flag de carry
;
segment code
     ..start:
    ; -----------------INICIAR DS, SS e SP-------------------------
     ; ds<-data
     mov ax, data
     mov ds, ax
     ; ss<-stack
     mov ax, stack
     mov ss, ax
     ; sp<-stacktop
     mov sp, stacktop
    ; --------------------CODIGO DO PROGRAMA-----------------------
    ; parte baixa do primeiro número :
    mov ax, 0xbbaa      ; ax = 0xbbaa
    mov word[1000], ax  ; move ax como word para o bloco de
                        ; memória na posição 1000 (0x03E8)
    ; parte baixa do primeiro número :
    mov ax, 0xddcc      ; ax = 0xddcc
    mov word[1002], ax  ; move ax como word para o bloco de
                        ; memória na posição 1002 (0x03EA)
   ; na memória teremos 0xaabbccdd

    ; parte baixa do segundo número :
    mov ax, 0x6655      ; ax = 0x6655
    mov word[2000], ax  ; move ax como word para o bloco de
                        ; memória na posição 2000 (0x07D0)
    ; parte alta do segundo número :
    mov ax, 0x8a77      ; ax = 0x8a77
    mov word[2002], ax  ; move ax como word para o bloco de
                        ; memória na posição 2002 (0x07D2)
    ; na memória teremos 0x556677a8

    ; a soma em si:
    ; soma da parte baixa
    mov ax, word[1000]  ; ax = word[pos = 1000 (0x03E8)]
    mov bx, word[2000]  ; bx = word[pos = 2000 (0x07D0)]
    add ax, bx           ; ax += bx
    mov word[3000], ax  ; move ax como word para o bloco de
                         ; memória na posição 3000 (0x0BB8)
    ; soma da parte alta
    mov ax, word[1002]  ; ax = word[pos = 1002 (0x03EA)]
    mov bx, word[2002]  ; bx = word[pos = 2002 (0x07D2)]
    adc ax, bx          ; ax += bx + cf
                        ; soma levando em conta a flag de carry
                        ; setada pela última soma
    mov word[3002], ax  ; joga na memória na pos 3002 (0x0BBA)
    ; o resultado ficará nos blocos de memória 0x0BB8 e 0x0BBA

     ; -----------------------SAIDA DO PROGRAMA----------------------
	 mov ah, 0X4c  ; ah = 0x4c
   int 0X21      ; quando ah = 0x4c, int21h => "EXIT":
                 ; TERMINATE WITH RETURN CODE
segment data
     ; -----------------DEF. VAR,CONST E ALOCACAO-------------------
segment stack stack
     ; ------------------------DEF. PILHA---------------------------
     resb 256 ; definição da pilha com total de 256 bytes
stacktop:
