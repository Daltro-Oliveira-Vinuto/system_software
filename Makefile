all_gcc: clear_screen preprocess compile assemble link 
all_asm: clear_screen assemble_with_nasm link_with_ld 
go: clear_screen preprocess_compile_assemble_and_link 
debug: clear_screen debug_c


SRC = test
FLAGS = -m32 -masm=intel

# compile with gcc ---------------------------------------------------------
clear_screen:
	clear

list_files:
	ls
	$(info files in the directory:)

preprocess:
	gcc $(SRC).c -E > $(SRC).e
	$(info file preprocessed.)

#  sudo apt install gcc-multilib 
compile:
	gcc -Wall $(FLAGS) $(SRC).c -S 

	$(info file compiled..)

assemble:
	gcc $(FLAGS) $(SRC).s -c 
	$(info file avengers assembled...)

link:
	gcc $(FLAGS) $(SRC).o -o $(SRC).exe
	$(info file linked!)

preprocess_compile_assemble_and_link:
	gcc -Wall $(SRC).c -o $(SRC)
	$(info file $(SRC).c preprocessed, compiled, assembled and linked to $(SRC)(ELF)) 

# end compilation with gcc -------------------------------------------------

# compile with nasm and ld ---------------------------------------------------

# sudo apt install nasm 
assemble_with_nasm:
	nasm -f elf $(SRC).asm -o $(SRC).o
	$(info assembly file assembled with nasm)

link_with_ld:
	ld -m elf_i386 $(SRC).o -o $(SRC).exe
	$(info objects file linked with ld)

# end  compilation with nasm and ld --------------------------------------