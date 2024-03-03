#include <stdio.h>

void sort(int *arr,int n)
{
	if(n<2)
	{
		printf("[+] Reached base case \n" );
		return NULL;
	}
	printf("[+] Recursive call \n\n" );
	for (int i = 0; i < n/2; ++i)
	{
		int a1=*(arr+i),a2=*(arr+i+n/2);
		if(a1>a2)
		{
			a1=a1+a2;
			a2=a1-a2;
			a1=a1-a2;
		}
		*(arr+i)=a1;
		*(arr+i+n/2)=a2;
	}
	sort(arr,n/2);
	sort(arr+n/2,n/2);
}

void display(int *arr,int n)
{
	printf("[+] Entering display function \n");
	for (int i = 0; i < n; ++i)
	{
		printf("%d\n",*(arr+i));
	}
	printf("[+] exiting display function\n");
}

int main(int argc, char const *argv[])
{
	int arr[]={2,3,6,7,5,4,1,0};
	display(&arr,8);
	sort(&arr,8);
	display(&arr,8);
	return 0;
}