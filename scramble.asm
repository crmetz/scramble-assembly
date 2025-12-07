.model small
.stack 100h

.data
    ; Constantes de tempo
    TEMPO_APRESENTACAO equ 4    ; segundos
    TEMPO_FASE equ 60           ; segundos por fase
    
    ; Título do menu
    titulo db ' ___  ___ ___  _   _  _ ___ _    ___', 0
    linha2 db '/ __|/ __| _ \/_\ | \| | _ ) |  | __|', 0
    linha3 db '\__ \ (__|   / _ \| .` | _ \ |__| _|', 0
    linha4 db '|___/\___|_|_\_/\_|_|\_|___/____|___|', 0
    
    ; Apresentação Fase 1
    fase1_t1 db '  ___   _   ___ ___   _ ', 0
    fase1_t2 db ' | __| /_\ / __| __| / |', 0
    fase1_t3 db ' | _| / _ \\__ \ _|  | |', 0
    fase1_t4 db ' |_| /_/ \_\___/___| |_|', 0
    
    ; Apresentação Fase 2
    fase2_t1 db '  ___   _   ___ ___   ___ ', 0
    fase2_t2 db ' | __| /_\ / __| __| |_  )', 0
    fase2_t3 db ' | _| / _ \\__ \ _|   / / ', 0
    fase2_t4 db ' |_| /_/ \_\___/___| /___|', 0
    
    ; Apresentação Fase 3
    fase3_t1 db '  ___   _   ___ ___   ____', 0
    fase3_t2 db ' | __| /_\ / __| __| |__ /', 0
    fase3_t3 db ' | _| / _ \\__ \ _|   |_ \\', 0
    fase3_t4 db ' |_| /_/ \_\___/___| |___/', 0
    
    ; Status
    status_tempo db 'TEMPO: ', 0
    status_fase db 'FASE: ', 0
    
    ; Menu
    menu_j1 db 218, 196, 196, 196, 196, 196, 196, 196, 191, 0
    menu_j2 db 179, ' Jogar ', 179, 0
    menu_j3 db 192, 196, 196, 196, 196, 196, 196, 196, 217, 0
    
    menu_s1 db 218, 196, 196, 196, 196, 196, 196, 196, 191, 0
    menu_s2 db 179, ' Sair  ', 179, 0
    menu_s3 db 192, 196, 196, 196, 196, 196, 196, 196, 217, 0
    
    ; Sprite nave pequena 8x8 (para menu e barra de status)
    sprite_nave_8x8 db 00h,00h,0Bh,0Bh,00h,00h,00h,00h
                    db 00h,0Bh,0Eh,0Eh,0Bh,00h,00h,00h
                    db 0Bh,0Eh,0Eh,0Eh,0Eh,0Bh,00h,00h
                    db 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh
                    db 0Bh,0Eh,0Eh,0Eh,0Eh,0Bh,00h,00h
                    db 00h,0Bh,0Eh,0Eh,0Bh,00h,00h,00h
                    db 00h,00h,0Bh,0Bh,00h,00h,00h,00h
                    db 00h,00h,00h,00h,00h,00h,00h,00h
    
    ; Sprite nave (29x13 pixels) - para jogador - estilo Scramble arcade
    sprite_nave db 00h,00h,00h,00h,00h,00h,00h,00h,09h,09h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
                db 00h,00h,00h,00h,00h,00h,00h,09h,09h,09h,09h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
                db 00h,00h,00h,00h,00h,00h,09h,09h,09h,09h,09h,09h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
                db 00h,00h,00h,00h,00h,09h,09h,09h,09h,09h,09h,09h,09h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
                db 00h,00h,00h,00h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
                db 00h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h
                db 09h,0Eh,0Eh,0Eh,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h
                db 00h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h
                db 00h,00h,00h,00h,09h,09h,09h,09h,09h,09h,09h,09h,09h,09h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
                db 00h,00h,00h,00h,00h,09h,09h,09h,09h,09h,09h,09h,09h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
                db 00h,00h,00h,00h,00h,00h,09h,09h,09h,09h,09h,09h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
                db 00h,00h,00h,00h,00h,00h,00h,09h,09h,09h,09h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
                db 00h,00h,00h,00h,00h,00h,00h,00h,09h,09h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
    
    ; Sprite meteoro (8x8 pixels)
    sprite_meteoro db 00h,04h,04h,04h,04h,00h,00h,00h
                   db 04h,0Ch,0Ch,0Ch,0Ch,04h,00h,00h
                   db 04h,0Ch,04h,0Ch,04h,04h,00h,00h
                   db 04h,0Ch,0Ch,04h,0Ch,04h,04h,00h
                   db 04h,04h,0Ch,0Ch,04h,0Ch,04h,00h
                   db 00h,04h,04h,0Ch,0Ch,04h,04h,00h
                   db 00h,00h,04h,04h,04h,04h,00h,00h
                   db 00h,00h,00h,00h,00h,00h,00h,00h
    
    ; Sprite alien (8x8 pixels)
    sprite_alien db 00h,00h,0Dh,0Dh,0Dh,00h,00h,00h
                 db 00h,0Dh,05h,0Dh,05h,0Dh,00h,00h
                 db 0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,00h
                 db 0Dh,05h,0Dh,0Dh,0Dh,05h,0Dh,00h
                 db 0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,00h
                 db 00h,0Dh,00h,00h,00h,0Dh,00h,00h
                 db 00h,0Dh,00h,00h,00h,0Dh,00h,00h
                 db 00h,00h,00h,00h,00h,00h,00h,00h
    
    ; Posições
    nave_x dw 20
    meteoro_x dw 160
    alien_x dw 280
    alien_dir db 0
    opcao_sel db 1
    
    ; Controle de fases
    fase_atual db 1
    tempo_restante db TEMPO_FASE
    ticks_contador dw 0
    
    ; Controle de jogo
    score dw 0
    vidas db 3
    
    ; Sprite nave pequena para vidas (7x19 pixels)
    sprite_vida db 00h,00h,00h,0Bh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
                db 00h,00h,0Bh,0Eh,0Bh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
                db 00h,0Bh,0Eh,0Eh,0Eh,0Bh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
                db 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh
                db 00h,0Bh,0Eh,0Eh,0Eh,0Bh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
                db 00h,00h,0Bh,0Eh,0Bh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
                db 00h,00h,00h,0Bh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
    
    ; Nave do jogador
    nave_jogador_x dw 40
    nave_jogador_y dw 80
    
    ; Tiros
    MAX_TIROS equ 5
    tiros_x dw MAX_TIROS dup(0)
    tiros_y dw MAX_TIROS dup(0)
    tiros_ativo db MAX_TIROS dup(0)
    
    ; Superfície do planeta (altura Y onde começa)
    superficie_y dw 170
    
    ; Naves alienígenas (fase 1)
    MAX_ALIENS equ 5
    aliens_x dw MAX_ALIENS dup(0)
    aliens_y dw MAX_ALIENS dup(0)
    aliens_ativo db MAX_ALIENS dup(0)
    spawn_counter dw 0
    random_seed dw 0

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
    add ax, 2
    cmp ax, 320
    jl save_n
    xor ax, ax
