#include <stdio.h>

main(void) {
	int userInput;
	int total = 0;

	printf("Input a number: ");
	scanf("%d", &userInput);

	while (userInput > 0) {
		total += userInput;
		printf("Total is: %d\n", total);

		printf("Input a number: ");
		scanf("%d", &userInput);
	}

	printf("Final total is: %d", total);
}
