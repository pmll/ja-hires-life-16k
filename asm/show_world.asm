; world to screen, callable from Forth

world_to_screen: equ 0x03ED

call world_to_screen
jp (iy)
