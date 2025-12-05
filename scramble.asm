.model small
.stack 100h

.data
    ; Título do jogo
    titulo db '  ____  ____  ____   __   _  _  ____  __    ____ ', 0
    linha2 db ' / ___)(  __)(  _ \ / _\ ( \/ )(  _ \(  )  (  __)', 0
    linha3 db ' \___ \( (__  )   //    \/ \/ \ ) _ (/ (_/\ ) _) ', 0
    linha4 db ' (____/(____)(__\_)\_/\_/\_)(_/(____/\____/(____)' , 0
    
    ; Menu
    menu_j1 db 218, 196, 196, 196, 196, 196, 196, 196, 191, 0
    menu_j2 db 179, ' Jogar ', 179, 0
    menu_j3 db 192, 196, 196, 196, 196, 196, 196, 196, 217, 0
    
    menu_s1 db 218, 196, 196, 196, 196, 196, 196, 196, 191, 0
    menu_s2 db 179, ' Sair  ', 179, 0
    menu_s3 db 192, 196, 196, 196, 196, 196, 196, 196, 217, 0
    
    ; Sprites
    nave db '>', 0
    meteoro db '*', 0
    alien db '<', 0
    
    ; Posições
    nave_x dw 0
    meteoro_x dw 39
    alien_x dw 20
    alien_dir db 0
    opcao_sel db 1

.code
escreve_texto proc near
    push ax
    push bx
    push cx
    push dx
    push si
    
    mov ah, 02h
    mov bh, 0
    int 10h
    
loop_texto:
    lodsb
    cmp al, 0
    je fim_texto
    
    mov ah, 09h
    mov bh, 0
    mov cx, 1
    int 10h
    
    inc dl
    mov ah, 02h
    int 10h
    
    jmp loop_texto
    
fim_texto:
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
escreve_texto endp

desenha_menu proc near
    push ax
    push bx
    push dx
    push si
    
    ; Desenhar opção "Jogar"
    mov dh, 17
    mov dl, 16
    lea si, menu_j1
    cmp opcao_sel, 1
    jne jog_n
    mov bl, 0Eh
    jmp des_j
jog_n:
    mov bl, 07h
des_j:
    call escreve_texto
    inc dh
    mov dl, 16
    lea si, menu_j2
    call escreve_texto
    inc dh
    mov dl, 16
    lea si, menu_j3
    call escreve_texto
    
    ; Desenhar opção "Sair" (embaixo de Jogar)
    inc dh
    mov dl, 16
    lea si, menu_s1
    cmp opcao_sel, 2
    jne sai_n
    mov bl, 0Eh
    jmp des_s
sai_n:
    mov bl, 07h
des_s:
    call escreve_texto
    inc dh
    mov dl, 16
    lea si, menu_s2
    call escreve_texto
    inc dh
    mov dl, 16
    lea si, menu_s3
    call escreve_texto
    
    pop si
    pop dx
    pop bx
    pop ax
    ret
desenha_menu endp

move_elementos proc near
    push ax
    
    mov ax, nave_x
    inc ax
    cmp ax, 40
    jl save_n
    xor ax, ax
save_n:
    mov nave_x, ax
    
    mov ax, meteoro_x
    dec ax
    cmp ax, 0
    jge save_m
    mov ax, 39
save_m:
    mov meteoro_x, ax
    
    mov al, alien_dir
    cmp al, 0
    je move_esq
    
    mov ax, alien_x
    inc ax
    cmp ax, 39
    jl save_a
    mov alien_dir, 0
    jmp save_a
    
move_esq:
    mov ax, alien_x
    dec ax
    cmp ax, 0
    jg save_a
    mov alien_dir, 1
    
save_a:
    mov alien_x, ax
    
    pop ax
    ret
move_elementos endp