save_n:
    mov nave_x, ax
    
    mov ax, meteoro_x
    sub ax, 2
    cmp ax, 0
    jge save_m
    mov ax, 320
save_m:
    mov meteoro_x, ax
    
    mov al, alien_dir
    cmp al, 0
    je move_esq
    
    mov ax, alien_x
    add ax, 2
    cmp ax, 310
    jl save_a
    mov alien_dir, 0
    jmp save_a
    
move_esq:
    mov ax, alien_x
    sub ax, 2
    cmp ax, 10
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
    push cx
    push dx
    push di
    push si
    
    ; Desenhar nave (duplicada 2x para ficar maior)
    mov ax, nave_x
    mov bx, 60
    lea si, sprite_nave_8x8
    call desenha_sprite_2x
    
    ; Desenhar meteoro (duplicado 2x)
    mov ax, meteoro_x
    mov bx, 80
    lea si, sprite_meteoro
    call desenha_sprite_2x
    
    ; Desenhar alien (duplicado 2x)
    mov ax, alien_x
    mov bx, 100
    lea si, sprite_alien
    call desenha_sprite_2x
    
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
desenha_elementos endp

; Desenhar sprite 8x8 ampliado 2x (fica 16x16)
; AX = posição X, BX = posição Y, SI = endereço do sprite
desenha_sprite_2x proc near
    push ax
    push bx
    push cx
    push dx
    push di
    push si
    push es
    
    mov dx, 0A000h
    mov es, dx
    
    mov cx, 8       ; 8 linhas do sprite original
loop_y_2x:
    push cx
    push ax
    push si
    
    ; Desenhar linha duplicada (altura 2x)
    mov cx, 2
loop_linha_dup:
    push cx
    push ax
    
    ; Calcular offset: Y * 320 + X
    mov di, bx
    push dx
    mov dx, 320
    push ax
    mov ax, di
    mul dx
    pop dx
    add ax, dx
    mov di, ax
    pop dx
    
    ; Desenhar pixels da linha (cada pixel 2x na largura)
    push si
    mov cx, 8
loop_x_2x:
    lodsb
    cmp al, 0
    je skip_pixel_2x
    
    ; Desenhar pixel duplicado
    mov es:[di], al
    mov es:[di+1], al
