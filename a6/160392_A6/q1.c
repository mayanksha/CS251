#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>
#include<string.h>
#include<pthread.h>
#include<math.h>

#define SEED 0x7457

#define MAX_THREADS 64
#define USAGE_EXIT(s) do{ \
	printf("Usage: %s <# of elements> <# of threads> \n %s\n", argv[0], s); \
	exit(-1);\
}while(0);

#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))

struct thread_param{
	pthread_t tid;
	int *array;
	int size;
	int skip;
	int max;  
	int max_index;
};

int check_prime(int x)
{
	int y, flag = 0;
	for(y = 2 ; y*y <= (x); y++){
		if(x % y == 0){ 
			flag = 1;
			break;
		}
		else 
			continue;  
	}
	return (flag == 0);
}


void* find_max_prime(void *arg)
{
	struct thread_param *param = (struct thread_param *) arg;
	int ctr=0;
	param->max = 0;
	param->max_index = ctr;

	ctr = 0;
	while(ctr < param->size){
		int x =param->array[ctr];
		if(check_prime(x))
		{if(x > param->max){
							   param->max = x;
							   param->max_index = ctr;
						   }
		}
		ctr += param->skip;
	}          
	return NULL;
}

int main(int argc, char **argv)
{
	struct thread_param *params;
	struct timeval start, end;
	int *a, num_elements, ctr, num_threads;
	int max;
	int max_index;

	if(argc !=3)
		USAGE_EXIT("not enough parameters");

	num_elements = atoi(argv[1]);
	if(num_elements <=0)
		USAGE_EXIT("invalid num elements");

	num_threads = atoi(argv[2]);
	if(num_threads <=0 || num_threads > MAX_THREADS){
		USAGE_EXIT("invalid num of threads");
	}


	/* Parameters seems to be alright. Lets start our business*/

	a =(int *) malloc(num_elements * sizeof(int));
	if(!a){
		USAGE_EXIT("invalid num elements, not enough memory");
	}

	srand(SEED);  
	for(ctr=0; ctr<num_elements; ++ctr)
	{
		a[ctr] = random();
		/*printf("%d \n", a[ctr]);*/
	}


	/*Allocate thread specific parameters*/
	params =(struct thread_param *) malloc(num_threads * sizeof(struct thread_param));
	bzero(params, num_threads * sizeof(struct thread_param));

	gettimeofday(&start, NULL);

	/*Partion data and create threads*/      
	for(ctr=0; ctr < num_threads; ++ctr){
		struct thread_param *param = params + ctr;
		param->size = num_elements - ctr;
		param->skip = num_threads;
		param->array = a + ctr;

		if(pthread_create(&param->tid, NULL, find_max_prime, param) != 0){
			perror("pthread_create");
			exit(-1);
		}

	}

	/*Wait for threads to finish their execution*/      
	for(ctr=0; ctr < num_threads; ++ctr){
		struct thread_param *param = params + ctr;
		pthread_join(param->tid, NULL);
		if(ctr == 0 || (ctr > 0 && param->max > max)){
			max = param->max;    
			max_index = param->max_index;
		}
	}
	if(max == 0){
		printf("No prime number found in the set of generated random values. EXITING. \n");
		free(a);
		free(params);
		exit(EXIT_FAILURE);
	}
	else
	{
		printf("Max_prime = %d at index = %d \n", max, max_index);
		free(a);
		free(params);
		exit(EXIT_SUCCESS);
	}
}
