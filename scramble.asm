.model small
.stack 100h

.data
    ; Constantes de tempo
    TEMPO_APRESENTACAO equ 4    ; segundos
    TEMPO_FASE equ 60           ; segundos por fase
    
    ; Título do menu
    titulo db ' ___  ___ ___  _   _   _ ___ _    ___', 0
    linha2 db '/ __|/ __| _ \/_\ | \ / | _ ) |  | __|', 0
    linha3 db '\__ \ (__|   / _ \|  .  | _ \ |__| _|', 0
    linha4 db '|___/\___|_|_\_/\_|_/ \_|___/____|___|', 0
    
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
    
    ; ASCII art para Vencedor (formato scrambleBase)
    vencedor_msg    db 2 dup(" "),"                                    ",13,10
                    db 2 dup(" ")," __   __                  _         ",13,10
                    db 2 dup(" ")," \ \ / /__ _ _  __ ___ __| |___ _ _ ",13,10
                    db 2 dup(" "),"  \ V / -_) ' \/ _/ -_) _` / _ \ '_|",13,10
                    db 2 dup(" "),"   \_/\___|_||_\__\___\__,_\___/_|  ",13,10
                    db 2 dup(" "),"                                    ",13,10
    vencedor_msg_length equ $-vencedor_msg
    
    ; Mensagem de score final
    final_score_msg db "SCORE FINAL: ",0
    final_score_msg_length equ $-final_score_msg
    
    ; Mensagem para pressionar tecla
    press_key_msg db "Pressione qualquer tecla",13,10,0
    press_key_msg_length equ $-press_key_msg
    
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
    
    ; Sprite alien pequeno (8x8 pixels) - para menu
    sprite_alien_8x8 db 00h,00h,0Dh,0Dh,0Dh,00h,00h,00h
                     db 00h,0Dh,05h,0Dh,05h,0Dh,00h,00h
                     db 0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,00h
                     db 0Dh,05h,0Dh,0Dh,0Dh,05h,0Dh,00h
                     db 0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,00h
                     db 00h,0Dh,00h,00h,00h,0Dh,00h,00h
                     db 00h,0Dh,00h,00h,00h,0Dh,00h,00h
                     db 00h,00h,00h,00h,00h,00h,00h,00h
    
    ; Sprite alien (29x13 pixels) - estilo Scramble
    sprite_alien db 00h,00h,00h,00h,00h,00h,00h,00h,0Dh,0Dh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
                 db 00h,00h,00h,00h,00h,00h,00h,0Dh,0Dh,0Dh,0Dh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
                 db 00h,00h,00h,00h,00h,00h,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
                 db 00h,00h,00h,00h,00h,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
                 db 00h,00h,00h,00h,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
                 db 0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,00h
                 db 0Dh,05h,05h,05h,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,00h
                 db 0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,00h
                 db 00h,00h,00h,00h,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
                 db 00h,00h,00h,00h,00h,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
                 db 00h,00h,00h,00h,00h,00h,0Dh,0Dh,0Dh,0Dh,0Dh,0Dh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
                 db 00h,00h,00h,00h,00h,00h,00h,0Dh,0Dh,0Dh,0Dh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
                 db 00h,00h,00h,00h,00h,00h,00h,00h,0Dh,0Dh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
    
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
    score_buffer db '00000'
    score_buffer_len equ $-score_buffer
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
    
    ; Naves alienígenas (fase 1) e meteoros (fase 2) - usa mesmo sistema
    MAX_ALIENS equ 5
    alien_array_pos dw MAX_ALIENS dup(0)     ; Posição linear (y*320 + x)
    alien_array_active db MAX_ALIENS dup(0)  ; Status (0=inativo, 1=ativo)
    alien_spawn_timer dw 0                   ; Timer para spawn
    alien_spawn_delay dw 60                  ; Frames entre spawns fase 1 (~3 segundos)
    alien_move_speed dw 1                    ; Velocidade fase 1 (1 pixel por frame)
    meteor_move_speed dw 2                   ; Velocidade fase 2 (2 pixels por frame)
    meteor_spawn_delay dw 45                 ; Frames entre spawns fase 2 (~2.5 segundos)
    random_seed dw 0

