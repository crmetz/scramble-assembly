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
    
    ; Sprite nave (8x8 pixels)
    sprite_nave db 00h,00h,0Bh,0Bh,00h,00h,00h,00h
                db 00h,0Bh,0Eh,0Eh,0Bh,00h,00h,00h
                db 0Bh,0Eh,0Eh,0Eh,0Eh,0Bh,00h,00h
                db 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh
                db 0Bh,0Eh,0Eh,0Eh,0Eh,0Bh,00h,00h
                db 00h,0Bh,0Eh,0Eh,0Bh,00h,00h,00h
                db 00h,00h,0Bh,0Bh,00h,00h,00h,00h
                db 00h,00h,00h,00h,00h,00h,00h,00h
    
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
    nave_jogador_y dw 100
    
    ; Tiros
    MAX_TIROS equ 5
    tiros_x dw MAX_TIROS dup(0)
    tiros_y dw MAX_TIROS dup(0)
    tiros_ativo db MAX_TIROS dup(0)
    
    ; Superfície do planeta (altura Y onde começa)
    superficie_y dw 170

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
    
    ; Desenhar nave
    mov ax, nave_x
    mov bx, 60
    lea si, sprite_nave
    call desenha_sprite
    
    ; Desenhar meteoro
    mov ax, meteoro_x
    mov bx, 80
    lea si, sprite_meteoro
    call desenha_sprite
    
    ; Desenhar alien
    mov ax, alien_x
    mov bx, 100
    lea si, sprite_alien
    call desenha_sprite
    
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
desenha_elementos endp

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
loop_x:
    lodsb
    cmp al, 0
    je skip_pixel
    mov es:[di], al
skip_pixel:
    inc di
    loop loop_x
    
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
    
    ; Apagar nave
    mov ax, nave_x
    mov bx, 60
    call apaga_sprite
    
    ; Apagar meteoro
    mov ax, meteoro_x
    mov bx, 80
    call apaga_sprite
    
    ; Apagar alien
    mov ax, alien_x
    mov bx, 100
    call apaga_sprite
    
    pop es
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
apaga_elementos endp

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

; Desenhar barra de status
desenhar_status proc near
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    
    ; SCORE: à esquerda
    mov dh, 0
    mov dl, 0
    mov ah, 02h
    mov bh, 0
    int 10h
    
    ; Escrever "SCORE: "
    mov si, offset status_tempo
    mov byte ptr [si], 'S'
    mov byte ptr [si+1], 'C'
    mov byte ptr [si+2], 'O'
    mov byte ptr [si+3], 'R'
    mov byte ptr [si+4], 'E'
    mov byte ptr [si+5], ':'
    mov byte ptr [si+6], ' '
    mov byte ptr [si+7], 0
    mov bl, 0Ah     ; Verde
    call escreve_texto
    
    ; Desenhar score (5 dígitos)
    mov ax, score
    call desenha_numero_5dig
    
    ; VIDAS: no centro (naves)
    mov cx, 3
    mov bx, 0
loop_vidas:
    cmp bl, vidas
    jge fim_vidas
    
    ; Calcular posição X central: 160 - (3*19)/2 + bx*19
    push bx
    mov ax, bx
    mov dx, 19
    mul dx
    add ax, 132     ; Posição inicial centralizada
    mov dx, 3       ; Y = 3
    push ax
    lea si, sprite_vida
    call desenha_sprite_vida
    pop ax
    pop bx
    
    inc bx
    jmp loop_vidas
    
fim_vidas:
    ; TEMPO: à direita
    mov dh, 0
    mov dl, 32
    mov ah, 02h
    int 10h
    
    ; Restaurar string TEMPO:
    mov si, offset status_tempo
    mov byte ptr [si], 'T'
    mov byte ptr [si+1], 'E'
    mov byte ptr [si+2], 'M'
    mov byte ptr [si+3], 'P'
    mov byte ptr [si+4], 'O'
    mov byte ptr [si+5], ':'
    mov byte ptr [si+6], ' '
    mov byte ptr [si+7], 0
    mov bl, 0Ah     ; Verde
    call escreve_texto
    
    ; Converter tempo (2 dígitos)
    mov al, tempo_restante
    xor ah, ah
    mov bl, 10
    div bl
    
    add al, '0'
    mov ah, 09h
    mov bh, 0
    mov cx, 1
    int 10h
    
    inc dl
    mov ah, 02h
    int 10h
    
    mov al, ah
    add al, '0'
    mov ah, 09h
    mov cx, 1
    int 10h
    
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
; AX = posição X, DX = posição Y
desenha_sprite_vida proc near
    push ax
    push bx
    push cx
    push dx
    push di
    push si
    push es
    
    mov bx, dx      ; BX = Y
    mov dx, 0A000h
    mov es, dx
    
    mov cx, 7       ; 7 linhas
loop_vida_y:
    push cx
    push ax
    
    mov di, bx
    mov dx, 320
    push ax
    mov ax, di
    mul dx
    pop dx
    add ax, dx
    mov di, ax
    
    mov cx, 19      ; 19 pixels
loop_vida_x:
    lodsb
    cmp al, 0
    je skip_vida_pixel
    mov es:[di], al
skip_vida_pixel:
    inc di
    loop loop_vida_x
    
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

; Loop principal de uma fase
; Retorna AL = 0 se tempo esgotou, 1 se passou de fase
executar_fase proc near
    push bx
    push cx
    push dx
    
    ; Resetar tempo
    mov al, TEMPO_FASE
    mov tempo_restante, al
    mov ticks_contador, 0
    
loop_fase:
    call limpar_tela
    call desenhar_superficie
    call desenhar_status
    
    ; Desenhar nave do jogador
    mov ax, nave_jogador_x
    mov bx, nave_jogador_y
    lea si, sprite_nave
    call desenha_sprite
    
    ; Desenhar elementos da fase (inimigos)
    call desenha_elementos
    
    ; Desenhar tiros
    call desenha_tiros
    
    ; Pequeno delay
    mov cx, 4000h
delay_fase:
    loop delay_fase
    
    ; Mover elementos
    call move_elementos
    call move_tiros
    
    ; Atualizar contador de tempo
    inc ticks_contador
    mov ax, ticks_contador
    cmp ax, 18
    jl check_tecla_fase
    
    ; 1 segundo passou - adicionar 10 pontos
    mov ticks_contador, 0
    add score, 10
    dec tempo_restante
    cmp tempo_restante, 0
    jne check_tecla_fase
    jmp fim_tempo_fase
    
check_tecla_fase:
    ; Verificar tecla (ESC para voltar ao menu)
    mov ah, 1
    int 16h
    jz loop_fase
    
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
    cmp al, ' '     ; Espaço = atirar
    je nave_atira
    
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
    sub bx, 10      ; Limite antes da superfície
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
    cmp ax, 310
    jle dir_ok
    jmp loop_fase
dir_ok:
    mov nave_jogador_x, ax
    jmp loop_fase
    
nave_atira:
    call criar_tiro
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
    add ax, 8       ; Frente da nave
    shl bx, 1       ; bx*2 para índice word
    mov tiros_x[bx], ax
    mov ax, nave_jogador_y
    add ax, 3       ; Centro vertical
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
    ; Resetar fase e jogo
    mov fase_atual, 1
    mov score, 0
    mov vidas, 3
    mov nave_jogador_x, 40
    mov nave_jogador_y, 100
    
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
    ; Limpar tela e redesenhar menu
    call limpar_tela
    
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
