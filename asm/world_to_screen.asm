; output world frame to screen

world_store: equ 0x4E00
current_frame_offset: equ 0x01ED    ; substitute with correct address

screen: equ 0x2400

and a   ; reset carry

ld de, screen
ld h, (world_store / 256) + 1

ld c, 24
row_loop:

ld a,(current_frame_offset)
ld l, a

ld b, 32
col_loop: 

; 12
; 48

; 81
; 42

; should really re-arrange these bit positions for maximum advantage here
ld a, (hl)
inc h
rla
or (hl)
inc l
rla
or (hl)
dec h
rla
or (hl)

ld (de), a
inc de
inc l

djnz col_loop

inc h
inc h
dec c
jr nz, row_loop

ret