.code
; PRINT_STRING usando BIOS int 13h (como scrambleBase)
; Entrada: BP = offset string, CX = length, BL = color, DH = row, DL = col, ES = segment
PRINT_STRING proc near
    push ax
    push bx
    push bp
    
    mov ah, 13h     ; BIOS Write String
    mov al, 1       ; Update cursor
    xor bh, bh      ; Page 0
    int 10h
    
    pop bp
    pop bx
    pop ax
    ret
PRINT_STRING endp

; escreve_texto - wrapper for compatibility
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
    lea si, sprite_alien_8x8
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
    push dx
    push di
    push es
    
    mov ax, 0A000h
    mov es, ax
    
    ; Escolher cor baseada na fase
    mov al, fase_atual
    cmp al, 1
    je cor_fase1
    cmp al, 2
    je cor_fase2
    cmp al, 3
    je cor_fase3
    jmp cor_fase1       ; Padrão: fase 1
    
cor_fase1:
    mov dl, 02h         ; Verde escuro
    jmp desenha_surf
cor_fase2:
    mov dl, 05h         ; Roxo/Magenta escuro
    jmp desenha_surf
cor_fase3:
    mov dl, 04h         ; Vermelho escuro
    
desenha_surf:
    ; Desenhar linha de superfície
    mov bx, superficie_y
    mov cx, 200
    sub cx, bx      ; Linhas até o fim
    
loop_surf:
    push cx
    
    ; Calcular offset da linha
    mov ax, bx
    push dx
    mov dx, 320
    mul dx
    mov di, ax
    pop dx
    
    ; Desenhar linha toda com a cor da fase
    mov cx, 320
    mov al, dl      ; Usa a cor escolhida
    rep stosb
    
    inc bx
    pop cx
    loop loop_surf
    
    pop es
    pop di
    pop dx
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
; Retorna AX com valor aleatório (0-65535)
random proc near
    push bx
    push dx
    
    mov ax, random_seed
    mov bx, 25173
    mul bx              ; DX:AX = random_seed * 25173
    add ax, 13849
    mov random_seed, ax
    
    pop dx
    pop bx
    ret
random endp

; Spawnar nova nave alienígena (padrão scrambleBase)
spawn_alien proc near
    push ax
    push bx
    push cx
    push dx
    
    ; Procurar slot livre nos 5 aliens
    mov cx, MAX_ALIENS
    xor bx, bx
    
procura_slot_alien:
    cmp byte ptr alien_array_active[bx], 0
    je slot_alien_livre
    inc bx
    loop procura_slot_alien
    jmp fim_spawn_alien
    
slot_alien_livre:
    ; BX contém o índice do slot livre (0-4)
    push bx
    
    ; Gera Y aleatório entre 20-130 (área segura abaixo do HUD)
    call random
    xor dx, dx
    mov cx, 110         ; Divisor (130-20=110)
    div cx              ; DX = resto (0-109)
    mov ax, dx
    add ax, 20          ; Y entre 20-129
    
    ; Calcula posição linear: Y*320 + X
    ; X = 298 (320-22=298, garante sprite visível no lado direito)
    mov cx, 320
    mul cx              ; AX = Y * 320
    add ax, 298         ; Adiciona X=298
    
    ; Ativa alien no slot
    pop bx
    mov byte ptr alien_array_active[bx], 1
    shl bx, 1           ; BX *= 2 para word array
    mov word ptr alien_array_pos[bx], ax
    
fim_spawn_alien:
    pop dx
    pop cx
    pop bx
    pop ax
    ret
spawn_alien endp

; Mover naves alienígenas (padrão scrambleBase)
move_aliens proc near
    push ax
    push bx
    push cx
    push dx
    
    mov cx, MAX_ALIENS
    xor bx, bx
    
