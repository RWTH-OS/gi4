#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <immintrin.h>

double step __attribute__ ((aligned(32)));
double sum __attribute__ ((aligned(32)));
int num_steps __attribute__ ((aligned(32))) = 1000000;

double four[] __attribute__ ((aligned(32))) = {4.0, 4.0, 4.0, 4.0};
double two[] __attribute__ ((aligned(32))) = {2.0, 2.0, 2.0, 2.0};
double one[] __attribute__ ((aligned(32))) = {1.0, 1.0, 1.0, 1.0};
double ofs[] __attribute__ ((aligned(32))) = {0.5, 1.5, 2.5, 3.5};

void calcPi(void)
{
	double x;
	int i;

	for (i = 0; i < num_steps; i++) {
		x = (i + 0.5) * step;
		sum += 4.0 / (1.0 + x * x);
	}
}

#ifdef __SSE2__
void calcPi_intrinsic(void)
{
	__m128d xmm0 = {0.0, 0.0};
	__m128d xmm1 = {step, step};
	__m128d xmm2 = *((__m128d*)ofs);
	__m128d xmm3, xmm4;
	int i;

	for(i = 0; i < num_steps; i+=2) {
		// Berechne (i+0.5f)*step
                xmm4 = __builtin_ia32_mulpd(xmm1, xmm2);

		// Quadriere das Zwischenergebniss
                // und erhöhe um eins
                xmm4 = __builtin_ia32_mulpd(xmm4, xmm4);
                xmm4 = __builtin_ia32_addpd(xmm4, *((__m128d*) one));

		// teile 4 durch das Zwischenergebnis
                xmm3 = *((__m128d*) four);
                xmm3 = __builtin_ia32_divpd(xmm3, xmm4);

                // Summiere die ermittelten Rechteckshöhen auf
                xmm0 = __builtin_ia32_addpd(xmm0, xmm3);

                //Laufzäler erhöhen und
                //zum Schleifenanfang springen
                xmm2 = __builtin_ia32_addpd(xmm2, *((__m128d*) two));
	}

	sum = xmm0[0] + xmm0[1];
}
#endif

int hasSSE2(void);
int hasAVX(void);
void calcPi_SSE(void);
void calcPi_AVX(void);
void calcPi_FPU(void);

int main(int argc, char **argv)
{
	struct timeval start, end;

	if (argc > 1)
		num_steps = atoi(argv[1]);
	if (num_steps < 100)
		num_steps = 1000000;
	printf("\nnum_steps = %d\n", (int)num_steps);

	gettimeofday(&start, NULL);

	sum = 0.0;
	step = 1.0 / (double)num_steps;

	calcPi();

	gettimeofday(&end, NULL);

	printf("PI = %f\n", sum * step);
	printf("Time : %lf sec\n", (double)(end.tv_sec-start.tv_sec)+(double)(end.tv_usec-start.tv_usec)/1000000.0);

	gettimeofday(&start, NULL);

	sum = 0.0;
	step = 1.0 / (double)num_steps;

	calcPi_FPU();

	gettimeofday(&end, NULL);

	printf("PI = %f (FPU)\n", sum * step);
	printf("Time : %lf sec (FPU)\n", (double)(end.tv_sec-start.tv_sec)+(double)(end.tv_usec-start.tv_usec)/1000000.0);

#ifdef __SSE2__
	if (hasSSE2()) {
		gettimeofday(&start, NULL);

		sum = 0.0;
		step = 1.0 / (double)num_steps;

		calcPi_intrinsic();

		gettimeofday(&end, NULL);
		printf("PI = %f (intrinsic)\n", sum * step);
		printf("Time : %lf sec (intrinsic)\n", (double)(end.tv_sec-start.tv_sec)+(double)(end.tv_usec-start.tv_usec)/1000000.0);
	}
#endif

	if (hasSSE2()) {
		gettimeofday(&start, NULL);

		sum = 0.0;
		step = 1.0 / (double)num_steps;

		calcPi_SSE();

		gettimeofday(&end, NULL);
		printf("PI = %f (SSE)\n", sum * step);
		printf("Time : %lf sec (SSE)\n", (double)(end.tv_sec-start.tv_sec)+(double)(end.tv_usec-start.tv_usec)/1000000.0);
	}

	if (hasAVX()) {
		gettimeofday(&start, NULL);

		sum = 0.0;
		step = 1.0 / (double)num_steps;

		calcPi_AVX();

		gettimeofday(&end, NULL);
		printf("PI = %f (AVX)\n", sum * step);
		printf("Time : %lf sec (AVX)\n", (double)(end.tv_sec-start.tv_sec)+(double)(end.tv_usec-start.tv_usec)/1000000.0);
	}

	return 0;
}
