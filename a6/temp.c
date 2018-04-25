/******************************************************************************
 * FILE: hello.c
 * DESCRIPTION:
 *   A "hello world" Pthreads program.  Demonstrates thread creation and
 *   termination.
 * AUTHOR: Blaise Barney
 * LAST REVISED: 08/09/11
 ******************************************************************************/
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#define NUM_THREADS	5

struct thread_data{
	long tid;
	char *message;
};
void* child_thread(void * message){
	char * a = (char*) message;
	printf("\t\t%s\n", a);
	pthread_exit(NULL);
}
void *PrintHello(void *td)
{
	struct thread_data * t = (struct thread_data *)td;
	printf("%s",t->message );
	printf("Hello World! It's me, thread #%ld!\n", t->tid);
	pthread_t threads[2];
	int temp = pthread_create(&threads[2], NULL, child_thread, (void *)"This is ***CHILD*** thread.");	
	pthread_exit(NULL);
}

int main(int argc, char *argv[])
{
	pthread_t threads[NUM_THREADS];
	int rc;
	long t;
	for(t=0;t<NUM_THREADS;t++){
		printf("In main: creating thread %ld\n", t);
		struct thread_data* t_data = (struct thread_data*) malloc(sizeof(struct thread_data));
		t_data -> tid = t;
		t_data -> message = "\tThis is inside a thread";

		pthread_attr_t* attribs;
		pthread_attr_init(attribs);
		rc = pthread_create(&threads[t], NULL, PrintHello, t_data);
		if (rc){
			printf("ERROR; return code from pthread_create() is %d\n", rc);
			exit(-1);
		}
	}

	/* Last thing that main() should do */
	pthread_exit(NULL);
}
