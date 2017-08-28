; update world

world_store: equ 0x4E00
; substitute these with correct addresses
current_frame_offset: equ 0x01ED
work_frame_offset: equ 0x02ED
world_to_screen: equ 0x03ED
wrap_world: equ 0x04ED
copy_wrap_cells: equ 0x05ED

ld a, (wrap_world)
cp 0
jr z, no_wrap

call copy_wrap_cells
no_wrap:

; set high bytes to first line
ld h, (world_store / 256) + 1
ld d, h

ld c, 48
row_loop:

; set low byte offsets
ld a,(current_frame_offset)
ld l, a
ld a,(work_frame_offset)
ld e, a

ld b, 64
col_loop:

; get count of live neighbours
xor a
inc l
add a, (hl)
dec h
add a, (hl)
dec l
add a, (hl)
dec l
add a, (hl)
inc h
add a, (hl)
inc h
add a, (hl)
inc l
add a, (hl)
inc l
add a, (hl)
dec h
dec l

bit 0, (hl)
jr nz, alive

; dead cell
cp 3
jr nz, cell_dies
ld a, 1
jr store_cell

alive:
cp 2
jr c, cell_dies
cp 4
jr nc, cell_dies
ld a, 1
jr store_cell

cell_dies:
xor a

store_cell:
ld (de), a

inc e
inc l
djnz col_loop

inc h
inc d
dec c
jr nz, row_loop

; update frame offsets
ld a,(current_frame_offset)
ld l, a
ld a, (work_frame_offset)
ld (current_frame_offset), a
ld a, l
ld (work_frame_offset), a

; output current frame to screen
call world_to_screen

jp (iy)
