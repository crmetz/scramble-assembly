.model small
.stack 100h

.data
    ; Constantes do jogo
    SCREEN_WIDTH equ 320
    SCREEN_HEIGHT equ 200
    VIDEO_SEGMENT equ 0A000h
    
    ; Cores
    COLOR_BLACK equ 0
    COLOR_WHITE equ 15
    COLOR_RED equ 12
    COLOR_GREEN equ 10
    COLOR_BLUE equ 1
    
    ; Teclas
    KEY_UP equ 48h
    KEY_DOWN equ 50h
    KEY_LEFT equ 4Bh
    KEY_RIGHT equ 4Dh
    KEY_SPACE equ 39h
    KEY_ENTER equ 1Ch
    KEY_ESC equ 01h
    
    ; Vari?veis do jogo
    current_screen db 0  ; 0=tela inicial, 1=jogo, 2=fim de jogo
    game_running db 1
    player_x dw 50
    player_y dw 100
    player_speed dw 3
    
    ; Mensagens
    title_text db 'SCRAMBLE', 0
    play_text db '[ JOGAR ]', 0
    exit_text db '[ SAIR ]', 0
    game_over_text db 'GAME OVER', 0
    winner_text db 'VENCEDOR!', 0

.code

; Macro para salvar registradores
push_all MACRO
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push bp
ENDM

; Macro para restaurar registradores
pop_all MACRO
    pop bp
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
ENDM

; Configura modo de v?deo 13h (320x200)
set_video_mode PROC
    mov ax, 13h
    int 10h
    ret
set_video_mode ENDP

; Volta para modo texto
set_text_mode PROC
    mov ax, 03h
    int 10h
    ret
set_text_mode ENDP

; Limpa a tela com cor espec?fica
clear_screen PROC
    push_all
    mov ax, VIDEO_SEGMENT
    mov es, ax
    mov di, 0
    mov cx, SCREEN_WIDTH * SCREEN_HEIGHT
    mov al, COLOR_BLACK
    rep stosb
    pop_all
    ret
clear_screen ENDP

; Desenha um pixel na posi??o (x,y) com cor
; CX = x, DX = y, AL = cor
draw_pixel PROC
    push_all
    mov bx, VIDEO_SEGMENT
    mov es, bx
    mov bx, dx
    shl bx, 6      ; y * 64
    mov di, bx
    shl bx, 2      ; y * 256
    add di, bx     ; y * 320
    add di, cx     ; + x
    mov es:[di], al
    pop_all
    ret
draw_pixel ENDP

; Desenha ret?ngulo
; CX = x, DX = y, SI = largura, DI = altura, AL = cor
draw_rect PROC
    push_all
    mov bx, dx
draw_rect_y:
    mov dx, bx
    push cx
    push si
draw_rect_x:
    call draw_pixel
    inc cx
    dec si
    jnz draw_rect_x
    pop si
    pop cx
    inc bx
    dec di
    jnz draw_rect_y
    pop_all
    ret
draw_rect ENDP

; Desenha texto simples (vers?o b?sica)
; SI = offset do texto, CX = x, DX = y, AL = cor
draw_text PROC
    push_all
    mov bx, ax
draw_text_loop:
    mov al, [si]
    cmp al, 0
    je draw_text_end
    
    ; Posiciona cursor e imprime caractere (modo tempor?rio)
    push si
    push bx
    push cx
    push dx
    
    mov ah, 02h
    mov bh, 0
    int 10h
    
    mov ah, 0Ah
    mov bh, 0
    mov cx, 1
    int 10h
    
    pop dx
    pop cx
    pop bx
    pop si
    
    inc si
    inc cx
    jmp draw_text_loop
    
draw_text_end:
    pop_all
    ret
draw_text ENDP

; L? tecla do teclado
; Retorna: AH = scan code, AL = ASCII
read_keyboard PROC
    mov ah, 01h
    int 16h
    jz no_key
    
    mov ah, 00h
    int 16h
    ret
    
no_key:
    xor ax, ax
    ret
