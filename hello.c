#include <stdio.h>
void microkernel_msg(char *);
int main(){
	printf("Hello world!\n");
	printf("This must be a monolithic design!\n");
	microkernel_msg("is more portable");
	return 0;
}
void microkernel_msg(char * a){
	printf("microkernel : %s\n", a);
}
