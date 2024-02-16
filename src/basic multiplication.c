#include<stdio.h>

int** mul(int **arr1,int a,int b,int **arr2,int c,int d)
{
    if(b!=c)
    {
        perror("[-] Invalid dimensions");
        exit(1);
    }
    int res_m=a,res_n=d;
    int arr3[3][3]={0};
    for (int m = 0; m < res_m; ++m)
    {
        for (int n = 0; n < res_n; ++n)
        {
            int res=0;
            for (int k = 0; k < b; ++k)
            {
                res+=(*((*(arr1+m))+k))*(*((*(arr2+k))+n));
            }
            *(*(arr3+n)+m)=res;
        }
    }
    return arr3;
}

int main(int argc, char const *argv[])
{
    
    int arr1[3][3]={{1,2,3},{4,5,6},{7,8,9}};
    int arr2[3][3]={{1,0,0},{0,1,0},{0,0,1}};
    int arr3[3][3]=mul(arr1,3,3,arr2,3,3);
    for (int i = 0; i < 3; ++i)
    {
        for (int j = 0; j < 3; ++j)
        {
            printf("%d\t",arr3[i][j] );
        }
        printf("\n");
    }
    return 0;
}