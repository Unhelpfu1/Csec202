#include <stdio.h>

float CalculatePay(int* hours, float* rate, float mult) {
	float pay;
	pay = *hours * *rate * mult;
	return pay;
}

main() {
	int hours_worked;
	float pay_rate;
	float final_pay;

	printf("Hours Worked: ");
	scanf("%d", &hours_worked);

	printf("Pay Rate: ");
	scanf("%f", &pay_rate);

	//printf("Hours: %d\nRate: %f\n", hours_worked, pay_rate);

	if (hours_worked <= 40) {
		final_pay = CalculatePay(&hours_worked, &pay_rate, 1.0);
	} 
	else if (hours_worked <= 50) {
		final_pay = CalculatePay(&hours_worked, &pay_rate, 1.5);
	}
	else if (hours_worked >50) {
		final_pay = CalculatePay(&hours_worked, &pay_rate, 2.0);
	}
	else {
		final_pay = 0;
	}

	/*printf("Hours: %d\nRate: %f\n", hours_worked, pay_rate);*/
	printf("Final Pay: %f\n", final_pay);
}
