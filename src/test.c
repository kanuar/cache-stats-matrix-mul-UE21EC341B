#include <stdio.h>

int main(int argc, char const *argv[])
{
	// int arr1[3][3]={{1,2,3},{4,5,6},{7,8,9}};
	// int * arr2= 
	// int **arr3=&arr2;
	// for (int i = 0; i < 3; ++i)
	// {
	// 	for (int j = 0; j < 3; ++j)
	// 	{
	// 		printf("%d\t",*(*(arr3+i)+j));
	// 	}
	// 	printf("\n");
	// }
	int a[2][3]={{1,2,3},{4,5,6}};
	int *b=&a;
	int **c=&b;
	printf("%d\n",a[1][1] );
	printf("%d\n",*(b+4) );
	printf("%d\n",*((*(c)+2)+2));
	return 0;
}