skip_pixel_2x:
    add di, 2       ; Avançar 2 pixels
    loop loop_x_2x
    
    pop si
    pop ax
    inc bx          ; Próxima linha
    pop cx
    loop loop_linha_dup
    
    ; Avançar para próxima linha do sprite original
    add si, 8
    pop si
    add si, 8
    pop ax
    pop cx
    loop loop_y_2x
    
    pop es
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
desenha_sprite_2x endp

; Desenhar sprite 29x13 (para nave jogador)
; AX = posição X, BX = posição Y, SI = endereço do sprite
desenha_sprite_29x13 proc near
    push ax
    push bx
    push cx
    push dx
    push di
    push si
    push es
    
    mov dx, 0A000h
    mov es, dx
    
    mov cx, 13      ; 13 linhas
loop_y_29x13:
    push cx
    push ax
    push si
    
    ; Calcular offset: Y * 320 + X
    mov di, bx
    push dx
    mov dx, 320
    push ax
    mov ax, di
    mul dx
    pop dx
    add ax, dx
    mov di, ax
    pop dx
    
    mov cx, 29      ; 29 pixels por linha
loop_x_29x13:
    lodsb
    cmp al, 0
    je skip_pixel_29x13
    mov es:[di], al
skip_pixel_29x13:
    inc di
    loop loop_x_29x13
    
    pop si
    add si, 29
    pop ax
    inc bx
    pop cx
    loop loop_y_29x13
    
    pop es
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
desenha_sprite_29x13 endp

; Desenhar sprite 8x8
; AX = posição X, BX = posição Y, SI = endereço do sprite
desenha_sprite proc near
    push ax
    push bx
    push cx
    push dx
    push di
    push si
    push es
    
    mov dx, 0A000h
    mov es, dx
    
    mov cx, 8
loop_y:
    push cx
    push ax
    push si
    
    ; Calcular offset: Y * 320 + X
    mov di, bx
    push dx
    mov dx, 320
    push ax
    mov ax, di
    mul dx
    pop dx
    add ax, dx
    mov di, ax
    pop dx
    
    mov cx, 8
loop_x:
    lodsb
    cmp al, 0
    je skip_pixel
    mov es:[di], al
skip_pixel:
    inc di
    loop loop_x
    
    pop si
    add si, 8
    pop ax
    inc bx
    pop cx
    loop loop_y
    
    pop es
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
desenha_sprite endp

apaga_elementos proc near
    push ax
    push bx
    push cx
    push dx
    push di
    push es
    
    mov dx, 0A000h
    mov es, dx
    
    ; Apagar nave (16x16 agora)
    mov ax, nave_x
    mov bx, 60
    mov cx, 16
    call apaga_sprite_tamanho
    
    ; Apagar meteoro (16x16)
    mov ax, meteoro_x
    mov bx, 80
    mov cx, 16
    call apaga_sprite_tamanho
    
    ; Apagar alien (16x16)
    mov ax, alien_x
    mov bx, 100
    mov cx, 16
    call apaga_sprite_tamanho
    
    pop es
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
apaga_elementos endp

; Apagar sprite de tamanho variável
; AX = posição X, BX = posição Y, CX = tamanho (largura e altura)
apaga_sprite_tamanho proc near
    push ax
    push bx
    push cx
    push dx
    push di
    push si
    
    mov si, cx      ; Guardar tamanho em SI
loop_apaga_y_tam:
    push cx
    push ax
    
    ; Calcular offset: Y * 320 + X
    mov di, bx
    mov dx, 320
    push ax
    mov ax, di
    mul dx
    pop dx
    add ax, dx
    mov di, ax
    
    mov cx, si      ; Largura
    xor al, al
loop_apaga_x_tam:
    mov es:[di], al
    inc di
    loop loop_apaga_x_tam
    
    pop ax
    inc bx
    pop cx
    loop loop_apaga_y_tam
    
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
apaga_sprite_tamanho endp

; Apagar sprite 8x8
; AX = posição X, BX = posição Y
apaga_sprite proc near
    push ax
    push bx
    push cx
    push dx
    push di
    
    mov cx, 8
loop_apaga_y:
    push cx
    push ax
    
    ; Calcular offset: Y * 320 + X
    mov di, bx
    mov dx, 320
    push ax
    mov ax, di
    mul dx
    pop dx
    add ax, dx
    mov di, ax
    
    mov cx, 8
    xor al, al
loop_apaga_x:
    mov es:[di], al
    inc di
    loop loop_apaga_x
    
    pop ax
    inc bx
    pop cx
    loop loop_apaga_y
    
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
apaga_sprite endp

