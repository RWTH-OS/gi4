#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <sys/time.h>

#define MAX_THREADS		2

double four[] __attribute__ ((aligned(16))) = {4.0, 4.0};
double two[] __attribute__ ((aligned(16))) = {2.0, 2.0};
double one[] __attribute__ ((aligned(16))) = {1.0, 1.0};
double ofs[] __attribute__ ((aligned(16))) = {0.5, 1.5};

int num_steps = 1000000;
double step;

typedef struct {
	double sum;
	int start, end;
} thread_param;

extern void calcPi_SSE_thread(int, int, double *);

void *thread_func(void *arg)
{
	thread_param *thr_arg = (thread_param *) arg;
	double sum = 0.0;
	int start = thr_arg->start;
	int end = thr_arg->end;

	calcPi_SSE_thread(start, end, &sum);
	thr_arg->sum = sum;

	return 0;
}

int main(int argc, char **argv)
{

	double sum;
	int i;
	struct timeval start, end;
	pthread_t threads[MAX_THREADS];
	thread_param thr_arg[MAX_THREADS];

	if (argc > 1)
		num_steps = atoi(argv[1]);
	if (num_steps < 100)
		num_steps = 1000000;

	printf("\nnum_steps = %d\n", (int)num_steps);
	
	gettimeofday(&start, NULL);

	sum = 0.0;
	step = 1.0 / (double)num_steps;

	/* Create MAX_THREADS worker threads. */
	for (i = 0; i < MAX_THREADS; i++) {
		/* initialize arguments of the thread  */
		thr_arg[i].start = i * (num_steps / MAX_THREADS);
		thr_arg[i].end = (i + 1) * (num_steps / MAX_THREADS);
		thr_arg[i].sum = 0.0;
		pthread_create(&(threads[i]), NULL, thread_func, &(thr_arg[i]));
	}

	/* Wait until all threads have terminated 
	   and calculate sum*/
	for (i = 0; i < MAX_THREADS; i++) {
		pthread_join(threads[i], NULL);
		sum += thr_arg[i].sum;
	}

	gettimeofday(&end, NULL);

	printf("PI = %f\n", sum * step);
	printf("Time : %lf sec\n", (double)(end.tv_sec-start.tv_sec)+(double)(end.tv_usec-start.tv_usec)/1000000.0);

	return 0;
}
