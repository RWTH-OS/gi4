#ifndef __GI4_INIT_H__
#define __GI4_INIT_H__

#ifdef __cplusplus
extern "C" {
#endif



/* show Matrix*/
void output_matrix(double*** mat, unsigned int n, unsigned int m);

/* frees all pointers below upper level of A */
void clean_matrix(double*** mat);

/* Creates empty NxM matrix */
int generate_empty_matrix(double*** mat, unsigned int n, unsigned int m);

/* Creates random NxM matrix */
int generate_random_matrix(double*** mat, unsigned int n, unsigned int m);

#ifdef __cplusplus
}
#endif

#endif
