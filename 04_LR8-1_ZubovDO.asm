use16
org 100h

mov al, 0xb6
out 0x43, al  

call note_G1 ; 1
call note_D  ; 2
call note_A2 ; 3
call note_B2 ; 4
call note_A2 
call note_D
call note_D
call note_C ; 5 
call note_E ; 6
call note_D
call note_F ; 7   
call note_D

call long_timeout

call note_G1
call note_D
call note_A2
call note_B2
call note_A2
call note_D 
call note_D
call note_D
call note_C
call note_D
call note_B1 ; 8
call note_G1

call long_timeout

call note_G1
call note_D
call note_A2
call note_B2
call note_A2
call note_D
call note_D
call note_D
call note_C 
call note_D
call note_F    
call note_D    

call long_timeout

call note_G1
call note_D 
call note_D
call note_D
call note_A1 ; 9
call note_G2 ; 10
call note_D
call note_A2
call note_B2
call note_A2
call note_G1


exit:
	xor ax, ax
	mov ah, 0x4C
	int 21h

note_A1:
	pusha
	mov ax, (1190000/440)
    call note_settings        
	popa
	ret

note_A2:
	pusha
	mov ax, (1190000/880) 
	call note_settings          
	popa
	ret

note_B1:
	pusha
	mov ax, (1190000/494) 
	call note_settings     
	popa
	ret

note_B2:
	pusha
	mov ax, (1190000/988) 
	call note_settings       
	popa
	ret

note_C:
	pusha
	mov ax, (1190000/523) 
	call note_settings
	popa
	ret

note_D:
	pusha
	mov ax, (1190000/587) 
	call note_settings
	popa
	ret

note_E:
	pusha
	mov ax, (1190000/659) 
	call note_settings          
	popa
	ret

note_F:
	pusha
	mov ax, (1190000/698) 
	call note_settings          
	popa
	ret

note_G1:
	pusha
	mov ax, (1190000/392) 
    call note_settings
	popa
	ret

note_G2:
	pusha
	mov ax, (1190000/784) 
	call note_settings	          
	popa
	ret

note_settings:
    pusha
	out 0x42, al          
	mov al, ah            
	out 0x42, al
    call turn_on
    call timeout
    call turn_off
    call short_timeout
    popa
    ret


turn_on:
	pusha
	in al, 0x61
	or al, 00000011b    
	out 0x61, al         
	popa
	ret

short_timeout:               
    pusha

    xor ah,ah          
    int 1ah            

    add dx, 1

    call timeout_settings

    popa
    ret

turn_off:
	pusha
	in al, 0x61           
	and al, 11111100b
	out 0x61, al         
	popa
	ret

timeout:               
    pusha

    xor ah,ah          
    int 1ah            

    add dx, 5

    call timeout_settings

    popa
    ret

long_timeout:               
    pusha

    xor ah,ah          
    int 1ah            

    add dx, 10

    call timeout_settings

    popa
    ret

timeout_settings:
    mov bx, dx
    .wait:
    int 1ah      
    cmp dx, bx
    jl .wait
    ret
