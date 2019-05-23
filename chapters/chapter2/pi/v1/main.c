#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

int main(int argc, char **argv)
{
	double x, sum, step;
	long long i, num_steps = 1000000;
	struct timeval start, end;

	if (argc > 1)
		num_steps = atoll(argv[1]);
	if (num_steps < 100)
		num_steps = 1000000;
	printf("\nnum_steps = %lld\n", num_steps);

	gettimeofday(&start, NULL);

	sum = 0.0;
	step = 1.0 / (double)num_steps;

	for (i = 0; i < num_steps; i++) {
		x = (i + 0.5) * step;
		sum += 4.0 / (1.0 + x * x);
	}

	gettimeofday(&end, NULL);

	printf("PI = %f\n", sum * step);
	printf("Time : %lf sec\n", (double) (end.tv_sec - start.tv_sec) + (double) (end.tv_usec - start.tv_usec)/1000000.0);

	return 0;
}