; Desenhar superfície do planeta
desenhar_superficie proc near
    push ax
    push bx
    push cx
    push di
    push es
    
    mov ax, 0A000h
    mov es, ax
    
    ; Desenhar linha de superfície
    mov bx, superficie_y
    mov cx, 200
    sub cx, bx      ; Linhas até o fim
    
loop_surf:
    push cx
    
    ; Calcular offset da linha
    mov ax, bx
    mov dx, 320
    mul dx
    mov di, ax
    
    ; Desenhar linha toda verde escuro (02h)
    mov cx, 320
    mov al, 02h
    rep stosb
    
    inc bx
    pop cx
    loop loop_surf
    
    pop es
    pop di
    pop cx
    pop bx
    pop ax
    ret
desenhar_superficie endp

; Limpar tela mantendo modo 13h
limpar_tela proc near
    push ax
    push cx
    push di
    push es
    
    mov ax, 0A000h
    mov es, ax
    xor di, di
    mov cx, 64000
    xor al, al
    rep stosb
    
    pop es
    pop di
    pop cx
    pop ax
    ret
limpar_tela endp

; Exibir apresentação de fase
; AL = número da fase (1, 2 ou 3)
exibir_apresentacao proc near
    push ax
    push bx
    push dx
    push si
    
    call limpar_tela
    
    ; Determinar qual fase mostrar
    cmp al, 1
    je apres_fase1
    cmp al, 2
    je apres_fase2
    jmp apres_fase3
    
apres_fase1:
    mov dh, 8
    mov dl, 8
    lea si, fase1_t1
    mov bl, 0Eh     ; Amarelo
    call escreve_texto
    
    inc dh
    mov dl, 8
    lea si, fase1_t2
    call escreve_texto
    
    inc dh
    mov dl, 8
    lea si, fase1_t3
    call escreve_texto
    
    inc dh
    mov dl, 8
    lea si, fase1_t4
    call escreve_texto
    jmp apres_delay
    
apres_fase2:
    mov dh, 8
    mov dl, 7
    lea si, fase2_t1
    mov bl, 0Bh     ; Ciano
    call escreve_texto
    
    inc dh
    mov dl, 7
    lea si, fase2_t2
    call escreve_texto
    
    inc dh
    mov dl, 7
    lea si, fase2_t3
    call escreve_texto
    
    inc dh
    mov dl, 7
    lea si, fase2_t4
    call escreve_texto
    jmp apres_delay
    
apres_fase3:
    mov dh, 8
    mov dl, 7
    lea si, fase3_t1
    mov bl, 0Ch     ; Vermelho
    call escreve_texto
    
    inc dh
    mov dl, 7
    lea si, fase3_t2
    call escreve_texto
    
    inc dh
    mov dl, 7
    lea si, fase3_t3
    call escreve_texto
    
    inc dh
    mov dl, 7
    lea si, fase3_t4
    call escreve_texto
    
apres_delay:
    ; Aguardar TEMPO_APRESENTACAO segundos
    ; Delay simples usando loops aninhados
    mov cx, TEMPO_APRESENTACAO
    
delay_apres_outer:
    push cx
    
    ; Delay de aproximadamente 1 segundo
    mov cx, 0FFFFh
delay_apres_inner:
    push cx
    mov cx, 20
delay_apres_extra:
    loop delay_apres_extra
    pop cx
    loop delay_apres_inner
    
    pop cx
    loop delay_apres_outer
    
fim_apres:
    pop si
    pop dx
    pop bx
    pop ax
    ret
exibir_apresentacao endp

; Desenhar barra de status (simplificada - apenas texto via BIOS)
desenhar_status proc near
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
desenhar_status endp

; Desenhar número de 5 dígitos
; AX = número
desenha_numero_5dig proc near
    push ax
    push bx
    push cx
    push dx
    
    mov bx, 10000
    mov cx, 5
    
loop_dig:
    xor dx, dx
    div bx
    
    add al, '0'
    push ax
    mov ah, 09h
    mov bh, 0
    push cx
    mov cx, 1
    int 10h
    pop cx
    pop ax
    
    push ax
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 03h
    int 10h
    inc dl
    mov ah, 02h
    int 10h
    pop ax
    
    mov ax, dx
    push dx
    mov dx, 0
    pop ax
    
    push ax
    mov ax, bx
    mov bx, 10
    xor dx, dx
    div bx
    mov bx, ax
    pop ax
    
    loop loop_dig
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
desenha_numero_5dig endp

; Desenhar sprite de vida (7x19)
; AX = posição X, DX = posição Y, SI = endereço do sprite
desenha_sprite_vida proc near
    push ax
    push bx
    push cx
    push dx
    push di
    push si
    push es
    
    mov bx, dx      ; BX = Y
    push bx
    mov bx, 0A000h
    mov es, bx
    pop bx
    
    mov cx, 7       ; 7 linhas
