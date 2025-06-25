deployment: clear_screen preprocess compile assemble link static_check
development: clear_screen preprocess compile_with_gdb assemble link static_check
x86: clear_screen assemble_with_nasm_x86 link_with_ld_x86
x64: clear_screen assemble_with_nasm_x64 link_with_ld_x64
deploy: clear_screen preprocess_compile_assemble_and_link static_check
develop: clear_screen preprocess_compile_assemble_and_link_with_gdb static_check
debug_c: clear_screen debug_c_code
debug_asm: clear_screen debug_asm_code
check: clear_screen static_check dynamic_check
load: clear_screen dynamic_check
obj: clear_screen objdump_x objdump_S
elf: clear_screen elf_objdump_x elf_objdump_S


COMPILER := gcc # gcc or g++
# only one file must had a main function(_start symbol)
PROJECT := hello
SRC_FILE := hellox64#main
TYPE := .asm # .c or .cpp or .asm or nothing
SRC := ../src/$(SRC_FILE)# or src/*.c or src/*.cpp
FLAGS :=  -Wall -masm=intel -m32# -std=c++17 or -m32 -v -m64
FLAGS_WITH_GDB := $(FLAGS) -g
ELF := $(PROJECT).elf
VALGRIND_OUT := valgrind.txt
VALGRIND_FLAGS := --leak-check=full # --track-origins=yes --show-leak-kinds=all # --log-file=$(VALGRIND_OUT) 
INCLUDE := -I./../include/  # -I/usr/include/SDL2 -Iinclude/
LINK := -L./../lib/ #-ltest -lSDL2main -lSDL2 -lSDL2_image -lSDL2_ttf -lSDL2_mixer -lm
FILE_TO_DUMP := $(SRC_FILE)# $(SRC_FILE)

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
	$(COMPILER) $(SRC)$(TYPE) $(FLAGS)  -S 
	$(info file compiled..)

compile_with_gdb:
	$(COMPILER) $(SRC)$(TYPE) $(FLAGS_WITH_GDB)  -S  
	$(info file compiled..)

assemble:
	$(COMPILER) *.s $(FLAGS) -c 
	$(info file avengers assembled...)

link:
	$(COMPILER) *.o $(FLAGS) $(INCLUDE) $(LINK) -o $(ELF)
	$(info file linked!)

preprocess_compile_assemble_and_link:
	$(COMPILER) $(SRC)$(TYPE) $(FLAGS) $(INCLUDE) $(LINK)  -o $(ELF)
	$(info file $(SRC).c preprocessed, compiled, assembled and linked to $(ELF)(ELF)) 

preprocess_compile_assemble_and_link_with_gdb:
	$(COMPILER) $(SRC)$(TYPE) $(FLAGS_WITH_GDB) $(INCLUDE) $(LINK)  -o $(ELF)
	$(info file $(SRC).c preprocessed, compiled, assembled and linked to $(ELF)(ELF) with gdb) 


# end compilation with gcc -------------------------------------------------


# compile with nasm and ld ---------------------------------------------------

# sudo apt install nasm
# the $(TYPE) MUST be .asm
assemble_with_nasm_x86:
	nasm $(SRC)$(TYPE) -g -f elf32 -o $(SRC).o  
	$(info assembly file assembled with nasm)


link_with_ld_x86:
	ld $(SRC).o -m elf_i386 -o $(ELF)
	$(info objects file linked with ld)


assemble_with_nasm_x64:
	nasm $(SRC)$(TYPE) -g -f elf64 -o $(SRC).o  
	$(info assembly file assembled with nasm)


link_with_ld_x64:
	ld $(SRC).o -o $(ELF)
	$(info objects file linked with ld)


# end  compilation with nasm and ld --------------------------------------

# start of debug code section ---------------------------------
debug_c_code:
	gdb $(ELF) -ex "set disassembly-flavor intel" -ex "layout split" -ex "b main" -ex "r" 

debug_asm_code:
	gdb $(ELF) -ex "set disassembly-flavor intel" -ex "layout asm"  -ex "layout regs" -ex "b _start" -ex "r" 

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

# end of check_code section  ----------------------------------------------

# show object code headers(symbol table, external symbol table, global symbol table) -----
objdump_x:
	objdump -x --disassembler-options=intel-mnemonic  $(SRC).o > $(SRC_FILE).obj

objdump_S:
	objdump -S --disassembler-options=intel-mnemonic  $(SRC).o >> $(SRC_FILE).obj

elf_objdump_x:
	objdump -x --disassembler-options=intel-mnemonic  $(ELF) > $(ELF).obj

elf_objdump_S:
	objdump -S --disassembler-options=intel-mnemonic  $(ELF) >> $(ELF).obj

# end of object code information -------------------------------------------