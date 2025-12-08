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
    
    ; ASCII art para Game Over
    game_over_msg   db 5 dup(" "),"                          ",13,10
                    db 5 dup(" "),"   ___   _   __  __ ___  ",13,10
                    db 5 dup(" "),"  / __| /_\ |  \/  | __| ",13,10
                    db 5 dup(" ")," | (_ |/ _ \| |\/| | _|  ",13,10
                    db 5 dup(" "),"  \___/_/ \_\_|_ |_|___| ",13,10
                    db 5 dup(" "),"  / _ \ \ / / __| _ \    ",13,10
                    db 5 dup(" ")," | (_) \ V /| _||   /    ",13,10
                    db 5 dup(" "),"  \___/ \_/ |___|_|_\    ",13,10
                    db 5 dup(" "),"                          ",13,10
    game_over_msg_length equ $-game_over_msg
    
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
    
    ; Sistema de torres para fase 3 (geração procedural)
    MAX_TOWERS equ 12
    tower_heights db MAX_TOWERS dup(0)  ; Altura de cada torre (em andares)
    tower_x_pos   dw MAX_TOWERS dup(0)  ; Posição X de cada torre
    tower_active  db MAX_TOWERS dup(0)  ; Torre ativa? (0=não, 1=sim)
    tower_spawn_counter dw 0            ; Contador para spawnar novas torres
    tower_min_spacing   equ 34          ; Espaçamento entre torres
    tower_sprite_offset dw 0            ; Offset no sprite (pixels a pular no clipping)
    tower_render_width  dw 34           ; Largura a renderizar (com clipping)
    
    ; Constantes da fase 3
    ROW_TERRAIN_FASE3 equ 165           ; Linha onde começa o terreno (mais baixo para facilitar)
    BASE_WIDTH  equ 34                  ; Largura de um andar (em pixels)
    BASE_HEIGHT equ 8                   ; Altura de um andar (em pixels)
    
    ; Variável temporária para cálculos
    temp_word dw 0
    
    ; Sprite da base das torres (34x8 pixels por andar)
    base    db 0, 0, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 0, 0
            db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 7, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 7, 7, 0, 0
            db 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 7, 7, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 7, 7, 0, 0
            db 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 7, 7, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 7, 7, 0, 0
            db 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 7, 7, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 7, 7, 0, 0
            db 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 7, 7, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 7, 7, 0, 0
            db 0, 0, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 7, 7, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 7, 7, 0, 0
            db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 0, 0
    
    ; Sprite do topo das torres (34x8 pixels)
    topo    db 7, 7, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 7, 7, 7, 7, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 7, 7, 0, 0
            db 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 0, 0
            db 4, 4, 4, 4, 4, 4, 7, 7, 7, 7, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 7, 7, 7, 7, 4, 4, 4, 4, 4, 4, 0, 0
            db 4, 4, 4, 4, 4, 4, 7, 7, 7, 7, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 7, 7, 7, 7, 4, 4, 4, 4, 4, 4, 0, 0
            db 4, 4, 4, 4, 4, 4, 7, 7, 7, 7, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 7, 7, 7, 7, 4, 4, 4, 4, 4, 4, 0, 0
            db 4, 4, 4, 4, 4, 4, 7, 7, 7, 7, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 7, 7, 7, 7, 4, 4, 4, 4, 4, 4, 0, 0
            db 7, 7, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 7, 7, 7, 7, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 7, 7, 0, 0
            db 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 0, 0

.code
;----------------------------------------------------------------
; Função: Escreve uma string de tamanho fixo usando a BIOS (modo 13h).
; Parâmetros de entrada: BP=offset da string, CX=tamanho em bytes, BL=cor, DH=linha, DL=coluna, ES=segmento do texto.
; Parâmetros de saída: Nenhum. Apenas escreve na tela e atualiza o cursor via BIOS.
;----------------------------------------------------------------
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

;----------------------------------------------------------------
; Função: Imprime string terminada em zero na posição de cursor indicada usando BIOS 10h.
; Parâmetros de entrada: DH=linha inicial, DL=coluna inicial, SI=ponteiro para string ASCIIZ, BL=cor do texto (página 0).
; Parâmetros de saída: Nenhum. Cursor é avançado conforme o texto renderizado.
;----------------------------------------------------------------
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

;----------------------------------------------------------------
; Função: Desenha o menu principal destacando a opção selecionada.
; Parâmetros de entrada: usa variável global opcao_sel para definir o destaque; requer DS apontando para os dados do menu.
; Parâmetros de saída: Nenhum. Apenas renderiza o menu no vídeo em modo texto BIOS.
;----------------------------------------------------------------
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

;----------------------------------------------------------------
; Função: Atualiza posições horizontais de nave, meteoro e alien do menu com movimento oscilante.
; Parâmetros de entrada: Nenhum explícito; usa variáveis globais nave_x, meteoro_x, alien_x e alien_dir.
; Parâmetros de saída: Nenhum. Somente altera as posições globais para o próximo frame.
;----------------------------------------------------------------
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

;----------------------------------------------------------------
; Função: Desenha os elementos animados do menu (nave, meteoro, alien) em modo gráfico.
; Parâmetros de entrada: Variáveis globais de posição (nave_x, meteoro_x, alien_x) e sprites associados.
; Parâmetros de saída: Nenhum. Apenas escreve os sprites na memória de vídeo.
;----------------------------------------------------------------
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

