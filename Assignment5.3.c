#include <stdio.h>

main(void) {
	int userInput;
	int total = 0;
	int i = 0;

	while (i < 10) {
		printf("Enter a number: ");
		scanf("%d", &userInput);

		total += userInput;

		i++;
	}

	printf("Final total is: %d", total);
}