loop_move_aliens:
    cmp byte ptr alien_array_active[bx], 0
    je prox_alien
    
    ; Pega posição do alien (BX * 2 para word array)
    push bx
    shl bx, 1
    mov ax, word ptr alien_array_pos[bx]
    pop bx
    
    ; Converte posição linear para X,Y
    push ax
    push bx
    xor dx, dx
    mov bx, 320
    div bx              ; AX = Y, DX = X
    pop bx
    
    ; Verifica se X < 2 (saiu da tela à esquerda)
    cmp dx, 2
    pop ax              ; Recupera posição original
    jb desativa_alien
    
    ; Move para esquerda (velocidade baseada na fase)
    push bx
    mov bx, alien_move_speed         ; Padrão: fase 1 (1 pixel)
    cmp fase_atual, 2
    jne aplica_velocidade
    mov bx, meteor_move_speed        ; Fase 2: 2 pixels (meteoros mais rápidos)
    
aplica_velocidade:
    sub ax, bx
    pop bx
    
    ; Salva nova posição
    push bx
    shl bx, 1
    mov word ptr alien_array_pos[bx], ax
    pop bx
    jmp prox_alien
    
desativa_alien:
    mov byte ptr alien_array_active[bx], 0
    
prox_alien:
    inc bx
    loop loop_move_aliens
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
move_aliens endp

; Atualizar sistema de aliens/meteoros (movimento + spawn automático)
update_aliens_system proc near
    push ax
    push bx
    push dx
    
    ; Incrementa timer de spawn
    inc alien_spawn_timer
    
    ; Escolhe delay baseado na fase
    mov ax, alien_spawn_timer
    mov dx, alien_spawn_delay        ; Padrão: fase 1 (60 frames)
    cmp fase_atual, 2
    jne verifica_spawn
    mov dx, meteor_spawn_delay       ; Fase 2: 45 frames (~2.5 seg)
    
verifica_spawn:
    cmp ax, dx
    jb update_aliens_movimento
    
    ; Reset timer e spawna novo alien/meteoro
    mov alien_spawn_timer, 0
    call spawn_alien
    
update_aliens_movimento:
    ; Move aliens/meteoros existentes
    call move_aliens
    
    pop dx
    pop bx
    pop ax
    ret
update_aliens_system endp

; Desenhar naves alienígenas (padrão scrambleBase)
desenha_aliens proc near
    push ax
    push bx
    push cx
    push dx
    push si
    
    mov cx, MAX_ALIENS
    xor bx, bx
    
loop_des_aliens:
    cmp byte ptr alien_array_active[bx], 0
    je prox_des_alien
    
    ; Pega posição linear do alien
    push bx
    push cx
    shl bx, 1
    mov ax, word ptr alien_array_pos[bx]
    shr bx, 1
    
    ; Converte posição linear para X,Y
    push bx
    xor dx, dx
    mov bx, 320
    div bx              ; AX = Y, DX = X
    pop bx
    
    ; Verifica limites da tela
    ; X deve estar entre 0 e 291 (para aliens 29px) ou 0-312 (para meteoros 8px)
    cmp dx, 0
    jl pula_desenho_alien
    cmp fase_atual, 2
    je verifica_limite_meteoro
    cmp dx, 291         ; Aliens: 320 - 29
    jg pula_desenho_alien
    jmp verifica_y
verifica_limite_meteoro:
    cmp dx, 312         ; Meteoros: 320 - 8
    jg pula_desenho_alien
    
verifica_y:
    ; Y deve estar entre 10 e 157 (para aliens 13px) ou 10-192 (para meteoros 8px)
    cmp ax, 10
    jl pula_desenho_alien
    cmp fase_atual, 2
    je verifica_y_meteoro
    cmp ax, 157         ; Aliens: 170 - 13
    jg pula_desenho_alien
    jmp converte_posicao
verifica_y_meteoro:
    cmp ax, 192         ; Meteoros: 200 - 8
    jg pula_desenho_alien
    
