#include<stdio.h>
void display_mat(int **mat,int rows,int columns)
{
    printf("[+] entering display function \n");
    for (int i = 0; i < rows; ++i)
    {
        // printf("[+] entering loop 1\n");
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
    printf("[+] entered function \n");
    // printf("[+] testing arrays\n");
    // display_mat(arr1,arr1_rows,arr1_columns);
    // printf("[+] testing complete for matrix 1\n\n");
    // display_mat(arr2,arr2_rows,arr2_columns);
    // printf("[+] testing complete for matrix 2\n\n");
    if(arr1_columns!=arr2_rows)
    {
        perror("[-] Invalid dimensions");
        exit(1);
    }
    int res_rows=arr1_rows,res_columns=arr2_columns;
    int *k2=(int*)malloc(sizeof(int)*(res_rows*res_columns));
    int **arr3=&k2;
    for (int i = 0; i < res_rows; ++i)
    {
        // printf("\n\n");
        // printf("[+] entered for loop 1 with i=%d \n",i);
        for (int k = 0; k < arr1_columns; ++k)
        {
            // printf("\n\n");
            // printf("[+] entered for loop 2 with j=%d \n",j);
            for (int j = 0; j < res_columns; ++j)
            {
                if(*(k2+i*res_columns+j)>100000)
                    *(k2+i*res_columns+j)=0;

                int val1=*((*(arr1)+i*arr1_columns)+k);
                int val2=*((*(arr2)+k*arr2_columns)+j);
                int temp=((int)(val1))*((int)(val2));
                // printf("[+] before storing result\n");
                *(k2+i*res_columns+j)+=temp;
                // printf("[+] stored result for i=%d and j=%d -> res=%d \n\n",i,j,res);
            }
        }
    }
    printf("[+] exiting mul function\n");
    return arr3;
}

int main(int argc, char const *argv[])
{
    
    int arr1[3][3]={{1,2,3},{4,5,6},{7,8,9}};
    int arr2[3][3]={{1,0,0},{0,1,0},{0,0,1}};
    // int arr1[2][2]={{1,2},{4,5}};
    // int arr2[2][2]={{1,0},{0,1}};
    int *arr3=&arr1;
    int **arr4=&arr3;
    int *arr5=&arr2;
    int **arr6=&arr5;
    int *arr7=*(mul(arr4,3,3,arr6,3,3));
    int **arr8=&arr7;
    display_mat(arr8,3,3);
    return 0;
}