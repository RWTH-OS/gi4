#include <stdio.h>
#include <stdlib.h>
#include <string.h>



void output_matrix(double*** mat, unsigned int n, unsigned int m){
	unsigned int i, j;
	for(i=0; i<n; i++){
		for(j=0; j<m; j++)
			printf ("%8.2f\t",(*mat)[i][j]);
		printf("\n");
		}
}

int generate_random_matrix(double*** mat, unsigned int n, unsigned int m) {
	unsigned int iCnt;
	unsigned int i, j;

	if (mat == NULL) 	/* No memory allocated */
		return -1;	/* Error */

	*mat = (double**) malloc(n*sizeof(double*));

	if (*mat == NULL) 
		return -2;	/* Error */

	**mat = (double*) malloc(n*m*sizeof(double));

	if (**mat == NULL) {
		free(*mat);	/* Clean up */
		*mat = NULL;	
		return -2;	/* Error */
	}

	for(iCnt = 1;iCnt<n;iCnt++) { /* Assign pointers in the first "real index"; Value from 1 to N (0 yet set, value N means N+1) */
		(*mat)[iCnt] = &((*mat)[0][iCnt*m]);
	}

	for(i=0; i<n; i++)
		for(j=0; j<m; j++)
			(*mat)[i][j] = ((double)rand()) / ((double)RAND_MAX) * 10.0;

	return 0;
}

int generate_empty_matrix(double*** mat, unsigned int n, unsigned int m) {
	unsigned int iCnt;
	unsigned int i, j;

	if (mat == NULL) 	/* No memory allocated */
		return -1;	/* Error */

	*mat = (double**) malloc(n*sizeof(double*));

	if (*mat == NULL) 
		return -2;	/* Error */

	**mat = (double*) malloc(n*m*sizeof(double));

	if (**mat == NULL) {
		free(*mat);	/* Clean up */
		*mat = NULL;	
		return -2;	/* Error */
	}

	for(iCnt = 1;iCnt<n;iCnt++) { /* Assign pointers in the first "real index"; Value from 1 to N (0 yet set, value N means N+1) */
		(*mat)[iCnt] = &((*mat)[0][iCnt*m]);
	}

	for(i=0; i<n; i++)
		for(j=0; j<m; j++)
			(*mat)[i][j] = 0.0;

	return 0;
}

void clean_matrix(double*** mat) {
	if (mat != NULL) {
		if (*mat != NULL) {
			if (**mat != NULL) 
				free(**mat);
			free(*mat);
			*mat = NULL;
		}
	}
}