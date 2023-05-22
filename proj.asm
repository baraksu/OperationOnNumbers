; version 102
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
     
    fnsh:
    call GetNumbersTrueValue     
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
     
    xor bx,bx 
    xor cx,cx
    mov cl,counter 
    mov dx,10d
    mov al,1d
    xor ah,ah
    xor si,si
    xor di,di
    
    mainConvertLoop:
    
    getNumberOfChars:
    push cx
    cmp arrayOgNums[bx],','
    je ConvertToValue   
    mul dx
    mov cx,ax
    xor ax,ax                                                                                        
    mov ah,1d
    inc bx
    jmp getNumberOfChars 
    
    ConvertToValue:
    cmp di,bx 
    je fn 
    mov al,arrayOgNums[di]                                      
    sub al,'0'
    mul cx
    add arrayNumsValue[si],ax
    mov ax,cx
    div dx
    mov cx,ax
    xor ax,ax
    jmp ConvertToValue

    jmp ConvertToValue
    
    fn:
    pop cx 
    inc bx 
    inc si
    mov di,bx
     
    loop mainConvertLoop        
         
    popa    
endp GetNumbersTrueValue  
END  