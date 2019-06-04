#include <emmintrin.h>
#include <stdalign.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

alignas(32) double step;
alignas(32) double sum;
alignas(32) long long num_steps = 1000000;

alignas(32) double four[] = {4.0, 4.0, 4.0, 4.0};
alignas(32) double two[] = {2.0, 2.0, 2.0, 2.0};
alignas(32) double one[] = {1.0, 1.0, 1.0, 1.0};
alignas(32) double ofs[] = {0.5, 1.5, 2.5, 3.5};

void calcPi(void)
{
	double x;
	long long i;

	for (i = 0; i < num_steps; i++) {
		x = (i + 0.5) * step;
		sum += 4.0 / (1.0 + x * x);
	}
}

#ifdef __SSE2__
void calcPi_intrinsic(void)
{
	const __m128d step_ = {step, step};
	const __m128d one_ = {1., 1.};
	const __m128d two_ = {2., 2.};
	const __m128d four_ = {4., 4.};

	__m128d sum_ = {0., 0.};
	__m128d ofs_ = {0.5, 1.5};

	for (size_t i = 0; i < num_steps; i += 2)
	{
		// Berechne (i + .5) * step
		const __m128d position_ = _mm_mul_pd(step_, ofs_);

		// Quadriere das Zwischenergebnis und erhöhe um eins
		const __m128d square_ = _mm_mul_pd(position_, position_);
		const __m128d denominator_ = _mm_add_pd(square_, one_);

		// Teile vier durch das Zwischenergebnis
		const __m128d summand_ = _mm_div_pd(four_, denominator_);

		// Summiere die ermittelten Rechteckshöhen auf
		sum_ = _mm_add_pd(sum_, summand_);

		// Erhöhe Offset
		ofs_ = _mm_add_pd(ofs_, two_);
	}

	sum = sum_[0] + sum_[1];
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
		num_steps = atoll(argv[1]);
	if (num_steps < 100)
		num_steps = 1000000;
	printf("\nnum_steps = %lld\n", num_steps);

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
