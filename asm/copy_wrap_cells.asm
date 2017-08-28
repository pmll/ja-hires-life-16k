; copy cells to facilitate wrap around world

world_store: equ 0x4E00
current_frame_offset: equ 0x01ED    ; substitute with correct address

; transfer left/right cols to right/left wrap store
ld h, (world_store / 256) + 1
ld d, h
ld a, (current_frame_offset)
ld e, a
add a, 64
ld l, a

ld b, 48
row_loop:

ld a, (de)
ld (hl), a

dec e
dec l

ld a, (hl)
ld (de), a

inc e
inc l
inc d
inc h
djnz row_loop

; transfer bottom line to top wrap store
ld h, (world_store / 256) + 48
ld d, (world_store / 256)
ld a, (current_frame_offset)
dec a
ld l, a
ld e, a
ld bc, 66
ldir

; transfer top line to bottom wrap store
ld h, (world_store / 256) + 1
ld d, (world_store / 256) + 49
ld a, (current_frame_offset)
dec a
ld l, a
ld e, a
ld bc, 66
ldir

ret