;----------------------------------------------------------------
; Função: Desenha um sprite 8x8 expandido para 16x16 na tela.
; Parâmetros de entrada: AX=posição X, BX=posição Y, SI=endereço do sprite 8x8.
; Parâmetros de saída: Nenhum. Pixels são escritos diretamente na memória de vídeo (modo 13h).
;----------------------------------------------------------------
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

;----------------------------------------------------------------
; Função: Desenha sprite 29x13 (nave do jogador) no modo 13h.
; Parâmetros de entrada: AX=posição X, BX=posição Y, SI=endereço do sprite 29x13.
; Parâmetros de saída: Nenhum. Apenas altera a memória de vídeo.
;----------------------------------------------------------------
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

;----------------------------------------------------------------
; Função: Desenha sprite 8x8 no modo 13h sem escalonamento.
; Parâmetros de entrada: AX=posição X, BX=posição Y, SI=endereço do sprite 8x8.
; Parâmetros de saída: Nenhum. Escreve pixels na VRAM.
;----------------------------------------------------------------
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

;----------------------------------------------------------------
; Função: Limpa os elementos animados do menu desenhando preto sobre suas áreas.
; Parâmetros de entrada: Usa posições globais nave_x, meteoro_x e alien_x; assume modo 13h ativo.
; Parâmetros de saída: Nenhum. Apenas escreve zeros na VRAM.
;----------------------------------------------------------------
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

;----------------------------------------------------------------
; Função: Apaga um bloco quadrado de tamanho variável na tela (modo 13h).
; Parâmetros de entrada: AX=posição X, BX=posição Y, CX=lado do quadrado; ES deve apontar para 0A000h.
; Parâmetros de saída: Nenhum. Região é preenchida com cor 0.
;----------------------------------------------------------------
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

;----------------------------------------------------------------
; Função: Apaga um sprite 8x8 na posição informada.
; Parâmetros de entrada: AX=posição X, BX=posição Y; ES deve estar apontando para a VRAM 0A000h.
; Parâmetros de saída: Nenhum. Área é zerada.
;----------------------------------------------------------------
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

;----------------------------------------------------------------
; Função: Desenha a superfície do planeta do HUD até o fim da tela com cor dependente da fase.
; Parâmetros de entrada: Usa fase_atual para escolher cor e superficie_y para posição inicial.
; Parâmetros de saída: Nenhum. Preenche linhas na VRAM.
;----------------------------------------------------------------
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
    ; Fase 3: renderiza torres procedurais em vez de cor sólida
    call update_fase3_towers
    call render_fase3_towers
    jmp fim_superficie
    
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
    
fim_superficie:
    pop es
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
desenhar_superficie endp

;----------------------------------------------------------------
; Função: Limpa toda a tela em modo 13h preenchendo com cor 0.
; Parâmetros de entrada: Nenhum.
; Parâmetros de saída: Nenhum. VRAM é zerada.
;----------------------------------------------------------------
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

;----------------------------------------------------------------
; Função: Mostra a apresentação textual da fase e aguarda alguns segundos.
; Parâmetros de entrada: AL=número da fase (1,2,3) para escolher arte e cor.
; Parâmetros de saída: Nenhum. Apenas desenha texto e faz delay.
;----------------------------------------------------------------
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

;----------------------------------------------------------------
; Função: Imprime número decimal de 5 dígitos no cursor atual via BIOS.
; Parâmetros de entrada: AX=valor a ser impresso; utiliza página 0 de vídeo.
; Parâmetros de saída: Nenhum. Cursor avança após cada dígito.
;----------------------------------------------------------------
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

;----------------------------------------------------------------
; Função: Desenha sprite de vida 7x19 na tela em modo 13h.
; Parâmetros de entrada: AX=posição X, DX=posição Y, SI=endereço do sprite de vida.
; Parâmetros de saída: Nenhum. Pixels são escritos na VRAM.
;----------------------------------------------------------------
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

;----------------------------------------------------------------
; Função: Limpa a região reservada para exibir as vidas na barra de status.
; Parâmetros de entrada: Nenhum. Usa posições fixas e assume modo 13h.
; Parâmetros de saída: Nenhum. Área é preenchida com 0.
;----------------------------------------------------------------
apaga_vidas_display proc near
    push ax
    push bx
    push cx
    push dx
    push di
    push es
    
    mov ax, 0A000h
    mov es, ax
    
    ; Apagar área de 3 sprites (3 x 10 pixels = 30 pixels de largura)
    mov bx, 1              ; Y inicial
    mov cx, 8              ; Altura do sprite
apaga_vidas_linha:
    push cx
    
    ; Calcular posição na memória de vídeo
    mov di, bx
    push dx
    mov dx, 320
    push ax
    mov ax, di
    mul dx
    pop dx
    add ax, 120            ; X inicial = 120
    mov di, ax
    pop dx
    
    ; Apagar 30 pixels (espaço para 3 vidas)
    push cx
    mov cx, 30
apaga_vidas_pixel:
    mov byte ptr es:[di], 0
    inc di
    loop apaga_vidas_pixel
    pop cx
    
    inc bx
    pop cx
    loop apaga_vidas_linha
    
    pop es
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
apaga_vidas_display endp

;----------------------------------------------------------------
; Função: Desenha os ícones de vidas restantes na barra de status.
; Parâmetros de entrada: Usa variável global vidas; posicionamento fixo em X=120, Y=1.
; Parâmetros de saída: Nenhum. Apenas renderiza sprites na VRAM.
;----------------------------------------------------------------
desenhar_vidas proc near
    push ax
    push bx
    push cx
    push si
    
    mov cl, vidas
    cmp cl, 0
    jle desenhar_vidas_fim
    mov ax, 120            ; X inicial
    mov bx, 1              ; Y fixo
    lea si, sprite_nave_8x8
