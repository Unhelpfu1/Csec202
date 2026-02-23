#include <stdio.h>

main(void) {
	int userInput;
	int total = 0;

	for (int i = 0; i < 10; i++) {
		printf("Enter a number: ");
		scanf("%d", &userInput);

		total += userInput;
	}

	printf("Final total is: %d", total);
}
