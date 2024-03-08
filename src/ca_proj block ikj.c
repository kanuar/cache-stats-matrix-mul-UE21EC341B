#include <stdio.h>
#include <stdlib.h>

#define block 4
#define N 64

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

	for(int bi=0; bi<N; bi+=block)
        for(int bk=0; bk<N; bk+=block)
            for(int bj=0; bj<N; bj+=block)
                for(int i=0; i<block; i++)
                    for(int k=0; k<block; k++)
                        for(int j=0; j<block; j++)
                            matC[bi+i][bj+j] += matA[bi+i][bk+k]*matB[bk+k][bj+j];


	printf("[+] Calculated product \n");
	// for (int i = 0; i < N; ++i)
	// {
	// 	for (int j = 0; j < N; ++j)
	// 	{
	// 		printf("%d \t",matC[i][j] );
	// 	}
	// 	printf("\n");
	// }
	return 0;
}