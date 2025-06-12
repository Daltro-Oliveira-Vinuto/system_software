#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

typedef struct person {
  int code;
  char* name;
  int name_size;
  double net_worth;
  double salary;
  void (*print)(struct person*);
} person_t;

void print_person(person_t *person) {
	fprintf(stdout,"========== print person ============\n");
	fprintf(stdout,"Person code: %d\n", person->code);
	fprintf(stdout,"Person name: %s\n", person->name);
	fprintf(stdout,"Person net worth: %.1f\n", person->net_worth);
	fprintf(stdout,"Person salary: %.1f\n", person->salary);
	fprintf(stdout,"========== end print person ============\n\n");

}

void print_name(person_t *person) {
	fprintf(stdout, "Person name: %s\n\n", person->name);
}


person_t* create_person(int code, char* name, int name_size, double net_worth, void (*print_function)(person_t*)) {
	person_t *person;

	person = (person_t*) malloc(sizeof(person_t)*1);
	person->name = (char*) malloc(sizeof(char)*(name_size+1));
	strcpy(person->name, name);

	person->code = code;
	person->name_size = name_size;
	person->net_worth = net_worth;

	person->print = print_function;

	return person;
}

person_t *create_person_from_stdin(void) {
	person_t *person;

	person = (person_t*) malloc(sizeof(person_t*)*1);
	person->name_size = 100;
	person->name = (char*)malloc(sizeof(int)*(person->name_size+1));
	person->print = print_person;

	fprintf(stdout, "Type the person name: ");
	fscanf(stdin, "%s", (person->name));
	fprintf(stdout, "Type the person code: ");
	fscanf(stdin, "%d", &(person->code));
	fprintf(stdout, "Type the person net worth: ");
	fscanf(stdin, "%lf", &(person->net_worth));

	return person;
}

void delete_person(person_t* person) {
	free(person->name);
	person->name = NULL;
	free(person);
	person = NULL;
}

int main() {

	//person_t *person1 = create_person(777, "Newton", 6, 7.5, print_person);
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