desenhar_vidas_loop:
    call desenha_sprite
    add ax, 10             ; Espaçamento entre ícones
    dec cl
    jg desenhar_vidas_loop
desenhar_vidas_fim:
    
    pop si
    pop cx
    pop bx
    pop ax
    ret
desenhar_vidas endp

;----------------------------------------------------------------
; Função: Desenha caracteres simples (letra ou dígito) como blocos 3x5 pixels.
; Parâmetros de entrada: AX=X, BX=Y, CL=código ASCII do caractere, CH=cor do pixel.
; Parâmetros de saída: Nenhum. Pixels são escritos no segmento de vídeo 0A000h.
;----------------------------------------------------------------
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

;----------------------------------------------------------------
; Função: Gera número pseudo-aleatório de 16 bits via LCG e atualiza a seed.
; Parâmetros de entrada: random_seed contém o valor atual da semente.
; Parâmetros de saída: AX=novo valor pseudo-aleatório; random_seed é atualizado.
;----------------------------------------------------------------
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

;----------------------------------------------------------------
; Função: Cria um novo inimigo (alien/meteoro) no array caso haja slot livre.
; Parâmetros de entrada: Usa MAX_ALIENS, alien_array_active/pos, fase_atual para posicionamento; random_seed para sortear Y.
; Parâmetros de saída: Nenhum. Atualiza arrays de estado e posição quando um slot livre é encontrado.
;----------------------------------------------------------------
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
    
    ; Verifica fase para definir range de Y
    cmp fase_atual, 3
    je spawn_y_fase3
    
    ; Fases 1 e 2: Y entre 20-130
    call random
    xor dx, dx
    mov cx, 110         ; Divisor (130-20=110)
    div cx              ; DX = resto (0-109)
    mov ax, dx
    add ax, 20          ; Y entre 20-129
    jmp spawn_calc_pos
    
spawn_y_fase3:
    ; Fase 3: Y entre 30-120 (acima das torres que começam em 150)
    ; Tenta até 10 vezes encontrar posição sem colisão
    mov di, 10                      ; Contador de tentativas
    
spawn_retry_y_fase3:
    call random
    xor dx, dx
    mov cx, 90          ; Divisor (120-30=90)
    div cx              ; DX = resto (0-89)
    mov ax, dx
    add ax, 30          ; Y entre 30-119
    
    ; Verifica se essa posição colidiria com torres
    push ax
    push di
    mov dx, ax                      ; DX = Y proposto
    mov ax, 298                     ; AX = X (posição de spawn)
    mov cx, 29                      ; Largura do alien (mesmo que nave)
    mov si, 13                      ; Altura do alien
    call check_tower_collision_at_pos
    pop di
    cmp ax, 1
    pop ax
    jne spawn_calc_pos              ; Sem colisão, prosseguir
    
    ; Colisão detectada, tentar novamente
    dec di
    jnz spawn_retry_y_fase3
    
    ; Após 10 tentativas, usar Y padrão seguro (50)
    mov ax, 50
    
spawn_calc_pos:
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

;----------------------------------------------------------------
; Função: Move todas as entidades ativas (aliens/meteoros) para a esquerda e desativa as que saem da tela.
; Parâmetros de entrada: Usa arrays alien_array_active/pos e velocidades alien_move_speed/meteor_move_speed; depende de fase_atual.
; Parâmetros de saída: Nenhum. Atualiza posições e flags de atividade nos arrays.
;----------------------------------------------------------------
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

;----------------------------------------------------------------
; Função: Atualiza o sistema de inimigos realizando spawn periódico e movimento por frame.
; Parâmetros de entrada: fase_atual define o delay de spawn; alien_spawn_timer/delay e meteor_spawn_delay controlam temporização.
; Parâmetros de saída: Nenhum. Pode ativar novos inimigos e mover os existentes.
;----------------------------------------------------------------
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

;----------------------------------------------------------------
; Função: Desenha todos os inimigos ativos (aliens ou meteoros) conforme a fase.
; Parâmetros de entrada: Arrays alien_array_pos/active, fase_atual para escolher sprite; usa modo 13h.
; Parâmetros de saída: Nenhum. Apenas renderiza sprites visíveis.
;----------------------------------------------------------------
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

;----------------------------------------------------------------
; Função: Verifica colisão entre a nave do jogador e inimigos; atualiza vidas e reposiciona se necessário.
; Parâmetros de entrada: Posicionamento em nave_jogador_x/nave_jogador_y e arrays alien_array_pos/active; fase_atual define dimensões dos inimigos.
; Parâmetros de saída: AX=1 se houve colisão, AX=0 caso contrário; pode decrementar vidas e resetar posições.
;----------------------------------------------------------------
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
    push si                 ; Salva índice
    mov si, nave_jogador_y
    cmp si, ax
    pop si                  ; Restaura índice
    jge proximo_inimigo

    mov ax, nave_jogador_y
    add ax, 13              ; player_y + altura
    cmp dx, ax              ; dx = inimigo_y
    jge proximo_inimigo

    ; Colisao detectada
    push si                 ; Salva índice antes de usar
    cmp byte ptr vidas, 0
    je salva_estado
    dec vidas             ; DESABILITADO: sem dano
    call apaga_vidas_display
    call desenhar_vidas
salva_estado:
    pop si                  ; Restaura índice
    mov byte ptr alien_array_active[si], 0
    mov nave_jogador_x, 40
    
    ; Reseta Y baseado na fase
    cmp fase_atual, 3
    jne reset_y_normal
    mov nave_jogador_y, 50  ; Fase 3: Y=50
    jmp reset_y_done
