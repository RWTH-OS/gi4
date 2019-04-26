#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <pthread.h>
#include <sys/time.h>

#define	MAX_THREADS	2 /* Die Anzahl der Threads muss eine Potenz von 2 sein. */
#define N		100000000
#define RANGE_MAX	9999999
#define RANGE_MIN	0

int a[N];
int b[N];

typedef struct {
	int count;
	int lo, hi;
} thread_param;

/* Annahme: a ist zwischen lo und m und zwischen m+1 und hi sortiert */
void merge(int lo, int m, int hi)
{
	int i, j, k;

	/* beide Haelften von a in Hilfsfeld b kopieren */
	for (i = lo; i <= hi; i++)
		b[i] = a[i];

	i = lo;
	j = m + 1;
	k = lo;

	/* jeweils das naechstgroesste Element zurueckkopieren */
	while ((i <= m) && (j <= hi)) {
		if (b[i] <= b[j])
			a[k++] = b[i++];
		else
			a[k++] = b[j++];
	}

	/* Rest der vorderen Haelfte falls vorhanden zurueckkopieren */
	while (i <= m)
		a[k++] = b[i++];
}

void mergesort(int lo, int hi)
{
	if (lo < hi) {
		int m = (lo + hi) / 2;

		mergesort(lo, m);
		mergesort(m + 1, hi);
		merge(lo, m, hi);
	}
}

void *thread_func(void *arg)
{
	int count = ((thread_param *) arg)->count;
	int lo = ((thread_param *) arg)->lo;
	int hi = ((thread_param *) arg)->hi;

	if (lo < hi) {
		int m = (lo + hi) / 2;

		if (count < MAX_THREADS) {
			pthread_t thread;
			thread_param thr_arg[2];

			thr_arg[0].lo = lo;
			thr_arg[0].hi = m;
			thr_arg[0].count = 2 * count;
			if (0 != pthread_create(&thread,
						NULL, thread_func, &(thr_arg[0]))) {
				exit(thr_arg[0].count);
			}

			thr_arg[1].lo = m + 1;
			thr_arg[1].hi = hi;
			thr_arg[1].count = 2 * count;

			thread_func(&(thr_arg[1]));

			pthread_join(thread, NULL);	/* Warten bis die Threads terminiert sind */
		} else {
			mergesort(lo, m);
			mergesort(m + 1, hi);
		}

		merge(lo, m, hi);
	}

	return 0;
}

int main(int argc, char **argv)
{
	int i;
	struct timeval start, end;
	pthread_t thread;
	thread_param thr_arg;

	/* 
	 *"seed" auf die aktuelle Zeit setzen, um
	 * nicht immer die selben Zufallszahlen zu erhalten
	 */
	srand((unsigned)time(NULL));

	printf("Initialisiere Feld...\n");
	for (i = 0; i < N; i++)
		a[i] =
		    (int)(((double)rand() / (double)(RAND_MAX + 1)) *
			  (RANGE_MAX - RANGE_MIN) + RANGE_MIN);

	printf("Sortiere Feld...\n");

	gettimeofday(&start, NULL);

	/* Initialisieren der Argumente fuer die Einstiegsfunktion */
	thr_arg.lo = 0;
	thr_arg.hi = N - 1;
	thr_arg.count = 1;

	if (0 != pthread_create(&(thread), NULL, thread_func, &(thr_arg))) {
		exit(1);
	}

	pthread_join(thread, NULL);	/* Warten bis die Threads terminiert sind */

	gettimeofday(&end, NULL);

	printf("Ueberpruefe, ob das Feld korrekt sortiert wurde...\n");
	for (i = 0; i < N - 1; i++) {
		if (a[i] > a[i + 1]) {
			printf("a[%d]=%d > a[%d]=%d\n", i, a[i], i + 1,
			       a[i + 1]);
			return -1;
		}
	}

	printf("Alles korrekt...\n");

	printf("Benoetigte Zeit : %lf sec\n", (double)(end.tv_sec-start.tv_sec)+(double)(end.tv_usec-start.tv_usec)/1000000.0);

	return 0;
}
