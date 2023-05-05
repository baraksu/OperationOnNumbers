.MODEL small
.STACK 100h
.DATA        
array db 21dup(0)
msg db 13,10,'Enter number of numbers: ','$'        
msg0 db 13,10,'Enter number: ','$'
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
    
    mov ah,09h
    lea dx,msg0
    int 21h
    
    mov ah,01h
    int 21h
    sub al,30h
    mov 
    
    pop bp 
endp getNumbers    
END