reset_y_normal:
    mov nave_jogador_y, 80  ; Fases 1 e 2: Y=80
reset_y_done:
    mov ax, 1               ; flag de colisao
    jmp fim_colisao

proximo_inimigo:
    inc si
    dec cx
    jz sem_colisao_aliens
    jmp loop_colisao
    
sem_colisao_aliens:
    xor ax, ax              ; Nenhuma colisao
    
    ; Verifica colisão com torres (apenas fase 3)
    cmp fase_atual, 3
    jne fim_colisao
    call verifica_colisao_torres
    cmp ax, 1
    je fim_colisao          ; Se colidiu com torre, AX já está = 1

fim_colisao:
    pop bp
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    ret
checa_colisao_jogador endp

;----------------------------------------------------------------
; Função: Verifica colisão da nave do jogador com torres da fase 3
; Parâmetros de entrada: nave_jogador_x, nave_jogador_y, tower_active, tower_x_pos, tower_heights
; Parâmetros de saída: AX = 1 se houve colisão, 0 caso contrário
;----------------------------------------------------------------
verifica_colisao_torres proc near
    push bx
    push cx
    push dx
    push si
    push di
    
    ; Coordenadas da nave (canto superior esquerdo)
    mov ax, nave_jogador_x      ; nave_x
    mov dx, nave_jogador_y      ; nave_y
    
    ; Dimensões da nave: 29 (largura) x 13 (altura)
    ; Área de colisão: X até X+29, Y até Y+13
    
    ; Loop por todas as torres
    mov cx, MAX_TOWERS
    xor bx, bx
    
loop_torres_colisao:
    ; Verifica se torre está ativa
    cmp byte ptr tower_active[bx], 0
    je proxima_torre_colisao
    
    ; Pega posição X da torre
    shl bx, 1                   ; BX *= 2 para word array
    mov si, word ptr tower_x_pos[bx]
    shr bx, 1                   ; BX /= 2 volta para byte array
    
    ; Pega altura da torre (número de andares)
    mov al, byte ptr tower_heights[bx]
    xor ah, ah
    
    ; Calcula limites da torre
    ; Torre: X_torre até X_torre+34, Y desde (185 - altura*8) até Y=200
    ; BASE_WIDTH = 34, BASE_HEIGHT = 8
    
    ; Limite direito da torre: X_torre + 34
    mov di, si
    add di, 34
    
    ; Verifica colisão no eixo X
    ; nave_x + 29 >= torre_x E nave_x <= torre_x + 34
    mov word ptr temp_word, ax  ; Salva altura temporariamente
    
    mov ax, nave_jogador_x
    add ax, 29                  ; nave_direita
    cmp ax, si                  ; nave_direita >= torre_esq?
    jl proxima_torre_colisao
    
    mov ax, nave_jogador_x      ; nave_esq
    cmp ax, di                  ; nave_esq <= torre_dir?
    jg proxima_torre_colisao
    
    ; Há sobreposição em X, verifica Y
    mov ax, word ptr temp_word  ; Recupera altura
    
    ; Y_topo_torre = 185 - (altura * 8)
    mov cx, 8
    mul cx                      ; AX = altura * 8
    mov di, 185
    sub di, ax                  ; DI = Y_topo_torre
    
    ; Verifica colisão no eixo Y
    ; nave_y + 13 > torre_topo E nave_y < 200
    mov ax, nave_jogador_y
    add ax, 13                  ; nave_baixo
    cmp ax, di                  ; nave_baixo > torre_topo?
    jle proxima_torre_colisao
    
    ; Verifica se nave está abaixo do topo da torre
    mov ax, nave_jogador_y
    cmp ax, di                  ; nave_y < torre_topo?
    jl proxima_torre_colisao    ; Se nave está completamente acima, sem colisão
    
    ; Colisão detectada!
    cmp byte ptr vidas, 0
    je torre_salva_estado
    dec vidas             ; DESABILITADO: sem dano
    call apaga_vidas_display
    call desenhar_vidas
    
torre_salva_estado:
    mov nave_jogador_x, 40
    mov nave_jogador_y, 50      ; Fase 3: volta para Y=50
    mov ax, 1                   ; Flag de colisão
    jmp fim_torres_colisao
    
proxima_torre_colisao:
    inc bx
    loop loop_torres_colisao
    
    xor ax, ax                  ; Nenhuma colisão
    
fim_torres_colisao:
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    ret
verifica_colisao_torres endp

;----------------------------------------------------------------
; Função: Verifica se uma posição arbitrária colide com torres da fase 3
; Entrada: AX = X, DX = Y, CX = largura, SI = altura
; Saída: AX = 1 se colidiu, 0 caso contrário
;----------------------------------------------------------------
check_tower_collision_at_pos proc near
    push bx
    push cx
    push dx
    push si
    push di
    push bp
    
    ; Salva parâmetros
    mov word ptr temp_word, ax      ; X
    mov bp, dx                      ; Y
    ; CX já tem largura
    ; SI já tem altura
    
    ; Loop por todas as torres
    mov dx, MAX_TOWERS
    xor bx, bx
    
