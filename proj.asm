; version 1.08
.MODEL small
.STACK 100h
.DATA        
msg0 db 13,10,'Enter amount of numbers. ','$'    ;this msg contains a string that asks for the amount of numbers syou want in the array
array dw 100 dup (0)  ;this is the array variable 
msg1 db 13,10, "supported values from 000000 to 65535",13,10  ; this msg asks for a number and tells you the range of working values
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
     db       "³ To end program press: 5                             ³",13,10
     db       "³_____________________________________________________³",13,10 
     db       13,10,'$'
msg4 db 13,10,'Error in input enter again: ',13,10,'$'  ;if there is an error in input this msg will display
msg5 db 13,10,'Lowest number: ','$'  ;msg to show lowest number
msg6 db 13,10,'Highest number: ','$' ;msg to show highest number     
msg7 db 13,10,'The array:',13,10,'$' ;used to print the array
comma db ' , ','$',;comma used to print array 
TwoDotsSpace db ': ','$';used to print array  
msg81 db 13,10,'the avg is: ','$'
msg82 db ' with remainder: ','$' 
remainder dw 0,'$' ;used as a place  to store the remainder when calculating the avg
quotient dw 0,'$'  ;used as a place  to store the quotient when calculating the avg  
msg91 db 13,10,' ','$';msg that shows before entering number for array
msg92 db ' Numbers left for array',13,10,'$' ;second part of msg9  
msg10 db 13,10,'                             _   _     ',13,10         
      db       '                            | | (_)    ',13,10         
      db       '   ___  _ __   ___ _ __ __ _| |_ _  ___  _ __          ',13,10         
      db       '  / _ \|  _ \ / _ \  __/ _` | __| |/ _ \|  _ \',13,10           
      db       ' | (_) | |_) |  __/ | | (_| | |_| | (_) | | | |',13,10          
      db       '  \___/| .__/ \___|_|  \__,_|\__|_|\___/|_| |_|',13,10          
      db       '       | |  ',13,10                                               
      db       '   ___ |_|__    ',13,10                                             
      db       '  / _ \|  _ \           _',13,10                                
      db       ' | (_) | | | |         | |',13,10                               
      db       '  \___/|_| |_|_ __ ___ | |__   ___ _ __ ___  ',13,10            
      db       ' |  _ \| | | |  _ ` _ \|  _ \ / _ \  __/ __|',13,10             
      db       ' | | | | |_| | | | | | | |_) |  __/ |  \__ \',13,10             
      db       ' |_| |_|\__,_|_| |_| |_|_.__/ \___|_|  |___/      ','$',13,10           
       
.CODE 
start:            ;this is the start of the code
        mov ax,@data
        mov ds,ax    
        mov ah,09h
        lea dx,msg10 
        int 21h  
        call SetArray
        call Menu ; this command calls the menu which is basically the program
   
exit:
        mov ax,4c00h
        int 21h       

proc HighestNum ; a procedure that prints that highest number  ;does not get anything and does not return anything
        push bp
        mov bp,sp
        push ax
        push bx
        push cx
        push dx
        push si
     
        mov cx,[bp+4]
        xor si,si
        xor bx,bx
        
checkHighestNum:
        
        mov ax,array[bx]
        mov dx,array[si]
        cmp ax,dx
        ja set2
        jmp set2End
set2:                      
        mov si,bx
                  
set2End:
        add bx,2h
                          
loop checkHighestNum        
                  
        mov ax, array[si]            
        
        push ax
        
        lea dx,msg6
        mov ah,09h
        int 21h 
        
        pop ax
         
        call print_ax
                             
        pop si
        pop dx
        pop cx
        pop bx
        pop ax
        pop bp 
        ret 
endp HighestNum 

proc Menu ;this procedure is the programs menu ;does not get anything and does not return anything
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
         
        cmp al,'5' ;this will end the program
        je press5 
                 
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
        push counter       
        call HighestNum
        pop counter 
        jmp startOfMenu 
        
press4:
        call GetArrAvg
        jmp startOfMenu   
press5:     
        popa
        ret     
endp Menu 

proc LowestNum ; a procedure that prints the lowest number ;does not get anything and does not return anything
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
  
proc GetArrAvg  ;this procedure prints the array's average ;does not get anything and does not return anything
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

proc SetArray  ;sets the array with values from the user ;does not get anything and does not return anything 
        pusha
        mov bp,sp
        jmp l4
l3:     
        mov ah,09h
        lea dx,msg4
        int 21h
l4:   
        mov dx,offset msg0
        mov ah,09h
        int 21h
    
        call ScanNum 
        cmp cx,0
        je l3
        xor bx,bx 
        mov ax,cx
        mov counter,ax  
        xor ax,ax
        mov ax,1
        push ax
          
LoopGetNumbers:
        push cx
        
        mov ah,09h
        lea dx,crlf
        int 21h
        
        mov ah,09h
        lea dx,msg91
        int 21h     
        
        pop ax      
        call print_ax
        push ax
        
        mov ah,09h
        lea dx,msg92
        int 21h
         
        call ScanNum
        mov array[bx],cx      
         
        inc bx
        inc bx 
        pop cx                 
loop LoopGetNumbers
        pop ax
           
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

END start
