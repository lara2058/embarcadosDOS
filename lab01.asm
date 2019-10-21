; Faz uma conta simples, passos:
;   - nasm lab01
;       => gera os arquivos .obj e .lst
;   - freelink lab01
;       => liga os arquivos gerados acima e gera o .exe
;   - debug lab01.exe
;       => abre o arquivo no debug, onde é possível verificar
;          os registradores (-r), desassemblar (-u),
;          executar o código intrucao por instrucao (-t),
;          executar o código até o terminador
;         [até achar o int 3] (-g)

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
	 mov bx, 1000h  ; bx = 1000
   mov cx, 2000h  ; cx = 2000
   mov ax, bx    ; ax = bx
   add ax, cx    ; ax = ax + cx
   mov bx, ax    ; bx = ax
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
