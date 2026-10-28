## Simple calculator using assembly
- A calculator program to relearn early assembly
    - This program is able to Add, Subtract, and Multiply
        - Cannot go past 1 digit/byte (By design)
        - Cannot divide (I'll do that some other time)

- This program makes use of registers and stacks (r8)

# How to compile
- Have nasm installed
    - On linux, sudo apt install nasm

- run "nasm -f elf64 -o calculator.o -l calculator.lst calculator.asm ld -static -o calculator calculator.o"
- run "./calculator"
