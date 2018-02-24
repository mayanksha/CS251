#include <stdio.h>
void microkernel_msg(char *);
void microkernel_getmsg(char *);
int main(){
	printf("Hello world!\n");
	printf("This must be a monolithic design!\n");
	microkernel_msg("is more portable");
	return 0;
}
void microkernel_msg(char * a){
	printf("microkernel : %s\n", a);
}
void microkernel_getmsg(char *){
	//TODO getmsg feature
};