converte_posicao:
    ; Converte Y,X para posição linear para desenho
    push dx             ; Salva X
    mov dx, 320
    mul dx              ; AX = Y * 320
    pop dx              ; Recupera X
    add ax, dx          ; AX = Y*320 + X (posição linear)
    
    ; Desenha alien (sprite 29x13)
    mov bx, ax          ; BX recebe Y para desenha_sprite_29x13
    ; Mas desenha_sprite_29x13 espera AX=X, BX=Y separados
    ; Vamos reconverter
    xor dx, dx
    mov cx, 320
    div cx              ; AX = Y, DX = X
    mov bx, ax          ; BX = Y
    mov ax, dx          ; AX = X
    
    ; Escolhe sprite baseado na fase
    cmp fase_atual, 2
    je desenha_meteoro_fase2
    
    ; Fases 1 e 3: desenha alien (sprite 29x13)
    lea si, sprite_alien
    call desenha_sprite_29x13
    jmp pula_desenho_alien
    
desenha_meteoro_fase2:
    ; Fase 2: desenha meteoro (sprite 8x8)
    lea si, sprite_meteoro
    call desenha_sprite
    
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

; Checa colisao simples entre o jogador e aliens/meteoros
; Retorna AX = 1 se houve colisao, 0 caso contrario
checa_colisao_jogador proc near
    push bx
    push cx
    push dx
    push si
    push di
    push bp

    ; Largura/altura dos inimigos de acordo com a fase
    mov bp, 29              ; Largura padrao (aliens)
    mov dx, 13              ; Altura padrao (aliens)
    cmp fase_atual, 2
    jne dimensao_ok
    mov bp, 8               ; Meteoro 8x8 na fase 2
    mov dx, 8
dimensao_ok:
    mov di, dx              ; Guardar altura do inimigo

    mov cx, MAX_ALIENS
    xor si, si              ; SI = indice
    xor ax, ax              ; AX = flag de colisao (0)

loop_colisao:
    cmp byte ptr alien_array_active[si], 0
    je proximo_inimigo

    ; Pega posicao linear e converte para X,Y
    push si
    shl si, 1
    mov ax, word ptr alien_array_pos[si]
    shr si, 1
    xor dx, dx
    mov bx, 320
    div bx                  ; AX = inimigo_y, DX = inimigo_x
    mov bx, dx              ; BX = inimigo_x
    mov dx, ax              ; DX = inimigo_y
    pop si

    ; Teste de interseccao AABB (player 29x13)
    ; Verifica eixo X
    mov ax, bx              ; inimigo_x
    add ax, bp              ; inimigo_x + largura
    cmp nave_jogador_x, ax
    jge proximo_inimigo

    mov ax, nave_jogador_x
    add ax, 29              ; player_x + largura
    cmp bx, ax
    jge proximo_inimigo

    ; Verifica eixo Y
    mov ax, dx              ; inimigo_y
    add ax, di              ; inimigo_y + altura
    mov si, nave_jogador_y
    cmp si, ax
    jge proximo_inimigo

    mov ax, nave_jogador_y
    add ax, 13              ; player_y + altura
    cmp dx, ax              ; dx = inimigo_y
    jge proximo_inimigo

    ; Colisao detectada
    cmp byte ptr vidas, 0
    je salva_estado
    dec vidas
salva_estado:
    mov byte ptr alien_array_active[si], 0
    mov nave_jogador_x, 40
    mov nave_jogador_y, 80
    mov ax, 1               ; flag de colisao
    jmp fim_colisao

proximo_inimigo:
    inc si
    loop loop_colisao
    xor ax, ax              ; Nenhuma colisao

fim_colisao:
    pop bp
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    ret
checa_colisao_jogador endp

