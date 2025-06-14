production: clear_screen preprocess compile assemble link static_check
deployment: clear_screen preprocess compile_with_gdb assemble link static_check
asm: clear_screen assemble_with_nasm link_with_ld 
deploy: clear_screen preprocess_compile_assemble_and_link static_check
develop: clear_screen preprocess_compile_assemble_and_link_with_gdb static_check
debug: clear_screen debug_code
check: clear_screen static_check dynamic_check
run: clear_screen dynamic_check

COMPILER = gcc # or g++
SRC = hello
TYPE = .asm
FLAGS = -Wall -m32 -masm=intel
FLAGS_WITH_GDB = $(FLAGS) -g
ELF = $(SRC).exe
VALGRIND_OUT = valgrind.txt
VALGRIND_FLAGS = --leak-check=full # --track-origins=yes --show-leak-kinds=all # --log-file=$(VALGRIND_OUT) 



# compile with gcc ---------------------------------------------------------
clear_screen:
	clear

list_files:
	ls
	$(info files in the directory:)

preprocess:
	$(COMPILER) $(SRC)$(TYPE) -E > $(SRC).e
	$(info file preprocessed.) 

#  sudo apt install gcc-multilib 
compile:
	$(COMPILER) $(FLAGS) $(SRC)$(TYPE) -S > $(SRC).s
	$(info file compiled..)

compile_with_gdb:
	$(COMPILER) $(FLAGS_WITH_GDB) $(SRC)$(TYPE) -S  > $(SRC).s
	$(info file compiled..)


assemble:
	$(COMPILER) $(FLAGS) $(SRC).s -c 
	$(info file avengers assembled...)

link:
	$(COMPILER) $(FLAGS) $(SRC).o -o $(ELF)
	$(info file linked!)

preprocess_compile_assemble_and_link:
	$(COMPILER) $(FLAGS) $(SRC)$(TYPE) -o $(ELF)
	$(info file $(SRC).c preprocessed, compiled, assembled and linked to $(ELF)(ELF)) 

preprocess_compile_assemble_and_link_with_gdb:
	$(COMPILER) $(FLAGS_WITH_GDB) $(SRC)$(TYPE) -o $(ELF)
	$(info file $(SRC).c preprocessed, compiled, assembled and linked to $(ELF)(ELF) with gdb) 


# end compilation with gcc -------------------------------------------------


# compile with nasm and ld ---------------------------------------------------

# sudo apt install nasm 
assemble_with_nasm:
	# the $(TYPE) MUST be .asm
	nasm -f elf $(SRC)$(TYPE) -o $(SRC).o
	$(info assembly file assembled with nasm)

link_with_ld:
	ld -m elf_i386 $(SRC).o -o $(ELF)
	$(info objects file linked with ld)

# end  compilation with nasm and ld --------------------------------------

# start of debug code section ---------------------------------
debug_code:
	gdb $(ELF) -ex "b main" -ex "set disassembly-flavor intel" -ex "layout split" 

# end of debug code section ------------------------------------

# start of check_code section ---------------------------------------------

# sudo apt install pipx
# pipx install cpplint
static_check:
	cpplint $(SRC)$(TYPE)

# sudo apt install valgrind
# sudo apt install  libc6-dbg:i386
dynamic_check:
	valgrind $(VALGRIND_FLAGS) ./$(ELF)

#end of check_code section  ----------------------------------------------