#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <sys/time.h>

#define MAX_THREADS		2

long long num_steps = 1000000;
double step, sum;

typedef struct {
	long long start, end;
} thread_param;

void *thread_func(void *arg)
{

	thread_param *thr_arg = (thread_param *) arg;
	double x;
	long long i;

	for (i = thr_arg->start; i < thr_arg->end; i++) {
		x = (i + 0.5) * step;
		sum += 4.0 / (1.0 + x * x);
	}

	return 0;
}

int main(int argc, char **argv)
{
	int i;
	struct timeval start, end;
	pthread_t threads[MAX_THREADS];
	thread_param thr_arg[MAX_THREADS];

	if (argc > 1)
		num_steps = atoll(argv[1]);
	if (num_steps < 100)
		num_steps = 1000000;
	printf("\nnum_steps = %lld\n", num_steps);

	gettimeofday(&start, NULL);

	sum = 0.0;
	step = 1.0 / (double)num_steps;

	/* Create MAX_THREADS worker threads. */
	for (i = 0; i < MAX_THREADS; i++) {
		/* initialize arguments of the thread  */
		thr_arg[i].start = i * (num_steps / MAX_THREADS);
		thr_arg[i].end = (i + 1) * (num_steps / MAX_THREADS);

		pthread_create(&(threads[i]), NULL, thread_func, &(thr_arg[i]));
	}

	/* Wait until all threads have terminated */
	for (i = 0; i < MAX_THREADS; i++)
		pthread_join(threads[i], NULL);
	gettimeofday(&end, NULL);

	printf("PI = %f\n", sum * step);
	printf("Time : %lf sec\n", (double)(end.tv_sec - start.tv_sec)+(double)(end.tv_usec - start.tv_usec)/1000000.0);

	return 0;
}
