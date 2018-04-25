#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>
#define MAX_ACCOUNTS 10000
#define MAX_TRANSACTIONS 100000
#define THREADS 10 
			struct trans{
				int id;
				int type;
				double amount;
				int account_1;
				int account_2;
			};
			struct account{
	double balance;
};
long int count_lines(char * filename){
	FILE * fp =  fopen(filename, "r");
	if(fp == NULL){
		printf("file not found\n");
		exit(1);
	}
	char c = getc(fp);
	long int ctr = 0;
	while(c!=EOF){
		if(c=='\n'){
			ctr++;//number of lines increase with \n character
		}
		c = getc(fp);//new character is taken in
	}
	return ctr;
}

			struct details{
				struct trans* tr;
				struct account * account_1;
				struct account * acc2;
				pthread_mutex_t * lock;
};
void* transact(void* arg){
	struct details* temp = (struct details* ) arg;
	pthread_mutex_lock(temp->lock);
	if(temp->tr->type == 1){

		(temp->account_1->balance) += 0.99 * (temp->tr->amount); 
	}
	else if( temp->tr->type == 2){

		(temp->account_1->balance) -= 1.01 * (temp->tr->amount); 
	}
	else if( temp->tr->type == 3){

		(temp->account_1->balance) += 0.071 * (temp->account_1->balance);
	}
	else if( temp->tr->type == 4){

		(temp->account_1->balance) -= 1.01 * (temp->tr->amount);
		(temp->acc2->balance) += 0.99 * (temp->tr->amount);
	}
	else {
		printf("invalid transaction\n");
	}
	pthread_mutex_unlock(temp->lock);
}
int main(int argc, char ** argv){
	int displacement=1001;
	char * acc_file, *tran_file, MAX_THREADS = 2;
	if(argc == 3){
		acc_file = argv[1];	
		tran_file = argv[2];	
		MAX_THREADS = THREADS;
	}
	else if (argc == 4){
		acc_file = argv[1];	
		tran_file = argv[2];	
		MAX_THREADS = atoi(argv[3]);
	}
	else{
		printf("wrong number of arguements\nbye bye");
		exit(1);
	}
	int i = 0;
	FILE * accoun = fopen(acc_file, "r");//r for read
	if(accoun == NULL){
		printf("file not found\n");
		exit(1);
	}
	FILE * final_acc = fopen("done.txt", "a");
	struct account** accounts = (struct account **)malloc(sizeof(struct account *) * MAX_ACCOUNTS);
	for(int i = 0; i < MAX_ACCOUNTS; i++){
		accounts[i] = (struct account *) malloc(sizeof(struct account));
	}
	while(fscanf(accoun, "%*d %f\n",&(accounts[i]->balance)) == 1){
		i++;
	}

	long int num_tran =	count_lines(tran_file);
	struct trans ** all = (struct trans **)malloc(sizeof(struct trans*) * num_tran);
	for(int i = 0; i< num_tran; i++){
	    all[i] = (struct trans*)malloc(sizeof(struct trans));
	}
	FILE * tran = fopen(tran_file, "r");
	if(tran == NULL){
		printf("File doesn't exists. \n");
		fclose(tran);
	}
	printf("Opened transactions file! \n");
	char c;
	for(int i = 0; i < num_tran;i++){
		fscanf(tran, "%d %d %f %d %d\n", &(all[i]->id), &(all[i]->type),&(all[i]->amount),&(all[i]->account_1),&(all[i]->account_2));
	}
	printf("Read transactions file! \n");
	rewind(tran);
	int transac_processed = 0;
	pthread_t threads[MAX_THREADS];
	pthread_mutex_t mutex[MAX_THREADS];
	for(int i = 0; i< MAX_THREADS; i++){
		pthread_mutex_init(&(mutex[i]), NULL);
	}
	printf("I n i t i a l i z e d  M u t e x  l o c k s\n");
	for(int i = 0; i< num_tran; ){
		for(int k = 0;i < num_tran &&   k < MAX_THREADS; k++, i++){
			struct details* values = (struct details * ) malloc(sizeof(struct details));
			values ->tr = all[i];
			values->account_1 = accounts[(all[i]->account_1) - displacement];
			if(all[i]->account_2 != 0)
				values->acc2 = accounts[(all[i]->account_2) - displacement];
			values ->lock = &mutex[k];
			pthread_create(&threads[k], NULL, &transact,(void *) values);
		}
		for(int k = 0; k < MAX_THREADS; k++){
			pthread_join(threads[k], NULL);
		}
	}
	for(int i = 0; i < MAX_ACCOUNTS; i++)
		fprintf(final_acc, "%d %.2f\n",i + displacement, accounts[i]->balance);
	printf("File written to done.txt\n");
	exit(EXIT_SUCCESS);
}
