#include <stdio.h>


void display_mat(int **mat,int rows,int columns)
{
	for (int i = 0; i < rows; ++i)
	{
		for (int j = 0; j < columns; ++j)
		{
			printf("%d, (i=%d,j=%d)\t",*((*(mat)+i*columns)+j),i,j );
		}
		printf("\n");
	}
}

int main(int argc, char const *argv[])
{
	int arr1[3][3]={{1,2,3},{4,5,6},{7,8,9}};
    int arr2[3][3]={{1,0,0},{0,1,0},{0,0,1}};
    int arr3[3][3]={0};

    for (int i = 0; i < 3; ++i)
    {
    	for (int j = 0; j < 3; ++j)
    	{
    		int res=0;
    		for (int k = 0; k < 3; ++k)
    		{
    			res+=arr1[i][k]*arr2[k][j];
    		}
    		arr3[i][j]=res;
    	}
    }

    for (int i = 0; i < 3; ++i)
    {
    	for (int j = 0; j < 3; ++j)
    	{
    		printf("%d \t",arr3[i][j] );
    	}
    	printf("\n");
    }
}


