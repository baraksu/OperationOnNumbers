; version 1.02
.MODEL small
.STACK 100h
.DATA        
msg0 db 13,10,'Enter amount of numbers. ','$'   
array dw 100 dup (0) 
result db 16 dup('x'), 'b'
msg1 db 13,10, "supported values from -32768 to 65535",13,10
     db "enter the number: $" 
counter dw 0
crlf db 13,10,'$',13,10                
make_minus db ? ; used as a flag.
ten dw 10 ; used as multiplier. 
msg3 db 13,10,"_______________________________________________________",13,10   
     db       "³ This program does the following:                    ³",13,10         
     db       "³                                                     ³",13,10
     db       "³ To insert the numbers press: 1                      ³",13,10
     db       "³ To get the lowest number press: 2                   ³",13,10
     db       "³ To get the highest number press: 3                  ³",13,10           
     db       "³ To calculate the average of all the numbers press: 4³",13,10
     db       "³ To print all numbers press: 5                       ³",13,10 
     db       "³ To end program press: 6                             ³",13,10
     db       "³_____________________________________________________³",13,10 
     db       13,10,'$'
msg4 db 13,10,'Error in input enter again: ','$'
msg5 db 13,10,'Lowest number: ','$' 
msg6 db 13,10,'Highest number: ','$'       
.CODE 
strt:   
        mov ax,@data
        mov ds,ax    
    
        call Menu   
   
exit:
        mov ax,4c00h
        int 21h       
proc Menu
        pusha
        mov bp,sp
        
startOfMenu:
           
        lea dx,msg3              
        mov ah,09h
        int 21h                                                                                    
        
getNumberLabel:
        
        mov ah,1
        int 21h 
        
        cmp al,'1'
        je press1
        
        cmp al,'2'  
        je press2
        
        cmp al,'3' 
        je press3

        cmp al,'4' 
        je press4
        
        cmp al,'5' 
        je press5
         
        cmp al,'6' 
        je press6 
                 
        lea dx, msg4                
        mov ah, 09h
        int 21h
        jmp getNumberLabel
                
press1:
        
        call SetArray 
        jmp startOfMenu        
        
press2: 
        
        call LowestNum
        jmp startOfMenu  
        
press3:  

        call HighestNum
        jmp startOfMenu 
        
press4:
        
        
        jmp startOfMenu  
        
press5:
       
       
        jmp startOfMenu
        
press6:   
        popa
        ret    
endp Menu     
           
proc LowestNum  ;here
        pusha
        mov bp,sp
     
        mov cx,counter
        xor si,si
        xor bx,bx
        
checkLowestNum:
        
        mov ax,array[bx]
        mov dx,array[si]
        cmp ax,dx
        jb set
        jmp setEnd
set:                      
        mov si,bx
                  
setEnd:
        inc bx
        inc bx
                          
loop checkLowestNum        
                  
        mov ax, array[si]            
        
        push ax
        
        lea dx,msg5
        mov ah,09h
        int 21h 
        
        pop ax
         
        call print_ax
                             
        popa 
        ret     
endp LowestNum

proc HighestNum
        pusha   
        mov bp,sp
        
        mov cx,counter
        xor si,si
        xor bx,bx
        
checkHighestNum:
                
        mov ax,array[bx]
        mov dx,array[si]
        ;problem here if you remove the cmp it will work 
        ja set2
        jmp set2End
        
set2:
        mov si,bx
        
set2End:
        inc bx
        inc bx
        
loop checkHighestNum
        
        mov ax,array[si]
        
        push ax
        
        lea dx,msg6
        mov ah,09h
        int 21h 
        
        pop ax
        
        call print_ax                                      
               
        popa
        ret     
endp HighestNum        

print_ax proc
cmp ax, 0
jne print_ax_r
    push ax
    mov al, '0'
    mov ah, 0eh
    int 10h
    pop ax
    ret 
print_ax_r:
    pusha
    mov dx, 0
    cmp ax, 0
    je pn_done
    mov bx, 10
    div bx    
    call print_ax_r
    mov ax, dx
    add al, 30h
    mov ah, 0eh
    int 10h    
    jmp pn_done
