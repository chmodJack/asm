/*************************************************************************
    > File Name       : main.c
    > Author          : chmodJack
    > Mail            : 158754845@qq.com
    > GitHub          : https://github.com/chmodJack 
    > Created Time    : 2018年03月14日 星期三 11时19分53秒
    > Description     : 
*************************************************************************/

/*
int init(int a,int b,int c,int d)
{
	d=a+b+c+d;
	return 0;
}
*/
#define LED_ADDR 0xffff0004
int main(int num,const char* str)
{
	char* p=LED_ADDR;
	*p='k';
	char cc=*p;
	return 0;
}
