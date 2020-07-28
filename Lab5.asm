;Lab5
;Marchuk L.B. Var 9
assume cs:code
code segment
    Begin:
    jmp beg
    segm dw 0
    off dw 0
    
    beg:
    ;Save old interrupt vector
    mov ah, 35h
    mov al, 08h
    int 21h
    
    mov si, offset segm
    mov cs:[si], es
    
    mov si, offset off
    mov cs:[si], bx
    
    ;Set up interrupt vector
    push cs
    pop ds
    mov ah, 25h
    mov al, 08h
    mov dx, offset Handler
    int 21h
    
    mov dx, 00h
    mov ax, 00h
    
    ;Main loop
    start:
    ;Output some symbols
    mov ah, 0Ah
    mov bx, 00h
    mov cx, 01h
    int 10h
    
    mov ah, 02h
    mov bh, 00h
    int 10h
    jmp start
    
    ;Restore old interrupt vector
    mov ah, 25h
    mov al, 08h
    pop dx
    pop ds
    int 21h
    
    Handler proc  
    inc al
    inc dl
    
    push ax
    ;End of interrupt handler
    mov al, 20h
    out 20h, al
    pop ax
    
    iret
    endp Handler
    
code ends
end Begin