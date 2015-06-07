#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>

#define N			100000000
#define RANGE_MAX		9999999
#define RANGE_MIN		0

int a[N];
int b[N];

/* Annahme: a ist zwischen lo und m und zwischen m+1 und hi sortiert */
void merge(int lo, int m, int hi)
{
	int i, j, k;

	/* beide Haelften von a in Hilffeld b kopieren */
	for (i = lo; i <= hi; i++)
		b[i] = a[i];

	i = lo;
	j = m + 1;
	k = lo;

	/* jeweils das naechstgroeßte Element zurueckkopieren */
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

int main(int argc, char **argv)
{
	int i;
	struct timeval start, end;

	/* "seed" auf die aktuelle Zeit setzen, um
	 * nicht immer die selben Zufallszahlen zu erhalten
	 */
        srand((unsigned)time(NULL));

	printf("Initialisiere Feld...\n");
	for (i = 0; i < N; i++)
		a[i] = (int) (((double)rand() / (double)(RAND_MAX + 1)) * (RANGE_MAX - RANGE_MIN) + RANGE_MIN);

	printf("Sortiere Feld...\n");

	gettimeofday(&start, NULL);
	mergesort(0, N - 1);
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