loop_vida_y:
    push cx
    push ax
    push si
    
    mov di, bx
    push dx
    mov dx, 320
    push ax
    mov ax, di
    mul dx
    pop dx
    add ax, dx
    mov di, ax
    pop dx
    
    mov cx, 19      ; 19 pixels
loop_vida_x:
    lodsb
    cmp al, 0
    je skip_vida_pixel
    mov es:[di], al
skip_vida_pixel:
    inc di
    loop loop_vida_x
    
    pop si
    add si, 19
    pop ax
    inc bx
    pop cx
    loop loop_vida_y
    
    pop es
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
desenha_sprite_vida endp

; Desenhar letra/número simples 3x5 como pixels
; AX = X, BX = Y, CL = caractere ASCII, CH = cor
desenha_char_pixel proc near
    push ax
    push bx
    push cx
    push dx
    push di
    push si
    push es
    
    mov dx, 0A000h
    mov es, dx
    
    ; Determinar qual padrão desenhar baseado no caractere
    cmp cl, '0'
    jl char_letra
    cmp cl, '9'
    jg char_letra
    
    ; É dígito 0-9
    sub cl, '0'
    jmp desenha_digito
    
char_letra:
    ; Letras simples - vamos fazer um quadrado 3x5 preenchido por simplicidade
    mov si, 5
loop_char_y:
    push si
    push ax
    
    mov di, bx
    mov dx, 320
    push ax
    mov ax, di
    mul dx
    pop dx
    add ax, dx
    mov di, ax
    
    mov al, ch
    mov es:[di], al
    mov es:[di+1], al
    mov es:[di+2], al
    
    pop ax
    inc bx
    pop si
    dec si
    jnz loop_char_y
    jmp fim_char
    
desenha_digito:
    ; Padrões 3x5 para dígitos (simplificados)
    ; CL = dígito (0-9), usaremos padrão fixo
    mov si, 5
loop_dig_y:
    push si
    push ax
    
    mov di, bx
    mov dx, 320
    push ax
    mov ax, di
    mul dx
    pop dx
    add ax, dx
    mov di, ax
    
    ; Desenhar linha do dígito (3 pixels)
    mov al, ch
    mov es:[di], al
    mov es:[di+1], al
    mov es:[di+2], al
    
    pop ax
    inc bx
    pop si
    dec si
    jnz loop_dig_y
    
fim_char:
    pop es
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
desenha_char_pixel endp

; Gerar número pseudo-aleatório
; Retorna AX com valor aleatório
random proc near
    push bx
    push cx
    push dx
    
    mov ax, random_seed
    mov bx, 25173
    mul bx
    add ax, 13849
    mov random_seed, ax
    
    pop dx
    pop cx
    pop bx
    ret
random endp

; Spawnar nova nave alienígena
spawn_alien proc near
    push ax
    push bx
    push cx
    push dx
    
    ; Procurar slot livre
    mov cx, MAX_ALIENS
    xor bx, bx
    
procura_slot_alien:
    cmp byte ptr aliens_ativo[bx], 0
    je slot_alien_livre
    inc bx
    loop procura_slot_alien
    jmp fim_spawn_alien
    
slot_alien_livre:
    ; Ativar alien
    mov byte ptr aliens_ativo[bx], 1
    
    ; Posição X: começa na direita (320)
    shl bx, 1
    mov aliens_x[bx], 320
    
    ; Posição Y: aleatória entre Y=10 (após status) e Y=150 (antes da superfície)
    call random
    xor dx, dx
    mov cx, 140     ; Range de 140 pixels (150 - 10)
    div cx
    add dx, 10      ; Adiciona offset mínimo
    mov aliens_y[bx], dx
    shr bx, 1
    
fim_spawn_alien:
    pop dx
    pop cx
    pop bx
    pop ax
    ret
spawn_alien endp

; Mover naves alienígenas
move_aliens proc near
    push ax
    push bx
    push cx
    
    mov cx, MAX_ALIENS
    xor bx, bx
    
loop_move_aliens:
    cmp byte ptr aliens_ativo[bx], 0
    je prox_alien
    
    ; Mover alien para esquerda
    push bx
    shl bx, 1
    mov ax, aliens_x[bx]
    sub ax, 2       ; Velocidade: 2 pixels por frame
    
    ; Desativar se saiu da tela (X < -16, considerando tamanho do sprite)
    cmp ax, 0FFF0h  ; Verifica se ficou muito negativo (< -16 em word sem sinal)
    jae desativa_alien  ; Se AX >= FFF0h (muito grande em unsigned = negativo em signed)
    
    mov aliens_x[bx], ax
    shr bx, 1
    jmp prox_alien
    
desativa_alien:
    shr bx, 1
    mov byte ptr aliens_ativo[bx], 0
    
