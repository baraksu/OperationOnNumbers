.MODEL small
.STACK 100h
.DATA        
arrayOgNums db 100dup(0)
arrayNumsValueg db 100dup(0)
msg db 13,10,'Enter amount of numbers: ','$'        
msg0 db 13,10,'Enter number (enter "," to finish): ','$' 
msg1 db 13,10,'Enter next digit: ','$'     
msg2 db 13,10,'Wrong input enter new: '
counter db 0
.CODE
    mov ax,@data
    mov ds,ax    
    
    lea dx,msg
    mov ah,09h
    int 21h
    mov counter,al  
    call getNumbers
        
exit:
    mov ax,4c00h
    int 21h               
    
proc getNumbers
    push bp 
    mov bp,sp

    mov cx,counter     
    xor bx,bx
    
getNumbersLoop:  
    
    
getNumberLoop:
    
    lea dx,msg1
    mov ax,09
    int 21h
    
    mov ah,1
    int 21h
       
    call CheckInputOnAl
    
    mov arrayOgNums[bx],al
    cmp al,','
    je getNumbersLoop
    jmp getNumberLoop
    
    pop bp 
endp getNumbers     

proc CheckInputOnAl
    push bp 
    mov bp,sp     
    
strt:   

    cmp al,'0'
    jb error
    cmp al,'9'
    ja error
    cmp al,','
    jne error
    
error:

    lea dx,msg2
    mov ah,09
    int 21h 
    
    mov ah,01
    int 21h
    jmp strt 
    
finish:
                         
    pop bp           
endp CheckInput    
END  