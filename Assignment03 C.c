#include <stdio.h>

int CalculatePay(int* hours, int* rate, int* bonus) {
	int pay;

	pay = *hours * *rate;
	pay = pay + *bonus;

	return pay;
}

main() {
	int hours_worked;
	int pay_rate;
	int bonus;

	printf("Hours Worked: ");
	scanf("%d", &hours_worked);

	printf("Pay Rate: $");
	scanf("%d", &pay_rate);

	printf("Bonus Payment: $");
	scanf("%d", &bonus);

	int pay;
	pay = CalculatePay(&hours_worked, &pay_rate, &bonus);

	printf("Final Pay: %d", pay);
}