prox_alien:
    inc bx
    loop loop_move_aliens
    
    pop cx
    pop bx
    pop ax
    ret
move_aliens endp

; Desenhar naves alienígenas
desenha_aliens proc near
    push ax
    push bx
    push cx
    push dx
    push si
    
    mov cx, MAX_ALIENS
    xor bx, bx
    
loop_des_aliens:
    cmp byte ptr aliens_ativo[bx], 0
    je prox_des_alien
    
    ; Carregar posição do alien
    push bx
    push cx
    shl bx, 1
    mov ax, aliens_x[bx]
    mov dx, aliens_y[bx]
    
    ; Verificar limites da tela (X entre 0 e 304, Y entre 10 e 184)
    cmp ax, 0
    jl pula_desenho_alien
    cmp ax, 304         ; 320 - 16 (tamanho sprite)
    jg pula_desenho_alien
    cmp dx, 10
    jl pula_desenho_alien
    cmp dx, 184         ; 200 - 16 (tamanho sprite)
    jg pula_desenho_alien
    
    ; Desenhar alien (sprite duplicado 2x = 16x16)
    mov bx, dx          ; BX = Y
    lea si, sprite_alien
    call desenha_sprite_2x
    
pula_desenho_alien:
    pop cx
    pop bx
    
prox_des_alien:
    inc bx
    loop loop_des_aliens
    
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
desenha_aliens endp

; Loop principal de uma fase
; Retorna AL = 0 se tempo esgotou, 1 se passou de fase
executar_fase proc near   

    push bx
    push cx
    push dx
    
    ; Limpar tela completamente
    call limpar_tela
    
    ; Esconder cursor
    mov ah, 01h
    mov ch, 20h
    mov cl, 00h
    int 10h
    
    ; Resetar tempo
    mov al, TEMPO_FASE
    mov tempo_restante, al
    mov ticks_contador, 0
    
loop_fase:
    ; Limpar apenas área de jogo (não redesenhar tudo)
    push es
    push di
    push ax
    push cx
    
    mov ax, 0A000h
    mov es, ax
    
    ; Limpar área de jogo (de Y=10 até Y=169 antes da superfície)
    mov di, 3200    ; Y=10 * 320
    mov cx, 50880   ; 159 linhas * 320 pixels (de Y=10 até Y=168)
    xor al, al
    rep stosb
    
    pop cx
    pop ax
    pop di
    pop es
    
    ; Redesenhar superfície
    call desenhar_superficie
    
    ; Desenhar nave do jogador usando o sprite 29x13
    mov ax, nave_jogador_x
    mov bx, nave_jogador_y
    lea si, sprite_nave
    call desenha_sprite_29x13
    
    ; Desenhar sprites de vidas no centro (entre score e time)
    ; Primeira vida
    mov ax, 120
    mov bx, 1
    lea si, sprite_nave_8x8
    call desenha_sprite
    
    ; Segunda vida
    mov ax, 130
    mov bx, 1
    lea si, sprite_nave_8x8
    call desenha_sprite
    
    ; Terceira vida
    mov ax, 140
    mov bx, 1
    lea si, sprite_nave_8x8
    call desenha_sprite
    
    ; Desenhar score e tempo como texto no topo
    push ax
    push bx
    push dx
    
    mov dh, 0
    mov dl, 0
    mov ah, 02h
    mov bh, 0
    int 10h
    
    ; Mostrar SCORE
    mov si, offset status_tempo
    mov byte ptr [si], 'S'
    mov byte ptr [si+1], 'C'
    mov byte ptr [si+2], 'O'
    mov byte ptr [si+3], 'R'
    mov byte ptr [si+4], 'E'
    mov byte ptr [si+5], ':'
    mov byte ptr [si+6], 0
    mov bl, 0Eh
    call escreve_texto
    
    ; Mostrar valor do score (4 dígitos: milhares, centenas, dezenas, unidades)
    mov ax, score
    
    ; Calcular milhares
    xor dx, dx
    mov bx, 1000
    div bx
    add al, '0'
    push dx
    mov dh, 0
    mov dl, 6
    mov ah, 02h
    int 10h
    mov ah, 09h
    mov bh, 0
    mov bl, 0Ah
    mov cx, 1
    int 10h
    pop ax
    
    ; Calcular centenas
    xor dx, dx
    mov bx, 100
    div bx
    push dx
    add al, '0'
    push ax
    mov dh, 0
    mov dl, 7
    mov ah, 02h
    int 10h
    pop ax
    mov ah, 09h
    mov bh, 0
    mov bl, 0Ah
    mov cx, 1
    int 10h
    pop ax
    
    ; Calcular dezenas
    xor dx, dx
    mov bx, 10
    div bx
    
    push dx
    add al, '0'
    push ax
    mov dh, 0
    mov dl, 8
    mov ah, 02h
    int 10h
    pop ax
    mov ah, 09h
    mov bh, 0
    mov bl, 0Ah
    mov cx, 1
    int 10h
    pop dx
    
    ; Calcular unidades
    mov al, dl
    add al, '0'
    
    push ax
    mov dh, 0
    mov dl, 9
    mov ah, 02h
    int 10h
    pop ax
    
    mov ah, 09h
    mov bh, 0
    mov bl, 0Ah
    mov cx, 1
    int 10h
    
    ; Mostrar TEMPO à direita
    mov dh, 0
    mov dl, 33
    mov ah, 02h
    int 10h
    
    mov si, offset status_tempo
    mov byte ptr [si], 'T'
    mov byte ptr [si+1], 'I'
    mov byte ptr [si+2], 'M'
    mov byte ptr [si+3], 'E'
    mov byte ptr [si+4], ':'
    mov byte ptr [si+5], 0
    mov bl, 0Eh
    call escreve_texto
    
    ; Mostrar valor do tempo (2 dígitos nas colunas 38 e 39)
    mov al, tempo_restante
    xor ah, ah
    xor dx, dx
    mov bl, 10
    div bl
    
    ; Guardar o resultado da divisão em registradores seguros
    push ax         ; Salvar AX (AL=dezenas, AH=unidades)
    
    ; Dezenas (coluna 38)
    pop ax          ; Recuperar resultado (AL=dezenas, AH=unidades)
    push ax         ; Guardar novamente
    add al, '0'
    mov dh, 0
    mov dl, 38
    push ax
    mov ah, 02h
    int 10h
    pop ax
    mov ah, 09h
    mov bh, 0
    mov bl, 0Eh
    mov cx, 1
    int 10h
    
    ; Unidades (coluna 39)
    pop ax          ; Recuperar resultado novamente
    mov al, ah      ; AL = unidades
    add al, '0'
    mov dh, 0
    mov dl, 39
    push ax
    mov ah, 02h
    int 10h
    pop ax
    mov ah, 09h
    mov bh, 0
    mov bl, 0Eh
    mov cx, 1
    int 10h
    
    pop dx
    pop bx
    pop ax
    
    ; Pequeno delay
    mov cx, 2000h
