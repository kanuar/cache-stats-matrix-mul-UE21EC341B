#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

#define NT 4
#define block 4
#define N 256
#define thrd_no omp_get_thread_num

int main(int argc, char const *argv[])
{
	int matA [N][N]={0};
	int matB [N][N]={0};
	int matC [N][N]={0};
	printf("[+] Created matrices \n");
	for (int i = 0; i < N; ++i)
	{
		for (int j = 0; j < N; ++j)
		{
			matA[i][j]=rand()%10;
			matB[i][j]=rand()%10;
		}
	}


	printf("[+] Initialized matrices \n");

	#pragma omp parallel num_threads(NT)
	{
		int tno = thrd_no();
		int seg=N/4*(tno+1);

		for(int bi=seg-(N/4); bi<seg; bi+=block)
	        for(int bk=seg-(N/4); bk<seg; bk+=block)
	            for(int bj=seg-(N/4); bj<seg; bj+=block)
	                for(int i=0; i<block; i++)
	                    for(int k=0; k<block; k++)
	                        for(int j=0; j<block; j++)
	                            matC[bi+i][bj+j] += matA[bi+i][bk+k]*matB[bk+k][bj+j];
	}

	printf("[+] Calculated product \n");
	return 0;
}