loop_check_towers:
    ; Verifica se torre está ativa
    cmp byte ptr tower_active[bx], 0
    je proxima_check_torre
    
    ; Pega posição X da torre
    push bx
    shl bx, 1                       ; BX *= 2 para word array
    mov di, word ptr tower_x_pos[bx]
    pop bx
    
    ; Pega altura da torre (número de andares)
    mov al, byte ptr tower_heights[bx]
    xor ah, ah
    
    ; Calcula limites da torre
    ; Torre X: di até di+34
    ; Torre Y: (185 - altura*8) até 200
    
    ; Limite direito da torre: X_torre + 34
    push ax
    mov ax, di
    add ax, 34
    push ax                         ; Salva X_torre_dir
    
    ; Verifica colisão no eixo X
    ; objeto_x + largura > torre_x E objeto_x < torre_x + 34
    mov ax, word ptr temp_word      ; objeto_x
    add ax, cx                      ; objeto_x + largura
    cmp ax, di                      ; > torre_x?
    jle sem_colisao_x_check
    
    mov ax, word ptr temp_word      ; objeto_x
    pop di                          ; Recupera X_torre_dir
    cmp ax, di                      ; < torre_x_dir?
    jge sem_colisao_x_check_2
    
    ; Há sobreposição em X, verifica Y
    pop ax                          ; Recupera altura da torre
    
    ; Y_topo_torre = 185 - (altura * 8)
    push dx
    mov dx, 8
    mul dx                          ; AX = altura * 8
    mov di, 185
    sub di, ax                      ; DI = Y_topo_torre
    pop dx
    
    ; Verifica colisão no eixo Y
    ; objeto_y + altura > torre_topo E objeto_y < 200
    mov ax, bp                      ; objeto_y
    add ax, si                      ; objeto_y + altura
    cmp ax, di                      ; > torre_topo?
    jle sem_colisao_y_check
    
    mov ax, bp                      ; objeto_y
    cmp ax, 200                     ; < 200?
    jge sem_colisao_y_check
    
    ; Colisão detectada!
    mov ax, 1
    jmp fim_check_towers
    
sem_colisao_x_check:
    pop di                          ; Remove X_torre_dir
sem_colisao_x_check_2:
    pop ax                          ; Remove altura
    jmp proxima_check_torre
    
sem_colisao_y_check:
    jmp proxima_check_torre
    
proxima_check_torre:
    inc bx
    dec dx
    jnz loop_check_towers
    
    xor ax, ax                      ; Nenhuma colisão
    
fim_check_towers:
    pop bp
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    ret
check_tower_collision_at_pos endp

;----------------------------------------------------------------
; Função: Exibe tela de vitória com score final e aguarda pressionar uma tecla.
; Parâmetros de entrada: Usa score, score_buffer e mensagens constantes; assume modo 13h ativo.
; Parâmetros de saída: Nenhum. Tela é limpa e redesenhada até o retorno.
;----------------------------------------------------------------
;----------------------------------------------------------------
; Função: Inicializa sistema de torres da fase 3 preenchendo a tela com torres de alturas aleatórias.
; Parâmetros de entrada: Constantes MAX_TOWERS, BASE_WIDTH; usa random para gerar alturas entre 3-6 andares.
; Parâmetros de saída: Nenhum. Preenche arrays tower_active, tower_x_pos e tower_heights; reseta tower_spawn_counter.
;----------------------------------------------------------------
init_fase3_towers proc near
    push ax
    push bx
    push cx
    push dx
    
    ; Inicializa torres preenchendo a tela
    xor bx, bx
    mov dx, 320                      ; Começa em X = 320
    mov cx, MAX_TOWERS
    
init_tower_loop:
    ; Ativa torre
    mov byte ptr tower_active[bx], 1
    
    ; Define posição X
    push bx
    shl bx, 1
    mov word ptr tower_x_pos[bx], dx
    pop bx
    
    ; Altura aleatória (3 a 6 andares)
    push bx
    push cx
    push dx
    call random
    and ax, 3               ; 0-3
    add al, 3               ; 3-6 andares
    pop dx
    pop cx
    pop bx
    mov byte ptr tower_heights[bx], al
    
    ; Próxima torre (BASE_WIDTH pixels à esquerda)
    sub dx, BASE_WIDTH
    
    inc bx
    loop init_tower_loop
    
    ; Reseta contadores
    mov tower_spawn_counter, 0
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
init_fase3_towers endp

;----------------------------------------------------------------
; Função: Atualiza posição de todas as torres ativas, desativa as que saem da tela e spawna novas periodicamente.
; Parâmetros de entrada: Arrays tower_active/tower_x_pos; tower_spawn_counter e tower_min_spacing controlam temporização de spawn.
; Parâmetros de saída: Nenhum. Move torres 1 pixel à esquerda, desativa as que X < -40, e chama spawn_fase3_tower periodicamente.
;----------------------------------------------------------------
update_fase3_towers proc near
    push ax
    push bx
    push cx
    push dx
    
    ; Move todas as torres para esquerda
    xor bx, bx
    mov cx, MAX_TOWERS
move_towers_loop:
    cmp byte ptr tower_active[bx], 0
    je skip_move_tower
    
    ; Move torre 1 pixel para esquerda
    push bx
    shl bx, 1
    dec word ptr tower_x_pos[bx]
    
    ; Verifica se saiu pela esquerda (X < -40)
    mov ax, word ptr tower_x_pos[bx]
    pop bx
    
    test ax, ax
    jns skip_move_tower
    
    ; X é negativo
    neg ax
    cmp ax, 40
    jl skip_move_tower
    
    ; Desativa torre
    mov byte ptr tower_active[bx], 0
    
skip_move_tower:
    inc bx
    loop move_towers_loop
    
    ; Verifica se deve gerar nova torre
    inc tower_spawn_counter
    mov ax, tower_spawn_counter
    cmp ax, tower_min_spacing
    jl skip_spawn_tower
    
    ; Reseta contador e gera nova torre
    mov tower_spawn_counter, 0
    call spawn_fase3_tower
    