delay_fase:
    loop delay_fase
    
    ; Atualizar contador de tempo
    inc ticks_contador
    mov ax, ticks_contador
    cmp ax, 18
    jl check_tecla_fase
    
    ; 1 segundo passou - adicionar 10 pontos e decrementar tempo
    mov ticks_contador, 0
    add score, 10
    dec tempo_restante
    
    ; Verificar se tempo acabou
    cmp tempo_restante, 0
    jne check_tecla_fase
    jmp fim_tempo_fase
    
check_tecla_fase:
    ; Verificar tecla (ESC para voltar ao menu)
    mov ah, 1
    int 16h
    jz check_volta_loop
    jmp check_continua
    
check_volta_loop:
    jmp loop_fase
    
check_continua:
    mov ah, 0
    int 16h
    
    cmp al, 27      ; ESC
    jne nao_esc
    jmp voltar_menu
nao_esc:
    
    ; Controles do jogador
    cmp ah, 48h     ; Seta cima
    je nave_cima
    cmp ah, 50h     ; Seta baixo
    je nave_baixo
    cmp ah, 4Bh     ; Seta esquerda
    je nave_esq
    cmp ah, 4Dh     ; Seta direita
    je nave_dir
    
    jmp loop_fase
    
nave_cima:
    mov ax, nave_jogador_y
    sub ax, 3
    cmp ax, 10      ; Limite superior (após status)
    jge cima_ok
    jmp loop_fase
cima_ok:
    mov nave_jogador_y, ax
    jmp loop_fase
    
nave_baixo:
    mov ax, nave_jogador_y
    add ax, 3
    mov bx, superficie_y
    sub bx, 13      ; Limite antes da superfície (altura da nave = 13)
    cmp ax, bx
    jle baixo_ok
    jmp loop_fase
baixo_ok:
    mov nave_jogador_y, ax
    jmp loop_fase
    
nave_esq:
    mov ax, nave_jogador_x
    sub ax, 3
    cmp ax, 0
    jge esq_ok
    jmp loop_fase
esq_ok:
    mov nave_jogador_x, ax
    jmp loop_fase
    
nave_dir:
    mov ax, nave_jogador_x
    add ax, 3
    cmp ax, 291         ; 320 - 29 = 291 (limite direito)
    jle dir_ok
    jmp loop_fase
dir_ok:
    mov nave_jogador_x, ax
    jmp loop_fase
    
