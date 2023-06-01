<<<<<<< HEAD
; version 1.04
=======
; version 104
>>>>>>> 30a8c333d27d71828dbe338b7bbcd1cdacf7856b
.MODEL small
.STACK 100h
.DATA        
msg0 db 13,10,'Enter amount of numbers. ','$'    ;this msg contains a string that asks for the amount of numbers syou want in the array
array dw 100 dup (0)  ;this is the array variable 
msg1 db 13,10, "supported values from -32768 to 65535",13,10  ; this msg asks for a number and tells you the range of working values
     db "enter the number: $" 
counter dw 0   ;this variable stores the amount of numbers in the array 
crlf db 13,10,'$',13,10  ;this variable is used to go down lines               
make_minus db ? ; used as a flag.
ten dw 10 ; used as multiplier. 
msg3 db 13,10,"_______________________________________________________",13,10     ;this is the menu msg
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
msg4 db 13,10,'Error in input enter again: ','$'  ;if there is an error in input this msg will display
msg5 db 13,10,'Lowest number: ','$'  ;msg to show lowest number
msg6 db 13,10,'Highest number: ','$' ;msg to show highest number     
msg7 db 13,10,'The array:',13,10,'$' ;used to print the array
comma db ' , ','$',;comma used to print array 
TwoDotsSpace db ': ','$';used to print array  
msg81 db 13,10,'the avg is: ','$'
msg82 db ' with remainder: ','$' 
remainder dw 0,'$' ;used as a place  to store the remainder when calculating the avg
quotient dw 0,'$'  ;used as a place  to store the quotient when calculating the avg  
sum db 0 ;used to store the sum of numbers in array
.CODE 
<<<<<<< HEAD
start:            ;this is the start of the code
=======
start:   
>>>>>>> 30a8c333d27d71828dbe338b7bbcd1cdacf7856b
        mov ax,@data
        mov ds,ax    
    
        call Menu ; this command calls the menu which is basically the program
   
exit:
        mov ax,4c00h
        int 21h       
proc Menu ;this procedure is the programs menu 
        pusha
        mov bp,sp
        
startOfMenu:
           
        lea dx,msg3   ;here we display the menu           
        mov ah,09h
        int 21h                                                                                    
        
getNumberLabel:    ;here we check what number the user inputed to know what procedure to do
        
        mov ah,1
        int 21h 
        
        cmp al,'1' ;this will ask you to enter the array
        je press1
        
        cmp al,'2' ;this will find the lowest number in the array
        je press2
        
        cmp al,'3' ;this will find the highest number in the array
        je press3

        cmp al,'4' ;this will calculate the avg of the numbers in the array
        je press4
        
        cmp al,'5' ;this will print all the numbers in the array
        je press5
         
        cmp al,'6' ;this will end the program
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
        call GetArrAvg
        jmp startOfMenu  
        
press5:
         
        jmp startOfMenu
        
press6:   
        popa
        ret     
endp Menu     
  
proc GetArrAvg
        pusha 
        mov bp,sp
        
        mov al,0FFh
        mul counter      
        mov ax,dx 
        mov cx,counter
        xor bx,bx       
        xor ax,ax
        l1:
        add ax,array[bx]       
        inc bx
        inc bx
        loop l1    
        cmp ax,dx
        jae bigAvg
        div counter
        mov b.remainder,ah
        mov b.quotient,al  
        jmp endAvg
        
        bigAvg: 
        div counter
        mov remainder,dx
        mov quotient,ax
                             
        endAvg:
                
        mov ah,09h
        lea dx,msg81
        int 21h
        
        mov ax,quotient
        call print_ax
        
        mov ah,09h
        lea dx,msg82
        int 21h
        
        mov ax,remainder
        call print_ax
        
        popa 
        ret
endp GetArrAvg     

proc PrintArray ; a procedure that prints the array 
        pusha 
        mov bp,sp
        
        mov ah,09h
        lea dx,msg7
        int 21h
         
        mov dl,' '
        mov ah,2h
        int 21h
         
        xor ax,ax
        xor bx,bx
        xor dx,dx
        inc dx
        mov cx,counter 
        jmp printArr2    
         
printArr:
        
        mov ah,09h
        lea dx,comma
        int 21h 

        
printArr2:
        pop dx 
        inc dx
        mov ax,dx
        call print_ax
        push dx
        
        mov ah,09h
        lea dx,TwoDotsSpace
        int 21h
        
        mov ax,array[bx]
        call print_ax
        
        pop dx
        inc bx
        inc bx
        push dx
        loop printArr
        
        popa
        ret 
endp PrintArray 
           
proc LowestNum ; a procedure that prints the lowest number 
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

proc HighestNum ; a procedure that prints that highest number
        pusha   
        mov bp,sp
        
        mov cx,counter
        xor si,si
        xor bx,bx
        
checkHighestNum:
                
        mov ax,array[bx]
        mov dx,array[si]
        cmp ax,dx
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

    
           
proc SetArray  ;sets the array with values from the user  
        pusha
        mov bp,sp
        
        mov dx,offset msg0
        mov ah,09h
        int 21h
    
        call ScanNum
        xor bx,bx 
        mov ax,cx
        mov counter,ax 
          
LoopGetNumbers:
        push cx
        
        mov ah,09h
        lea dx,crlf
        int 21h 
         
        call ScanNum
        mov array[bx],cx      
         
        inc bx
        inc bx 
        pop cx                 
loop LoopGetNumbers
           
        popa  
        ret
endp SetArray


; this macro prints a char in al and advances the current cursor position (used for ScanNum procedure):
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
        
        pusha
        mov dx, offset msg1
        mov ah, 9
        int 21h
        popa
        
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
  
<<<<<<< HEAD
print_ax proc   ; this procedure prints ax from hex to dec
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
        endp print_ax
=======
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
endp print_ax
>>>>>>> 30a8c333d27d71828dbe338b7bbcd1cdacf7856b

END start