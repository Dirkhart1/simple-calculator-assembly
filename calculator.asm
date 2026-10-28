; This is a calculator app to train my skills in assembly.
; Only .text and .data will be used

section .data ; Where our variables for be stored (data)
    ; db : databytes, used to allocate bytes to a string
    ; 0dh and 0ah , Means "end of line" and "Go to next line" respectively.
    ; We will declare the "length" of the message in the .text section
    welcome db 0dh, 0ah, 0dh, 0ah , "=============== Simple Calculator ===============", 0dh, 0ah, 0dh, 0ah

    ; This makes the length in bytes equal to "welcome"
    welcome_length equ $ - welcome

    choice db 0dh, 0ah, "Make your choice: "
    choice_length equ $ - choice

    operation db "1. Add", 0dh, 0ah, "2. Subtract", 0dh, 0ah, "3. Mutiply", 0dh, 0ah, "4. exit", 10
    operation_length equ $ - operation

    first_num db "enter 1st number: "
    first_num_length equ $ - first_num

    sec_num db "enter 2nd number: "
    sec_num_length equ $ - sec_num

    answer db "Answer: "
    answer_length equ $ - answer

    plus db "+"
    plus_length equ $ - plus

    minus db "-"
    minus_length equ $ - minus

    mult db "x"
    mult_length equ $ - mult

    equal db "="
    equal_length equ $ - equal

    tmp: db 0,0 ;
    first_temp: db 0,0 
    second_temp: db 0,0 



global _start ; Sets a "start" for assembly