fim_tempo_fase:
    ; Próxima fase
    inc fase_atual
    cmp fase_atual, 4
    jge fim_jogo
    
    ; Exibir apresentação da próxima fase
    mov al, fase_atual
    call exibir_apresentacao
    
    pop dx
    pop cx
    pop bx
    jmp executar_fase
    
voltar_menu:
    xor al, al
    pop dx
    pop cx
    pop bx
    ret
    
fim_jogo:
    ; TODO: tela de vitória
    xor al, al
    pop dx
    pop cx
    pop bx
    ret
executar_fase endp

; Criar novo tiro
criar_tiro proc near
    push ax
    push bx
    push cx
    
    mov cx, MAX_TIROS
    xor bx, bx
    
procura_slot:
    cmp byte ptr tiros_ativo[bx], 0
    je slot_livre
    inc bx
    loop procura_slot
    jmp fim_criar_tiro
    
slot_livre:
    ; Ativar tiro na posição da nave
    mov byte ptr tiros_ativo[bx], 1
    mov ax, nave_jogador_x
    add ax, 29      ; Frente da nave (largura = 29)
    shl bx, 1       ; bx*2 para índice word
    mov tiros_x[bx], ax
    mov ax, nave_jogador_y
    add ax, 6       ; Centro vertical (altura/2 = 13/2 ≈ 6)
    mov tiros_y[bx], ax
    
fim_criar_tiro:
    pop cx
    pop bx
    pop ax
    ret
criar_tiro endp

; Mover tiros
move_tiros proc near
    push ax
    push bx
    push cx
    
    mov cx, MAX_TIROS
    xor bx, bx
    
loop_move_tiros:
    cmp byte ptr tiros_ativo[bx], 0
    je prox_tiro
    
    ; Mover tiro para direita
    push bx
    shl bx, 1
    mov ax, tiros_x[bx]
    add ax, 5
    cmp ax, 320
    jge desativa_tiro
    mov tiros_x[bx], ax
    shr bx, 1
    jmp prox_tiro
    
desativa_tiro:
    shr bx, 1
    mov byte ptr tiros_ativo[bx], 0
    
prox_tiro:
    inc bx
    loop loop_move_tiros
    
    pop cx
    pop bx
    pop ax
    ret
move_tiros endp

; Desenhar tiros
desenha_tiros proc near
    push ax
    push bx
    push cx
    push di
    push es
    
    mov dx, 0A000h
    mov es, dx
    
    mov cx, MAX_TIROS
    xor bx, bx
    
loop_des_tiros:
    cmp byte ptr tiros_ativo[bx], 0
    je prox_des_tiro
    
    ; Desenhar tiro (2x2 pixels amarelos)
    push bx
    shl bx, 1
    mov ax, tiros_y[bx]
    mov dx, 320
    mul dx
    add ax, tiros_x[bx]
    mov di, ax
    
    mov al, 0Eh     ; Amarelo
    mov es:[di], al
    mov es:[di+1], al
    mov es:[di+320], al
    mov es:[di+321], al
    
    shr bx, 1
    
prox_des_tiro:
    inc bx
    loop loop_des_tiros
    
    pop es
    pop di
    pop cx
    pop bx
    pop ax
    ret
desenha_tiros endp

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
    ; sair - fecha direto
    mov ah, 0
    mov al, 3
    int 10h
    mov ah, 4Ch
    int 21h
    
iniciar_jogo:
    ; Reinicializar modo de vídeo 13h
    mov ah, 0
    mov al, 13h
    int 10h
    
    ; Limpar tela completamente
    call limpar_tela
    
    ; Resetar fase e jogo
    mov fase_atual, 1
    mov score, 0
    mov vidas, 3
    mov nave_jogador_x, 40
    mov nave_jogador_y, 80
    
    ; Limpar tiros
    mov cx, MAX_TIROS
    xor bx, bx
limpar_tiros_loop:
    mov byte ptr tiros_ativo[bx], 0
    inc bx
    loop limpar_tiros_loop
    
    ; Exibir apresentação da Fase 1
    mov al, 1
    call exibir_apresentacao
    
    ; Executar fase
    call executar_fase
    
    ; Voltar ao menu
    jmp reiniciar_menu
    
reiniciar_menu:
    ; Reinicializar modo de vídeo
    mov ah, 0
    mov al, 13h
    int 10h
    
    ; Limpar tela e redesenhar menu
    call limpar_tela
    
    ; Mostrar cursor novamente
    mov ah, 01h
    mov ch, 06h
    mov cl, 07h
    int 10h
    
    ; Desenhar título em verde-claro (0Ah)
    mov dh, 1
    mov dl, 0
    lea si, titulo
    mov bl, 0Ah
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
    
    call desenha_menu
    jmp loop_principal
main endp

end main