skip_spawn_tower:
    pop dx
    pop cx
    pop bx
    pop ax
    ret
update_fase3_towers endp

;----------------------------------------------------------------
; Função: Cria nova torre aleatória em slot livre do array com posição X=320 e altura entre 2-9 andares.
; Parâmetros de entrada: Arrays tower_active/tower_x_pos/tower_heights; usa random para gerar altura.
; Parâmetros de saída: Nenhum. Ativa torre em slot vazio caso disponível; define X=320 e altura aleatória.
;----------------------------------------------------------------
spawn_fase3_tower proc near
    push ax
    push bx
    push cx
    
    ; Procura slot vazio
    xor bx, bx
    mov cx, MAX_TOWERS
find_empty_slot:
    cmp byte ptr tower_active[bx], 0
    je found_empty_slot
    inc bx
    loop find_empty_slot
    jmp spawn_done
    
found_empty_slot:
    ; Ativa torre
    mov byte ptr tower_active[bx], 1
    
    ; Posição X inicial (320)
    push bx
    shl bx, 1
    mov word ptr tower_x_pos[bx], 320
    pop bx
    
    ; Gera altura aleatória (2 a 8 andares)
    call random
    and ax, 7        ; 0-7
    add al, 2        ; 2-9
    mov byte ptr tower_heights[bx], al
    
spawn_done:
    pop cx
    pop bx
    pop ax
    ret
spawn_fase3_tower endp

;----------------------------------------------------------------
; Função: Renderiza todas as torres ativas da fase 3 na tela em suas posições atuais.
; Parâmetros de entrada: Arrays tower_active/tower_x_pos/tower_heights; chama render_tower para cada torre ativa.
; Parâmetros de saída: Nenhum. Apenas delega renderização para render_tower.
;----------------------------------------------------------------
render_fase3_towers proc near
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    
    xor bx, bx
    mov cx, MAX_TOWERS
render_towers_loop:
    cmp byte ptr tower_active[bx], 0
    je skip_render_tower
    
    ; Renderiza esta torre
    push bx
    push cx
    
    xor ah, ah
    mov al, byte ptr tower_heights[bx]
    mov cx, ax
    
    push bx
    shl bx, 1
    mov dx, word ptr tower_x_pos[bx]
    pop bx
    
    call render_tower
    
    pop cx
    pop bx
    
skip_render_tower:
    inc bx
    loop render_towers_loop
    
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
render_fase3_towers endp

;----------------------------------------------------------------
; Função: Renderiza uma torre individual com clipping horizontal, empilhando sprites base e topo.
; Parâmetros de entrada: CX=altura em andares, DX=posição X; sprites base e topo (34x8 pixels); constantes BASE_WIDTH/BASE_HEIGHT/ROW_TERRAIN_FASE3.
; Parâmetros de saída: Nenhum. Desenha torre na VRAM (0A000h) com clipping para torres parcialmente visíveis.
;----------------------------------------------------------------
render_tower proc near
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push bp
    push es
    
    cld
    
    mov ax, 0A000h
    mov es, ax
    
    ; Verifica visibilidade (usa jump intermediário para evitar "out of range")
    cmp dx, -BASE_WIDTH
    jl tower_not_visible_jmp
    cmp dx, 320
    jge tower_not_visible_jmp
    jmp tower_visible
    
tower_not_visible_jmp:
    jmp tower_not_visible
    
tower_visible:
    push cx
    
    ; Calcula clipping horizontal
    mov tower_sprite_offset, 0
    mov ax, BASE_WIDTH
    mov tower_render_width, ax
    
    cmp dx, 0
    jge clip_right_check
    
    ; X negativo: ajusta offset
    mov ax, dx
    neg ax
    mov tower_sprite_offset, ax
    mov bx, BASE_WIDTH
    sub bx, ax
    mov tower_render_width, bx
    mov dx, 0
    jmp clip_done
    
clip_right_check:
    mov ax, dx
    add ax, BASE_WIDTH
    cmp ax, 320
    jle clip_done
    mov ax, 320
    sub ax, dx
    mov tower_render_width, ax
    
clip_done:
    ; Calcula posição Y do topo
    mov ax, cx
    mov bl, BASE_HEIGHT
    mul bl
    mov bx, ROW_TERRAIN_FASE3
    sub bx, ax
    
    cmp bx, 0
    jge tower_y_ok
    xor bx, bx
tower_y_ok:
    
    ; Calcula offset linear: Y * 320 + X
    push dx
    mov ax, bx
    mov bx, 320
    mul bx
    pop bx
    add ax, bx
    mov di, ax
    
    ; Total de andares
    pop ax
    mov bp, ax
    add ax, 6
    mov cx, ax
    
render_floor_loop:
    push cx
    push bp
    
    mov ax, bp
    add ax, 6
    cmp cx, ax
    pop bp
    jne render_base_andar
    
    ; Renderiza topo
    push di
    mov si, offset topo
    add si, tower_sprite_offset
    
    mov cx, BASE_HEIGHT
render_top_line_loop:
    push cx
    push di
    push si
    
    mov cx, tower_render_width
    rep movsb
    
    pop si
    add si, BASE_WIDTH
    pop di
    pop cx
    add di, 320
    loop render_top_line_loop
    pop di
    jmp next_floor
    
render_base_andar:
    ; Renderiza andar da base
    push di
    mov si, offset base
    add si, tower_sprite_offset
    
    mov cx, BASE_HEIGHT
