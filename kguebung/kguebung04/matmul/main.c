#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>
#include <string.h>
#include <math.h>

#include "init.h"

#define	L 1024
#define M	1024
#define N 512

double** A;
double** B;
double** C;

int main(int argc, char* argv[])
{
	unsigned int i, j, k;
	int ret;
	struct timeval start, end;

	// init random number generator
	srand((unsigned) time(NULL));

	printf("\nInitialize matrices...\n");
	ret = generate_random_matrix(&A, L, M);
	if (ret != 0)
		return ret;
	ret = generate_random_matrix(&B, M, N);
	if (ret != 0)
		return ret;
	ret = generate_empty_matrix(&C, L, N);
	if (ret != 0)
		return ret;

	printf("Start multiplication...\n");

	gettimeofday(&start, NULL);
  
	/*
   * TODO: Hier den eigenen Code einfügen!
   */
  
	gettimeofday(&end, NULL);

	if ((N<=8) && (L<=8) && (M<=8)){
		printf("Matrix A\n");
		  output_matrix(&A,L,M);
		printf("Matrix B\n");
		  output_matrix(&B,M,N);
		printf("Matrix C\n");
  		  output_matrix(&C,L,N);
	}
	printf("Time : %lf sec\n",  (double) (end.tv_sec - start.tv_sec)
		+ (double)(end.tv_usec - start.tv_usec) / 1000000.0);

	// frees the allocated memory
	clean_matrix(&C);
	clean_matrix(&B);
	clean_matrix(&A);

	return 0;
}
