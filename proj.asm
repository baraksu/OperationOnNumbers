.MODEL small
.STACK 100h
.DATA        
arrayOgNums db 100dup(0)
arrayNumsValueg db 100dup(0)
msg db 13,10,'Enter amount of numbers: ','$'        
msg0 db 13,10,'Enter number (enter "," to finish): ','$' 
msg1 db 13,10,'Enter next digit: ','$'     
msg2 db 13,10,'Wrong input enter new: ','$'
counter db 0
.CODE
    mov ax,@data
    mov ds,ax    
    
    lea dx,msg       
    mov ah,09h
    int 21h 
    
    mov ah,01
    int 21h
    
    sub al,'0'
    mov counter,al  
    call GetNumbers
        
exit:
    mov ax,4c00h
    int 21h               
    
proc GetNumbers    ;gets the numbers from the user 
    push bp 
    mov bp,sp
    push bx
    push cx 
    push dx
    push ax
 
    mov cl,counter    
    xor ch,ch
    xor bx,bx
    
    getNumbersLoop:  
    
    getNumberLoop:
    
    lea dx,msg1
    mov ah,09
    int 21h
    
    mov ah,1
    int 21h
       
    call CheckInputOnAl ;call a procedure that checks if the input is correct
    
    mov arrayOgNums[bx],al
    cmp al,','         ;checks if the user has finished inputing the number
    je getNumbersLoop  
    jmp getNumberLoop
         
    pop ax        
    pop dx
    pop cx   
    pop bx
    pop bp 
endp GetNumbers     

proc CheckInputOnAl           ;rn here
    push bp 
    mov bp,sp     
    push dx
    
    strt:   
    
    cmp al,44h
    je finish
    cmp al,30h
    jl error
    cmp al,39h
    jg error
    jmp finish
    
    error:

    lea dx,msg2
    mov ah,09
    int 21h 
    
    mov ah,01
    int 21h
    jmp strt 
    
    finish:
     
    pop dx                   
    pop bp               
endp CheckInputOnAl  
  
END  