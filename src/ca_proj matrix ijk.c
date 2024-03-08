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

	for (int i = 0; i < N; ++i)
	{
		for (int j = 0; j < N; ++j)
		{
			int res=0;
			for (int k = 0; k < N; ++k)
			{
				res+=matA[i][k]*matB[k][j];
			}
			matC[i][j]=res;
		}
	}
	printf("[+] Calculated product \n");
	for (int i = 0; i < N; ++i)
	{
		for (int j = 0; j < N; ++j)
		{
			printf("%d \t",matC[i][j] );
		}
		printf("\n");
	}
	return 0;
}