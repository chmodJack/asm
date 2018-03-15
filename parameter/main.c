#include<stdio.h>
__attribute__((optimize("Ofast")))
int add()
{
	asm("ldr r0,=#66666688");
	asm("mov pc,lr");
}

__attribute__((optimize("O0")))
int test()
{
	char a=1;
	return 233;
}
int main(int argc,char* argv[])
{
	printf("hello %d\n",add(0,1,2,3));
    return 0;
}