render_base_line_loop:
    push cx
    push di
    push si
    
    mov cx, tower_render_width
    rep movsb
    
    pop si
    add si, BASE_WIDTH
    pop di
    pop cx
    add di, 320
    loop render_base_line_loop
    pop di
    
next_floor:
    mov ax, BASE_HEIGHT
    mov bx, 320
    mul bx
    add di, ax
    
    pop cx
    loop render_floor_loop
    jmp tower_done
    
tower_not_visible:
    
tower_done:
    pop es
    pop bp
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
render_tower endp

;----------------------------------------------------------------
; Função: Exibe tela de Game Over com ASCII art vermelho, score final e aguarda pressionar tecla.
; Parâmetros de entrada: Usa score, score_buffer e mensagens game_over_msg, final_score_msg, press_key_msg; assume modo 13h ativo.
; Parâmetros de saída: Nenhum. Limpa tela, exibe mensagens via PRINT_STRING e aguarda input antes de retornar.
;----------------------------------------------------------------
exibir_game_over proc near
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
    
    ; Exibe mensagem Game Over em vermelho
    mov bp, offset game_over_msg
    mov cx, game_over_msg_length
    mov bl, 0Ch     ; Vermelho
    mov dh, 3       ; Linha 3
    mov dl, 0       ; Coluna 0
    call PRINT_STRING
    
    ; Exibe "SCORE FINAL:" em branco (linha 15, coluna 10)
    mov bp, offset final_score_msg
    mov cx, final_score_msg_length
    mov bl, 0Fh     ; Branco
    mov dh, 15
    mov dl, 10
    call PRINT_STRING
    
    ; Converte score para string
    mov ax, score
    mov si, offset score_buffer + 4
    mov cx, 5
    call converte_numero_5dig
    
    ; Exibe score em amarelo (linha 15, coluna 23)
    mov bp, offset score_buffer
    mov cx, 5
    mov bl, 0Eh     ; Amarelo
    mov dh, 15
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
exibir_game_over endp

;----------------------------------------------------------------
; Função: Exibe tela de vitória com ASCII art verde, score final e aguarda pressionar tecla.
; Parâmetros de entrada: Usa score, score_buffer e mensagens vencedor_msg, final_score_msg, press_key_msg; assume modo 13h ativo.
; Parâmetros de saída: Nenhum. Limpa tela, exibe mensagens via PRINT_STRING e aguarda input antes de retornar.
;----------------------------------------------------------------
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

;----------------------------------------------------------------
; Função: Converte valor decimal em AX para string de dígitos, preenchendo buffer de trás para frente.
; Parâmetros de entrada: AX=valor, SI=posição final do buffer para escrita reversa, CX=quantidade de dígitos a gerar.
; Parâmetros de saída: Buffer preenchido com dígitos ASCII; registradores preservados conforme push/pop.
;----------------------------------------------------------------
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

;----------------------------------------------------------------
; Função: Executa o loop principal de uma fase, incluindo desenho, entrada, spawn e temporização.
; Parâmetros de entrada: Usa variáveis globais do estado do jogo (fase_atual, vidas, score, posições, arrays de inimigos/tiros).
; Parâmetros de saída: AL retorna 0 ao sair para o menu ou após finalizar todas as fases; estado global é atualizado conforme o jogo.
;----------------------------------------------------------------
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
    
    ; Ajusta posição inicial da nave baseado na fase
    mov nave_jogador_x, 40
    cmp fase_atual, 3
    jne skip_fase3_setup
    
    ; Fase 3: nave começa mais alto
    mov nave_jogador_y, 50
    call init_fase3_towers
    jmp skip_init_towers
    
skip_fase3_setup:
    ; Fases 1 e 2: nave começa em Y=80
    mov nave_jogador_y, 80
    
skip_init_towers:
    
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
    call desenhar_vidas
    
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
    
    ; Fase 3: checar colisão com torres
    cmp fase_atual, 3
    jne sem_colisao_torres
    call verifica_colisao_torres
sem_colisao_torres:
    
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
    jne check_dir
    jmp nave_esq
check_dir:
    cmp ah, 4Dh     ; Seta direita
    jne continua_loop
    jmp nave_dir
    
continua_loop:
    jmp loop_fase
    
nave_cima:
    mov ax, nave_jogador_y
    sub ax, 3
    
    ; Verifica fase atual para definir limite correto
    cmp fase_atual, 3
    je limite_cima_fase3
    
    ; Fases 1 e 2: limite após o HUD (linha 10)
    cmp ax, 10
    jge cima_ok
    jmp loop_fase
    
limite_cima_fase3:
    ; Fase 3: limite mais alto (linha 20) para dar espaço
    cmp ax, 20
    jl cima_bloqueado
    
    ; Verifica colisão com torres na nova posição
    push ax
    mov dx, ax                      ; DX = nova Y
    mov ax, nave_jogador_x          ; AX = X
    mov cx, 29                      ; Largura da nave
    mov si, 13                      ; Altura da nave
    call check_tower_collision_at_pos
    cmp ax, 1
    pop ax
    je cima_bloqueado
    jmp cima_ok
    
cima_bloqueado:
    jmp loop_fase
    
cima_ok:
    mov nave_jogador_y, ax
    jmp loop_fase
    
nave_baixo:
    mov ax, nave_jogador_y
    add ax, 3
    
    ; Verifica fase atual para definir limite correto
    cmp fase_atual, 3
    je limite_fase3
    
    ; Fases 1 e 2: usa superficie_y
    mov bx, superficie_y
    sub bx, 13      ; Limite antes da superfície (altura da nave = 13)
    jmp verifica_limite_baixo
    
