// "Copyright [2025] <Copyright Daltro Oliveira Vinuto>"
#include <stdio.h>

extern int function_from_other_file();


int function_one() {
    printf("This is function one\n");
    return 0;
}

int function_two() {
    printf("This is function two\n");
    return 0;
}


static int function_static() {
    printf("This function can only be accessed inside this file!\n");
    //function_from_other_file();
    return 0;
}