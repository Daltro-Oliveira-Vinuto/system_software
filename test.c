// Copyright 2025 <Copyright Daltro Oliveira Vinuto>"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#define NAME_SIZE 255

typedef struct person {
  int code;
  char* name;
  int name_size;
  double net_worth;
  double salary;
  void (*print)(struct person*);
} person_t;


void print_person(person_t *person) {
    fprintf(stdout, "========== print person ============\n");
    printf("Person code: %d\n", person->code);
    printf("Person name: %s\n",  person->name);
    printf("Person net worth: %.1f\n", person->net_worth);
    printf("Person salary: %.1f\n", person->salary);
    printf("========== end print person ============\n\n");
}

void print_name(person_t *person) {
    printf("Person name: %s\n\n", person->name);
}



person_t* create_person(int code, char* name, int name_size, double net_worth,
                        void (*print_function)(person_t*)
                        ) {
    person_t *person;

    person = (person_t*) malloc(sizeof(person_t)*1);
    person->name_size = name_size;
    person->name = (char*) malloc(sizeof(char)*(name_size+1));
    snprintf(person->name, sizeof(char)*person->name_size, "%s", name);

    person->code = code;
    person->net_worth = net_worth;

    person->print = print_function;
    person->salary = net_worth;

    return person;
}


person_t *create_person_from_stdin(void) {
    person_t *person;

    // this would result in "core dumped":
    // person = (person_t*) malloc(sizeof(person_t*)*1);
    person = (person_t*) malloc(sizeof(person_t)*1);
    person->name_size = NAME_SIZE;
    person->name = (char*)malloc(sizeof(int)*(person->name_size+1));
    person->print = print_person;

    printf("Type the person name: ");
    fscanf(stdin, "%s", (person->name));
    printf("Type the person code: ");
    scanf("%d", &(person->code));
    printf("Type the person net worth: ");
    scanf("%lf", &(person->net_worth));

    person->salary = person->net_worth;

    return person;
}


void delete_person(person_t* person) {
    free(person->name);
    person->name = NULL;
    free(person);
    person = NULL;
}

int main() {
    // person_t *person1 = create_person(777, "Newton", 6, 7.5, print_person);
    person_t *person1 = create_person_from_stdin();

    printf("compiled with success!\n");
    person1->print(person1);
    person1->print = print_name;
    person1->print(person1);

    person1->print = print_person;
    person1->print(person1);

    delete_person(person1);
    return 0;
}
