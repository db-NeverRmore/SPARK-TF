
boot.header:
 
bits 16

  

  section .text
    global _start

    _start:


  ; установка видео режима
  mov ah, 0x00
  mov al, 0x03
  int 0x10 


  mov ah, 0x02
  mov bh, 0x00
  mov dh, 0x00
  mov dl, 0x00
  int 0x10


 ; найстройка цвета, а  именно синий текст на черном фоне
  mov ah, 0x0E
  mov al, ' '
  mov bl, 0x01
  int 0x10

 ; применение цветов к атрибутам дальнешего текста 
  mov ah, 0x09
  mov al, ' '
  mov bl, 0x01
  mov cx, 1 
  int 0x10



  cli ; отключение прерывания 

   ;инициализация сегментов

    mov ax, cs
    mov ds, ax
    mov es, ax
    xor ax, ax
    mov ss, ax
    mov fs, ax
    mov gs, ax

        mov sp, 0x7C00
sti  ; включение прерывания 

segments_read:

  mov al, 0x42
  mov dl, 0x80
  mov es, 0x1000
  mov si, lba_packet
  int 0x13
  
  cmp ah, 0x00 



main: 
  push word 16
  push word 2
  push word 0x1000
  pop bx
  pop bx
  pop bx
  jmp 0000:0x1000
  mov ax, 0x0 
  ret



end:
  
  times 510 - ($ - $$) db 0 
  dw 0xAA55