limite_fase3:
    ; Fase 3: limite fixo na linha 150 (antes das torres que começam em 165)
    mov bx, 150
    cmp ax, bx
    jg baixo_bloqueado
    
    ; Verifica colisão com torres na nova posição
    push ax
    mov dx, ax                      ; DX = nova Y
    mov ax, nave_jogador_x          ; AX = X
    mov cx, 29                      ; Largura da nave
    mov si, 13                      ; Altura da nave
    call check_tower_collision_at_pos
    cmp ax, 1
    pop ax
    je baixo_bloqueado
    jmp baixo_ok
    
verifica_limite_baixo:
    cmp ax, bx
    jle baixo_ok
    jmp loop_fase
    
baixo_bloqueado:
    jmp loop_fase
baixo_ok:
    mov nave_jogador_y, ax
    jmp loop_fase
    
nave_esq:
    mov ax, nave_jogador_x
    sub ax, 3
    cmp ax, 0
    jl esq_bloqueado
    
    ; Fase 3: verifica colisão com torres
    cmp fase_atual, 3
    jne esq_ok
    
    push ax
    mov dx, nave_jogador_y          ; DX = Y atual
    ; AX já tem nova X
    mov cx, 29                      ; Largura da nave
    mov si, 13                      ; Altura da nave
    call check_tower_collision_at_pos
    cmp ax, 1
    pop ax
    je esq_bloqueado
    jmp esq_ok
    
esq_bloqueado:
    jmp loop_fase
esq_ok:
    mov nave_jogador_x, ax
    jmp loop_fase
    
nave_dir:
    mov ax, nave_jogador_x
    add ax, 3
    cmp ax, 291         ; 320 - 29 = 291 (limite direito)
    jg dir_bloqueado
    
    ; Fase 3: verifica colisão com torres
    cmp fase_atual, 3
    jne dir_ok
    
    push ax
    mov dx, nave_jogador_y          ; DX = Y atual
    ; AX já tem nova X
    mov cx, 29                      ; Largura da nave
    mov si, 13                      ; Altura da nave
    call check_tower_collision_at_pos
    cmp ax, 1
    pop ax
    je dir_bloqueado
    jmp dir_ok
    
dir_bloqueado:
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

;----------------------------------------------------------------
; Função: Registra um novo tiro se houver slot livre, posicionando-o na frente da nave.
; Parâmetros de entrada: Posições nave_jogador_x/nave_jogador_y e arrays tiros_x/tiros_y/tiros_ativo.
; Parâmetros de saída: Nenhum. Atualiza arrays e ativa o tiro correspondente.
;----------------------------------------------------------------
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

;----------------------------------------------------------------
; Função: Atualiza movimento dos tiros ativos, desativando os que saem da tela.
; Parâmetros de entrada: Arrays tiros_x/tiros_y/tiros_ativo; constantes de largura da tela.
; Parâmetros de saída: Nenhum. Apenas modifica posições e flags dos tiros.
;----------------------------------------------------------------
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

;----------------------------------------------------------------
; Função: Desenha todos os tiros ativos como blocos 2x2 amarelos no modo 13h.
; Parâmetros de entrada: Arrays tiros_x/tiros_y/tiros_ativo.
; Parâmetros de saída: Nenhum. Pixels são escritos na VRAM.
;----------------------------------------------------------------
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

;----------------------------------------------------------------
; Função: Ponto de entrada do programa; configura modo de vídeo, desenha menu e gerencia seleção/fluxo do jogo.
; Parâmetros de entrada: Nenhum (execução inicial).
; Parâmetros de saída: Nenhum. O programa finaliza via int 21h/4Ch ao escolher Sair.
;----------------------------------------------------------------
;----------------------------------------------------------------
; Função: Verifica condições de fim de jogo, retornando status baseado em vidas e fase atual.
; Parâmetros de entrada: vidas (número de vidas restantes), fase_atual (fase em execução).
; Parâmetros de saída: AL=0 (jogo continua), AL=1 (game over - vidas=0), AL=2 (vitória - fase_atual≥4).
;----------------------------------------------------------------
check_game_end proc near
    push bx
    
    ; Verifica se perdeu todas as vidas
    cmp vidas, 0
    je game_over_condition
    
    ; Verifica se completou todas as fases (fase > 3)
    cmp fase_atual, 4
    jge victory_condition
    
    ; Jogo continua
    mov al, 0
    jmp end_check
    
game_over_condition:
    mov al, 1
    jmp end_check
    
victory_condition:
    mov al, 2
    
end_check:
    pop bx
    ret
check_game_end endp

;----------------------------------------------------------------
; Função: Ponto de entrada do programa; configura modo de vídeo, desenha menu e gerencia seleção/fluxo do jogo.
; Parâmetros de entrada: Nenhum (execução inicial).
; Parâmetros de saída: Nenhum. O programa finaliza via int 21h/4Ch ao escolher Sair.
;----------------------------------------------------------------
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
    mov nave_jogador_y, 80    ; Fase 1 sempre começa em Y=80
    
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
    
game_loop:
    ; Executar fase
    call executar_fase
    
    ; Verificar condições de fim de jogo
    call check_game_end
    cmp al, 1            ; Game Over?
    je game_over_end
    cmp al, 2            ; Vitória?
    je victory_end
    
    ; Continua jogo (próxima fase)
    jmp game_loop
    
game_over_end:
    call exibir_game_over
    jmp reiniciar_menu
    
victory_end:
    call exibir_vitoria
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
