int num=666;//.data
int kkk;//.bss
int add(int a,int b)//.text
{
	num+=1;
	return a+b+num+kkk;
}
