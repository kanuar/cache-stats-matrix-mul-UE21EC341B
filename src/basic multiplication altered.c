#include<stdio.h>
#include<stdlib.h>

int **mat_gen(int m,int n)
{
    printf("[+] entering matrix generator function \n");
    int *res=(int*)malloc(sizeof(int)*(m*n));
    int **arr=&res;
    for (int i = 0; i < m; ++i)
    {
        // printf("\n\n");
        // printf("[+] entered for loop 1 with i=%d \n",i);
        for (int j = 0; j < n; ++j)
        {
            // printf("\n\n");
            // printf("[+] entered for loop 2 with j=%d \n",j);
            int temp=rand()%1000;
            *(res+i*m+j)=temp;
        }
    }
    printf("[+] exiting matrix generator function \n");
    return arr;
}


void display_mat(int **mat,int rows,int columns)
{
    printf("[+] entering display function \n");
    if(**mat==NULL)
    {
        printf("[-] Invalid Result \n");
        return NULL;
    }
    for (int i = 0; i < rows; ++i)
    {
        printf("[+] entering loop 1\n");
        for (int j = 0; j < columns; ++j)
        {
            printf("%d, (i=%d,j=%d)\t",*((*(mat)+i*columns)+j),i,j );
        }
        printf("\n");
    }
    printf("[+] exiting display function \n");
}

int** mul(int **arr1,int arr1_rows,int arr1_columns,int **arr2,int arr2_rows,int arr2_columns)
{
    printf("[+] entered multiplication function \n");
    // printf("[+] testing arrays\n");
    // display_mat(arr1,arr1_rows,arr1_columns);
    // printf("[+] testing complete for matrix 1\n\n");
    // display_mat(arr2,arr2_rows,arr2_columns);
    // printf("[+] testing complete for matrix 2\n\n");
    if(arr1_columns!=arr2_rows)
    {
        printf("[-] Invalid dimensions \n");
        return NULL;
    }
    int res_rows=arr1_rows,res_columns=arr2_columns;
    int *k2=(int*)malloc(sizeof(int)*(res_rows*res_columns));
    int **arr3=&k2;
    for (int i = 0; i < res_rows; ++i)
    {
        // printf("\n\n");
        printf("[+] entered for loop 1 with i=%d \n",i);
        for (int j = 0; j < res_columns; ++j)
        {
            // printf("\n\n");
            // printf("[+] entered for loop 2 with j=%d \n",j);
            int res=0;
            printf("\n");
            for (int k = 0; k < arr1_columns; ++k)
            {

                printf("[+] entered for loop 3 with i=%d, j=%d, k=%d \n",i,j,k);
                int val1=*((*(arr1)+i*arr1_columns)+k);
                int val2=*((*(arr2)+k*arr2_columns)+j);
                printf("val1->%d \t val2->%d\n",val1,val2 );
                int temp=((int)(val1))*((int)(val2));
                res+=temp;
            }
            // printf("[+] before storing result\n");
            *(k2+i*res_columns+j)=res;
            // printf("[+] stored result for i=%d and j=%d -> res=%d \n\n",i,j,res);
        }
    }
    
    return arr3;
}

int main(int argc, char const *argv[])
{
    int count;
    printf("enter no of counts : ");
    scanf("%d",&count);
    for (int i = 0; i < count; ++i)
    {
        printf("[+] iteration number : %d\n",i );
        int r1=rand()%10;
        int r2=rand()%10;
        int c1=r2;
        int c2=rand()%10;
        int *t1=*(mat_gen(r1,c1));
        int **t2=&t1;
        int *t3=*(mat_gen(r2,c2));
        int **t4=&t3;
        int *arr1=*(mul(t2,r1,c1,t4,r2,c2));
        int **arr2=&arr1;
        display_mat(arr2,r1,c2);
        printf("[+] exiting loop \n");
    }
    
    return 0;
}