; Exibir tela de vitória (formato scrambleBase)
exibir_vitoria proc near
    push ax
    push bx
    push cx
    push dx
    push si
    push es
    push bp
    
    call limpar_tela
    
    ; Aguardar um pouco
    xor cx, cx
    mov dx, 2710H
    mov ah, 86H
    int 15h
    
    ; Configura ES para apontar para o segmento de dados
    mov ax, ds 
    mov es, ax
    
    ; Exibe mensagem Vencedor em verde (linha 5)
    mov bp, offset vencedor_msg
    mov cx, vencedor_msg_length
    mov bl, 0Ah     ; Verde claro
    mov dh, 5       ; Linha 5
    mov dl, 0       ; Coluna 0
    call PRINT_STRING
    
    ; Exibe "SCORE FINAL:" em branco (linha 12, coluna 10)
    mov bp, offset final_score_msg
    mov cx, final_score_msg_length
    mov bl, 0Fh     ; Branco
    mov dh, 12
    mov dl, 10
    call PRINT_STRING
    
    ; Converte score para string
    mov ax, score
    mov si, offset score_buffer + 4  ; Final do buffer
    mov cx, 5                        ; 5 dígitos
    call converte_numero_5dig
    
    ; Exibe score em amarelo (linha 12, coluna 23 após "SCORE FINAL: ")
    mov bp, offset score_buffer
    mov cx, 5
    mov bl, 0Eh     ; Amarelo
    mov dh, 12
    mov dl, 23
    call PRINT_STRING
    
    ; Exibe mensagem para pressionar tecla (linha 18)
    mov bp, offset press_key_msg
    mov cx, press_key_msg_length
    mov bl, 0Fh     ; Branco
    mov dh, 18
    mov dl, 5
    call PRINT_STRING
    
    ; Aguarda tecla (dupla leitura para limpar buffer)
    xor ah, ah
    int 16h
    xor ah, ah
    int 16h
    
    call limpar_tela
    
    pop bp
    pop es
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
exibir_vitoria endp

; Converte número de 5 dígitos para string
; AX = número, SI = final do buffer, CX = quantidade de dígitos
converte_numero_5dig proc near
    push ax
    push bx
    push dx
    
loop_conv:
    xor dx, dx
    mov bx, 10
    div bx          ; AX = AX/10, DX = resto
    add dl, '0'     ; Converte para ASCII
    mov [si], dl    ; Armazena no buffer
    dec si
    loop loop_conv
    
    pop dx
    pop bx
    pop ax
    ret
converte_numero_5dig endp

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
    
    ; Inicializar sistema de aliens
    mov cx, MAX_ALIENS
    xor bx, bx
limpar_aliens_init:
    mov byte ptr alien_array_active[bx], 0
    shl bx, 1
    mov word ptr alien_array_pos[bx], 0
    shr bx, 1
    inc bx
    loop limpar_aliens_init
    
    ; Inicializar seed aleatório
    mov ah, 00h
    int 1Ah
    mov random_seed, dx
    
    ; Reset timer de spawn
    mov alien_spawn_timer, 0
    
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
    
    ; Desenhar aliens
    call desenha_aliens
    
    ; Desenhar sprites de vidas no centro (entre score e time)
    mov cl, vidas
    cmp cl, 0
    jle vidas_fim
    mov ax, 120            ; X inicial
    mov bx, 1              ; Y fixo
    lea si, sprite_nave_8x8
desenha_vidas_loop:
    call desenha_sprite
    add ax, 10             ; Espaçamento entre ícones
    dec cl
    jg desenha_vidas_loop
vidas_fim:
    
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
    
    ; Atualizar sistema de aliens (movimento + spawn automático)
    call update_aliens_system

    ; Checar colisao entre nave e inimigos
    call checa_colisao_jogador
    cmp ax, 0
    je sem_colisao_jogador
    cmp byte ptr vidas, 0
    ja sem_colisao_jogador
    jmp voltar_menu
sem_colisao_jogador:
    
    ; Atualizar contador de tempo
    inc ticks_contador
    mov ax, ticks_contador
    cmp ax, 18
    jl check_tecla_fase
    
    ; 1 segundo passou - adicionar pontos baseado na fase e decrementar tempo
    mov ticks_contador, 0
    
    ; Escolhe pontuação baseada na fase
    mov al, fase_atual
    cmp al, 1
    je pontos_fase1
    cmp al, 2
    je pontos_fase2
    cmp al, 3
    je pontos_fase3
    jmp pontos_fase1    ; Padrão: fase 1
    
pontos_fase1:
    add score, 10       ; Fase 1: +10 pontos/segundo
    jmp atualiza_tempo
pontos_fase2:
    add score, 15       ; Fase 2: +15 pontos/segundo
    jmp atualiza_tempo
pontos_fase3:
    add score, 20       ; Fase 3: +20 pontos/segundo
    
atualiza_tempo:
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
    ; Exibir tela de vitória
    call exibir_vitoria
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