pn_done:
    popa  
    ret  
endp     
           
proc SetArray  ;sets the array with values from the user  
        pusha
        mov bp,sp
        
        mov dx,offset msg0
        mov ah,09h
        int 21h
    
        call GetNumber
        xor bx,bx 
        mov counter,cx 
          
LoopGetNumbers:
        push cx
        
        mov ah,09h
        lea dx,crlf
        int 21h 
         
        call GetNumber
        mov array[bx],cx      
         
        inc bx
        inc bx 
        pop cx                 
loop LoopGetNumbers
           
        popa  
        ret
endp SetArray

proc GetNumber
        push bp
        mov bp,sp
        push ax
        push dx

; print the message1:
        mov dx, offset msg1
        mov ah, 9
        int 21h

        call ScanNum ; get the number to cx.
                
        pop dx
        pop ax
        pop bp
        ret  ;return to operating system.
endp GetNumber

; this macro prints a char in al and advances the current cursor position:
putc    macro   char
        push    ax
        mov     al, char
        mov     ah, 0eh
        int     10h     
        pop     ax
endm

; this procedure gets the multi-digit signed number from the keyboard,
; and stores the result in cx register:
proc ScanNum  
        push bp
        mov bp,sp
        push    dx
        push    ax
        push    si
        
        mov     cx, 0

        ; reset flag:
        mov     cs:make_minus, 0

next_digit:

        ; get char from keyboard
        ; into al:
        mov     ah, 00h
        int     16h
        ; and print it:
        mov     ah, 0eh
        int     10h

        ; check for minus:
        cmp     al, '-'
        je      set_minus

        ; check for enter key:
        cmp     al, 13  ; carriage return?
        jne     not_cr
        jmp     stop_input     
        
not_cr:

        cmp     al, 8                   ; 'backspace' pressed?
        jne     backspace_checked
        mov     dx, 0                   ; remove last digit by
        mov     ax, cx                  ; division:
        div     cs:ten                  ; ax = dx:ax / 10 (dx-rem).
        mov     cx, ax
        putc    ' '                     ; clear position.
        putc    8                       ; backspace again. 
        
        jmp     next_digit
backspace_checked:

        ; allow only digits:
        cmp     al, '0'
        jae     ok_ae_0
        jmp     remove_not_digit   
        
ok_ae_0:        
        cmp     al, '9'
        jbe     ok_digit
        
remove_not_digit:  
     
        putc    8       ; backspace.
        putc    ' '     ; clear last entered not digit.
        putc    8       ; backspace again.        
        jmp     next_digit ; wait for next input. 
              
ok_digit:

        ; multiply cx by 10 (first time the result is zero)
        push    ax
        mov     ax, cx
        mul     ten                  ; dx:ax = ax*10
        mov     cx, ax
        pop     ax

        ; check if the number is too big
        ; (result should be 16 bits)
        cmp     dx, 0
        jne     too_big

        ; convert from ascii code:
        sub     al, 30h

        ; add al to cx:
        mov     ah, 0
        mov     dx, cx      ; backup, in case the result will be too big.
        add     cx, ax
        jc      too_big2    ; jump if the number is too big.

        jmp     next_digit

set_minus: 

        mov     cs:make_minus, 1
        jmp     next_digit

too_big2:

        mov     cx, dx      ; restore the backuped value before add.
        mov     dx, 0       ; dx was zero before backup!
        
too_big:   

        mov     ax, cx
        div     cs:ten  ; reverse last dx:ax = ax*10, make ax = dx:ax / 10
        mov     cx, ax
        putc    8       ; backspace.
        putc    ' '     ; clear last entered digit.
        putc    8       ; backspace again.        
        jmp     next_digit ; wait for enter/backspace.
        
        
stop_input:

        ; check flag:
        cmp     cs:make_minus, 0
        je      not_minus
        neg     cx     
        
not_minus:
     
        pop     si
        pop     ax
        pop     dx 
        pop     bp
        ret       
        
endp ScanNum

END