read_keyboard ENDP

; Delay baseado em ticks do sistema
delay PROC
    push_all
    mov cx, 1
    mov dx, 8600h  ; ~1/18 segundos
    mov ah, 86h
    int 15h
    pop_all
    ret
delay ENDP

; Desenha a nave do jogador
draw_player PROC
    push_all
    mov cx, player_x
    mov dx, player_y
    mov si, 8
    mov di, 4
    mov al, COLOR_GREEN
    call draw_rect
    pop_all
    ret
draw_player ENDP

; Atualiza posi??o do jogador
update_player PROC
    push_all
    
    call read_keyboard
    cmp ah, KEY_LEFT
    je move_left
    cmp ah, KEY_RIGHT
    je move_right
    cmp ah, KEY_UP
    je move_up
    cmp ah, KEY_DOWN
    je move_down
    jmp update_player_end
    
move_left:
    mov ax, player_x
    sub ax, player_speed
    cmp ax, 0
    jl update_player_end
    mov player_x, ax
    jmp update_player_end
    
move_right:
    mov ax, player_x
    add ax, player_speed
    cmp ax, SCREEN_WIDTH - 8
    jg update_player_end
    mov player_x, ax
    jmp update_player_end
    
move_up:
    mov ax, player_y
    sub ax, player_speed
    cmp ax, 20  ; Deixa espa?o para status
    jl update_player_end
    mov player_y, ax
    jmp update_player_end
    
move_down:
    mov ax, player_y
    add ax, player_speed
    cmp ax, SCREEN_HEIGHT - 4
    jg update_player_end
    mov player_y, ax
    
update_player_end:
    pop_all
    ret
update_player ENDP

; Tela inicial
show_start_screen PROC
    push_all
    
start_screen_loop:
    call clear_screen
    
    ; Desenha t?tulo
    mov si, offset title_text
    mov cx, 150
    mov dx, 50
    mov al, COLOR_GREEN
    call draw_text
    
    ; Desenha menu
    mov si, offset play_text
    mov cx, 140
    mov dx, 100
    mov al, COLOR_WHITE
    call draw_text
    
    mov si, offset exit_text
    mov cx, 140
    mov dx, 120
    mov al, COLOR_WHITE
    call draw_text
    
    ; Verifica input
    call read_keyboard
    cmp ah, KEY_ENTER
    je start_select_option
    cmp ah, KEY_ESC
    je start_exit
    jmp start_continue
    
start_select_option:
    ; Simples - sempre inicia o jogo
    mov current_screen, 1
    jmp start_screen_end
    
start_exit:
    mov game_running, 0
    jmp start_screen_end
    
start_continue:
    call delay
    jmp start_screen_loop
    
start_screen_end:
    pop_all
    ret
show_start_screen ENDP

; Loop principal do jogo
game_loop PROC
    push_all
    
game_main_loop:
    cmp current_screen, 0
    je show_start
    cmp current_screen, 1
    je show_game
    cmp current_screen, 2
    je show_end
    
show_start:
    call show_start_screen
    jmp game_continue
    
show_game:
    call clear_screen
    call update_player
    call draw_player
    
    ; Verifica se quer sair
    call read_keyboard
    cmp ah, KEY_ESC
    jne game_continue
    mov current_screen, 0
    
    jmp game_continue
    
show_end:
    ; Tela de fim de jogo b?sica
    call clear_screen
    mov si, offset game_over_text
    mov cx, 150
    mov dx, 100
    mov al, COLOR_RED
    call draw_text
    
    call read_keyboard
    cmp ah, KEY_ENTER
    jne game_continue
    mov current_screen, 0
    
game_continue:
    call delay
    
    cmp game_running, 1
    je game_main_loop
    
    pop_all
    ret
game_loop ENDP

; Programa principal
main PROC
    mov ax, @data
    mov ds, ax
    
    call set_video_mode
    call game_loop
    call set_text_mode
    
    mov ah, 4Ch
    int 21h
main ENDP

end main