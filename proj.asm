; version 101
.MODEL small
.STACK 100h
.DATA        
arrayOgNums db 100dup(0)
arrayNumsValue dw 100dup(0)
msg db 13,10,'Enter amount of numbers: ','$'        
msg0 db 13,10,'Enter number (enter "," to finish)','$' 
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
    pusha
    mov bp,sp
     
    mov cl,counter    
    xor ch,ch
    xor bx,bx
    
    getNumbersLoop:  
    
    cmp cx,0
    jbe fnsh 
    dec cx
    
    mov ah,09h           
    lea dx, msg0           
    int 21h 
    
    getNumberLoop:
    
    lea dx,msg1
    mov ah,09
    int 21h
    
    mov ah,1
    int 21h
       
    call CheckInputOnAl ;call a procedure that checks if the input is correct
    
    mov arrayOgNums[bx],al                                                 
    inc bx     
    cmp al,','         ;checks if the user has finished inputing the number
    je getNumbersLoop  
    jmp getNumberLoop   
    call GetNumbersTrueValue
     
    fnsh:     
    popa
    ret
endp GetNumbers     

proc CheckInputOnAl           
    push bp 
    mov bp,sp     
    push dx
    
    strt:   
    
    cmp al,','
    je finish
    cmp al,'0'
    jl error
    cmp al,'9'
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
    ret              
endp CheckInputOnAl  

proc GetNumbersTrueValue
    pusha
    mov bp,sp                       
    
    xor si,si
    xor cx,cx   
    mov cl,counter            
    xor bx,bx      
    xor ax,ax
    mov al,1h 
    xor di,di
    mov dx,10d  
    
    convertCharNumToTrueNumLoop:
    mov di,bx 
    dec di   
      
    getNumberOfDigits:    
    
    cmp arrayOgNums[bx],','
    je convCharToNum
    mul dx
    inc bx
    jmp getNumberOfDigits
    
    convCharToNum:   
    inc di    
    push ax
    sub arrayOgNums[di],'0'       
    mul arrayOgNums[di]
    add arrayNumsValue[si],ax
    pop ax
    div dx        
    add arrayOgNums[di],'0'
    cmp arrayOgNums[di+1],','
    jne convCharToNum
     
    inc si 
    inc bx
    loop convertCharNumToTrueNumLoop                            
                              
    popa      
    ret    
endp GetNumbersTrueValue  
END  