desenha_elementos proc near
    push ax
    push bx
    push dx
    push si
    
    mov dh, 8
    mov ax, nave_x
    mov dl, al
    lea si, nave
    mov bl, 0Fh
    call escreve_texto
    
    mov dh, 10
    mov ax, meteoro_x
    mov dl, al
    lea si, meteoro
    mov bl, 0Ch
    call escreve_texto
    
    mov dh, 12
    mov ax, alien_x
    mov dl, al
    lea si, alien
    mov bl, 0Dh
    call escreve_texto
    
    pop si
    pop dx
    pop bx
    pop ax
    ret
desenha_elementos endp

apaga_elementos proc near
    push ax
    push bx
    push cx
    push dx
    
    mov dh, 8
    mov ax, nave_x
    mov dl, al
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 09h
    mov al, ' '
    mov bl, 0
    mov cx, 1
    int 10h
    
    mov dh, 10
    mov ax, meteoro_x
    mov dl, al
    mov ah, 02h
    int 10h
    mov ah, 09h
    mov al, ' '
    mov cx, 1
    int 10h
    
    mov dh, 12
    mov ax, alien_x
    mov dl, al
    mov ah, 02h
    int 10h
    mov ah, 09h
    mov al, ' '
    mov cx, 1
    int 10h
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
apaga_elementos endp

main proc
    mov ax, @data
    mov ds, ax
    
    ; Configurar modo de vídeo 13h (320x200, 256 cores)
    mov ah, 0       ; Função para configurar modo de vídeo
    mov al, 13h     ; Modo de vídeo 13h (320x200)
    int 10h         ; Interrupção de vídeo
    
    ; Limpar tela para preto (cor 0)
    mov ax, 0A000h  ; Segmento de memória de vídeo no modo 13h
    mov es, ax
    xor di, di      ; DI = 0 (início da memória de vídeo)
    mov cx, 64000   ; 320 * 200 = 64000 pixels
    xor al, al      ; AL = 0 (cor preta)
    rep stosb       ; Preencher toda a tela com preto
    
    ; Desenhar título em verde-claro (0Ah)
    mov dh, 1       ; Linha inicial
    mov dl, 0       ; Coluna inicial
    lea si, titulo
    mov bl, 0Ah     ; Cor verde-claro
    call escreve_texto
    
    inc dh
    mov dl, 0
    lea si, linha2
    call escreve_texto
    
    inc dh
    mov dl, 0
    lea si, linha3
    call escreve_texto
    
    inc dh
    mov dl, 0
    lea si, linha4
    call escreve_texto
    
    ; Desenhar menu
    call desenha_menu
    
loop_principal:
    ; Apagar elementos antigos
    call apaga_elementos
    
    ; Mover elementos
    call move_elementos
    
    ; Desenhar elementos
    call desenha_elementos
    
    ; Delay
    mov cx, 0FFFFh
delay_loop:
    loop delay_loop
    
    ; Verificar tecla
    mov ah, 1       ; Verificar se há tecla pressionada
    int 16h
    jz loop_principal  ; Se não há tecla, continuar loop
    
    ; Ler tecla
    mov ah, 0
    int 16h
    
    ; Verificar tecla pressionada
    cmp ah, 48h     ; Seta para cima
    je tecla_cima
    cmp ah, 50h     ; Seta para baixo
    je tecla_baixo
    cmp al, 13      ; Enter
    je tecla_enter
    jmp loop_principal
    
tecla_cima:
    cmp opcao_sel, 1
    je loop_principal
    dec opcao_sel
    call desenha_menu
    jmp loop_principal
    
tecla_baixo:
    cmp opcao_sel, 2
    je loop_principal
    inc opcao_sel
    call desenha_menu
    jmp loop_principal
    
tecla_enter:
    cmp opcao_sel, 1
    je iniciar_jogo
    jmp sair_programa
    
iniciar_jogo:
    ; TODO: Implementar o jogo
    jmp loop_principal
    
sair_programa:
    ; Retornar ao modo de texto
    mov ah, 0       ; Função para configurar modo de vídeo
    mov al, 3       ; Modo de texto 80x25
    int 10h         ; Interrupção de vídeo
    
    ; Encerrar programa
    mov ah, 4Ch
    int 21h
main endp

end main
