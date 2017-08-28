; output world frame to screen

screen: equ 0x2400
world_store: equ 0x4E00
current_frame_offset: equ 0x01ED    ; substitute with correct address

and a   ; reset carry

ld de, screen
ld h, (world_store / 256) + 1

ld c, 24
row_loop:

ld a,(current_frame_offset)
ld l, a

ld b, 32
col_loop: 

; UDG bit positions
; 81
; 42

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
