#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

#define MAX_ACCOUNTS 10000
#define MAX_TRANSACTIONS 100000
#define DEFAULT_THREADS 10 
struct tran_strc{
	int id;
	int type;
	float amount;
	int acc_1;
	int acc_2;
};
long int count_lines(char * filename){
	FILE * fp =  fopen(filename, "r");
	if(fp == NULL){
		printf("File doesn't exists. \n");
		exit( EXIT_FAILURE );
		/*fclose(fp);*/
	}
	long int counter = 0;
	char c = getc(fp);
	while(c != EOF){
		if(c == '\n')
			counter++;
		c = getc(fp);
	}
	return counter;
}
struct account{
	int id;
	float balance;
};
struct details{
	struct account * acc1;
	struct account * acc2;
	struct tran_strc* tr;
	pthread_mutex_t * lock;
};
void* operate(void* arg){
	struct details* a = (struct details* ) arg;
	pthread_mutex_lock(a->lock);
	if(a->tr->type == 1){
		(a->acc1->balance) += 0.99 * (a->tr->amount); 
	}
	else if( a->tr->type == 2){
		(a->acc1->balance) -= 1.01 * (a->tr->amount); 
	}
	else if( a->tr->type == 3){
		(a->acc1->balance) += 0.071 * (a->acc1->balance);
	}
	else if( a->tr->type == 4){
		(a->acc1->balance) -= 1.01 * (a->tr->amount);
		(a->acc2->balance) += 0.99 * (a->tr->amount);
	}
	else {
		printf("not valid transaction. \n");
	}
	pthread_mutex_unlock(a->lock);
}
int main(int argc, char ** argv){
	int disp = 1001;
	char * acc_file, *tran_file, MAX_THREADS = 2;
	if(argc == 3){
		acc_file = argv[1];	
		tran_file = argv[2];	
		MAX_THREADS = DEFAULT_THREADS;
	}
	else if (argc == 4){
		acc_file = argv[1];	
		tran_file = argv[2];	
		MAX_THREADS = atoi(argv[3]);
	}
	else{
		printf("In-appropriate number of arguments specified. EXITING!");
		exit( EXIT_FAILURE );
	}
	int i = 0;
	FILE * acc = fopen(acc_file, "r");
	if(acc == NULL){
		printf("File doesn't exists. \n");
		exit( EXIT_FAILURE );
	}
	FILE * final_acc = fopen("final_acc.txt", "a");
	//Account with index i has an account number i + disp
	struct account** accounts = (struct account **)malloc(sizeof(struct account *) * MAX_ACCOUNTS);
	for(int i = 0; i < MAX_ACCOUNTS; i++)
		accounts[i] = (struct account *) malloc(sizeof(struct account));
	while(fscanf(acc, "%*d %f\n",&(accounts[i]->balance)) == 1)
	{
		/*printf("Account number = %d, index = %d, bal = %f\n", i + disp, i , accounts[i]->balance);*/
		i++;
	}

	long int num_tran =	count_lines(tran_file);
	struct tran_strc ** all = (struct tran_strc **)malloc(sizeof(struct tran_strc*) * num_tran);
	for(int i = 0; i< num_tran; i++)
	    all[i] = (struct tran_strc*)malloc(sizeof(struct tran_strc));
	FILE * tran = fopen(tran_file, "r");
	if(tran == NULL){
		printf("File doesn't exists. \n");
		fclose(tran);
	}
	printf("Opened transaction file! \n");
	char c;
	for(int i = 0; i < num_tran;i++){
		fscanf(tran, "%d %d %f %d %d\n", &(all[i]->id), &(all[i]->type),&(all[i]->amount),&(all[i]->acc_1),&(all[i]->acc_2));
	}
	printf("Read transaction file! \n");
	rewind(tran);
	int transac_processed = 0;

	pthread_t threads[MAX_THREADS];
	pthread_mutex_t mutex[MAX_THREADS];
	for(int i = 0; i< MAX_THREADS; i++)
		pthread_mutex_init(&(mutex[i]), NULL);
	printf("Initialized Mutex locks \n");
	for(int i = 0; i< num_tran; ){
		for(int k = 0;i < num_tran &&   k < MAX_THREADS; k++, i++){
			struct details* values = (struct details * ) malloc(sizeof(struct details));
			values ->tr = all[i];
			values->acc1 = accounts[(all[i]->acc_1) - disp];
			/*printf("acc1 = %f", values->acc1->balance);*/
			/*fprintf(stdout, "\t%d %d %f %d %d\n", (values->tr->id),(values->tr->type),(values->tr->amount),(values->tr->acc_1),(values->tr->acc_2));*/
			if(all[i]->acc_2 != 0)
				values->acc2 = accounts[(all[i]->acc_2) - disp];
			values ->lock = &mutex[k];
			pthread_create(&threads[k], NULL, &operate,(void *) values);
		}
		for(int k = 0; k < MAX_THREADS; k++){
			pthread_join(threads[k], NULL);
		}
	}
	for(int i = 0; i < MAX_ACCOUNTS; i++)
		fprintf(final_acc, "%d %.2f\n",i + disp, accounts[i]->balance);
	printf("File written to final_acc.txt\n");
	exit(EXIT_SUCCESS);
	//I have collaborated with one of my wingie for solving this question
}