section .text ; Code


    welcome_message:
        mov rax, 1 ; Write
        mov rdi, 1 ; stdout
        mov rsi, welcome    ; Welcome message
        mov rdx, welcome_length ; Reserves Bytes for the message
        syscall ; System call,  
        ret ; return to main loop
        
    operators:
        mov rax, 1
        mov rdi, 1
        mov rsi, operation
        mov rdx, operation_length
        syscall
        ret 
    get_choice:
        mov rax, 1
        mov rdi, 1
        mov rsi, choice
        mov rdx, choice_length
        syscall
        ret


    get_input:
        mov rax, 0 ;sys_read
        mov rdi, 0 ; 0 = stdin
        mov rsi, tmp ; @ tmp
        mov rdx, 2 ; 2 bytes , 1 for number and another for store newline
        syscall

    compare_input:
        cmp byte[rsi], "1" ; cmp , compare operator,
        je Add             ; je , if equal, jump to.
        cmp byte[rsi], "2"
        je Sub 
        cmp byte[rsi], "3"
        je Mul 
        cmp byte[rsi], "4"
        call exit 
        ret
        
    
    Add:
        mov rax, 1 ; write
        mov rdi, 1 ; stdout
        mov rsi, first_num
        mov rdx, first_num_length
        syscall

        mov rax, 0; read
        mov rdi, 0; stdin
        mov rsi, first_temp ; @ temp
        mov rdx, 2 ; 2 bytes
        syscall 

        mov r8, first_temp ; mov temp to register 8

        mov rax, 1
        mov rdi, 1
        mov rsi, sec_num
        mov rdx, sec_num_length
        syscall

        mov rax, 0
        mov rdi, 0
        mov rsi, second_temp
        mov rdx, 2
        syscall

        mov r9, second_temp; move temp to register 9.

        push r8
        push r9 ; puts onto stack

        mov r8, [first_temp]
        mov r9, [second_temp] ;moves contents of temp into registers

        sub r8, 48
        sub r9, 48; subtract 48 to get actual ASCII values.

        mov r10, r8 ; store register 8 to 10
        add r10, r9 ; add r9 to r10

        pop r9
        pop r8 ; pops from stack to use our values

        add r10, 48 ; add 48 to get our value in ASCII

        mov rax, 1
        mov rdi, 1
        mov rsi, answer
        mov rdx, answer_length
        syscall

        mov rax, 1
        mov rdi, 1
        mov rsi, r8 ; Displays r8 content
        mov rdx, 1  ; 1 byte
        syscall

        mov rax, 1
        mov rdi, 1
        mov rsi, plus
        mov rdx, plus_length
        syscall

        mov rax, 1
        mov rdi, 1
        mov rsi, r9 ; Displays r9 content
        mov rdx, 1  ; 1 byte
        syscall

        mov rax, 1
        mov rdi, 1
        mov rsi, equal
        mov rdx, equal_length
        syscall

        mov [rsp+8], r10

        mov rax, 0x1
        mov rdi, 1
        lea rsi, [rsp+8]    ; Displays operator message
        mov rdx, 1          ; 1 byte
        syscall
        
        jmp LOOP

    Sub:
      mov rax, 1 ; write
        mov rdi, 1 ; stdout
        mov rsi, first_num
        mov rdx, first_num_length
        syscall

        mov rax, 0; read
        mov rdi, 0; stdin
        mov rsi, first_temp ; @ temp
        mov rdx, 2 ; 2 bytes
        syscall 

        mov r8, first_temp ; mov temp to register 8

        mov rax, 1
        mov rdi, 1
        mov rsi, sec_num
        mov rdx, sec_num_length
        syscall

        mov rax, 0
        mov rdi, 0
        mov rsi, second_temp
        mov rdx, 2
        syscall

        mov r9, second_temp; move temp to register 9.

        push r8
        push r9 ; puts onto stack

        mov r8, [first_temp]
        mov r9, [second_temp] ;moves contents of temp into registers

        sub r8, 48
        sub r9, 48; subtract 48 to get actual ASCII values.

        mov r10, r8 ; store register 8 to 10
        sub r10, r9 ; add r9 to r10

        pop r9
        pop r8 ; pops from stack to use our values

        add r10, 48 ; add 48 to get our value in ASCII

        mov rax, 1
        mov rdi, 1
        mov rsi, answer
        mov rdx, answer_length
        syscall

        mov rax, 1
        mov rdi, 1
        mov rsi, r8 ; Displays r8 content
        mov rdx, 1  ; 1 byte
        syscall

        mov rax, 1
        mov rdi, 1
        mov rsi, minus
        mov rdx, minus_length
        syscall

        mov rax, 1
        mov rdi, 1
        mov rsi, r9 ; Displays r9 content
        mov rdx, 1  ; 1 byte
        syscall

        mov rax, 1
        mov rdi, 1
        mov rsi, equal
        mov rdx, equal_length
        syscall

        mov [rsp+8], r10

        mov rax, 0x1
        mov rdi, 1
        lea rsi, [rsp+8]    ; Displays operator message
        mov rdx, 1          ; 1 byte
        syscall

        jmp LOOP
    Mul:

        mov rax, 1 ; write
        mov rdi, 1 ; stdout
        mov rsi, first_num
        mov rdx, first_num_length
        syscall

        mov rax, 0; read
        mov rdi, 0; stdin
        mov rsi, first_temp ; @ temp
        mov rdx, 2 ; 2 bytes
        syscall 

        mov r8, first_temp ; mov temp to register 8

        mov rax, 1
        mov rdi, 1
        mov rsi, sec_num
        mov rdx, sec_num_length
        syscall

        mov rax, 0
        mov rdi, 0
        mov rsi, second_temp
        mov rdx, 2
        syscall

        mov r9, second_temp; move temp to register 9.

        push r8
        push r9 ; puts onto stack

        mov r8, [first_temp]
        mov r9, [second_temp] ;moves contents of temp into registers

        sub r8, 48
        sub r9, 48; subtract 48 to get actual ASCII values.

        mov r10, r8 ; store register 8 to 10
        mul r10, r9 ; add r9 to r10

        pop r9
        pop r8 ; pops from stack to use our values

        add r10, 48 ; add 48 to get our value in ASCII

        mov rax, 1
        mov rdi, 1
        mov rsi, answer
        mov rdx, answer_length
        syscall

        mov rax, 1
        mov rdi, 1
        mov rsi, r8 ; Displays r8 content
        mov rdx, 1  ; 1 byte
        syscall

        mov rax, 1
        mov rdi, 1
        mov rsi, mult
        mov rdx, mult_length
        syscall

        mov rax, 1
        mov rdi, 1
        mov rsi, r9 ; Displays r9 content
        mov rdx, 1  ; 1 byte
        syscall

        mov rax, 1
        mov rdi, 1
        mov rsi, equal
        mov rdx, equal_length
        syscall

        mov [rsp+8], r10

        mov rax, 0x1
        mov rdi, 1
        lea rsi, [rsp+8]    ; Displays operator message
        mov rdx, 1          ; 1 byte
        syscall

    exit:
        mov rax, 60 ;exit
        syscall

    _start: ; Assembly starts here.

    LOOP: ; Loops the code
        call welcome_message
        call operators
        call get_choice
        call get_input
        call compare_input

  