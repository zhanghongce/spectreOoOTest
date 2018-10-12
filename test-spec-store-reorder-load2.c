// Hongce Zhang @ Princeton
// The way to rule out prefetcher effects is shown in test2.c
// In this test, we will discuss 
// whether load store---(dep)----load will be reordered
// Please compile it with -O0 
// use g++ (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 please



#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <inttypes.h>

__inline__ void clflush(volatile void *p)
{
    asm volatile ("clflush (%0)" :: "r"(p));
}

__inline__ uint64_t rdtsc()
{
    unsigned long a, d;
    asm volatile ("cpuid; rdtsc" : "=a" (a), "=d" (d) : : "ebx", "ecx");
    return a | ((uint64_t)d << 32);
}

unsigned char *table0;
unsigned char *table_sep; // used as a separator
unsigned char *table6;    // used as a checker (for prefetch)
unsigned char *tableCheck; // used to see if the write value is used
unsigned char *table1;
unsigned char table2[64];
unsigned char table3[64];
unsigned char table4[64];
unsigned char *table5;

const int REPEATCNT = 100;
# define CACHE_HIT 100
# define CACHE_MISS 100


 __inline__ unsigned long probe(unsigned char *adrs) {
	volatile unsigned long time;
	
	asm __volatile__ (
		" mfence 			\n"
		" lfence			\n"
		" rdtsc				\n"
		" lfence			\n"
		" movl %%eax, %%esi \n"
		" movl (%1) , %%eax \n"
		" lfence 			\n"
		" rdtsc				\n"
		" subl %%esi, %%eax \n"
		" clflush 0(%1)     \n"
		: "=a" (time)
		: "c" (adrs)
		: "%esi","%edx"
	);
	return time;
}

int main()
{
	
	unsigned char x;
	unsigned char y = rand()%256;
	int idx;
	volatile unsigned long t0;
	volatile unsigned long t1;
	volatile unsigned long t2;
	volatile unsigned long tt;
	volatile unsigned long tb5_1;
	volatile unsigned long tb5_2;
	volatile unsigned long tb6_acc;
	volatile unsigned long tc[4];
    volatile unsigned long tb0_acc;
	int both_unfetch = 0;
	int fetch_old = 0;
	int OoO = 0;
	unsigned char det = rand()%256;
	int u = rand() % 256;
	int v = rand() % 4; // we only test 4
    unsigned qi = rand() % 256;
	int w;
	int ww;
	volatile unsigned long tb6_acc_prefetcher_effect = 0;
	volatile unsigned long non_prefetched_load_tb1_cnt = 0;
	volatile unsigned long table_is_used = 0;
	volatile unsigned long table_is_not_used = 0;
    volatile unsigned long table0_not_accessed_while_later_reordered = 0;
	
    table0    = (unsigned char *) malloc(sizeof(unsigned char )*64);
	table1    = (unsigned char *) malloc(sizeof(unsigned char )*64);
	table_sep = (unsigned char *) malloc(sizeof(unsigned char )*64*4);
	table6    = (unsigned char *) malloc(sizeof(unsigned char )*64);
	table5    = (unsigned char *) malloc(sizeof(unsigned char )*64);
	tableCheck= (unsigned char *) malloc(sizeof(unsigned char )*64*4);
	
	for (idx = 0; idx < 64; idx ++ ) {
		table1[idx] = rand()%256;
		table2[idx] = rand()%256;
		table3[idx] = rand()%256;
		table4[idx] = rand()%256;
		table5[idx] = rand()%256;
		table6[idx] = rand()%256;
		}
		
	probe(table2);
	probe(table3);
	probe(table4);
	t0 = probe(table1);	 // clear table1 cache
	tb5_1 = probe(table5); // 
	
	for(idx = 0; idx < 100000; idx ++)
	{
		y = rand() % 256;
		x = rand() % 256;
		v = rand() % 4;
        qi = rand() % 256;
		t1 = probe(table1);
		//tt = probe(table1);
		probe(table2);
		probe(table3);
		probe(table4); // make sure the following loads will miss
		t0 = probe(table5); // tb5 
		//t0 = probe(table5);
		probe(table6);
		probe(table_sep);
		probe(table_sep+64);
		probe(table_sep+64*2);
		probe(table_sep+64*3);
		probe(tableCheck);
		probe(tableCheck+64);
		probe(tableCheck+64*2);
		probe(tableCheck+64*3);
        probe(table0);
		
		x  = table4[x%64];
		x  = table3[x%64];
		x  = table2[x%64];
		if(x < 100)
		{
			qi *= qi;
			qi *= qi;
            qi *= qi;
			qi = *((unsigned int *)table0 + qi%16 );
			// v = *((unsigned int *)table5 );  // *** Line 1 *** //
			// v = *((unsigned int *)table1 + u%16 );  // this is read
			*((unsigned int *)table1 + u%16 ) = v; // make sure it will not use v directly
			w = *((unsigned int *)table1 + u%16 ); // w = 0..3
			ww = *(((unsigned int *)tableCheck)+ w * 16); // ww
			
		}

		t2 = probe(table1);
		tb5_2 = probe(table5); 
		tb6_acc = probe(table6);
        tb0_acc = probe(table0);

		tc[0] = probe(tableCheck+64*0);
		tc[1] = probe(tableCheck+64*1);
		tc[2] = probe(tableCheck+64*2);
		tc[3] = probe(tableCheck+64*3);

		if( x>= 100 && t2 < CACHE_HIT && tb5_2 > CACHE_MISS  && tb6_acc > CACHE_MISS ) {
			//printf("%ld,%ld,%ld,%ld\n",t1,t2,tb5_1,tb5_2);
			non_prefetched_load_tb1_cnt ++;
		}
		if( tb6_acc < CACHE_HIT) {
			//printf("%ld , tb6 acc!\n", tb6_acc);
			tb6_acc_prefetcher_effect ++;
		}

        if ( x>= 100 && t2 < CACHE_HIT && tb5_2 > CACHE_MISS  && tb6_acc > CACHE_MISS && tb0_acc > CACHE_MISS) {
            table0_not_accessed_while_later_reordered ++ ;
        }

		if( x>=100 && t2 < CACHE_HIT && tb5_2 > CACHE_MISS  && tb6_acc > CACHE_MISS &&
			( (tc[0] < CACHE_HIT) || (tc[1] < CACHE_HIT) || (tc[2] < CACHE_HIT) || (tc[3] < CACHE_HIT)  )
			&& (!( (tc[0] < CACHE_HIT && tc[1] < CACHE_HIT) ||
				   (tc[0] < CACHE_HIT && tc[2] < CACHE_HIT)	||
				   (tc[0] < CACHE_HIT && tc[3] < CACHE_HIT)	||
				   (tc[1] < CACHE_HIT && tc[2] < CACHE_HIT)	||
				   (tc[1] < CACHE_HIT && tc[3] < CACHE_HIT)	||
				   (tc[2] < CACHE_HIT && tc[3] < CACHE_HIT)	))
			&& !( (tc[0] < CACHE_HIT && tc[1] < CACHE_HIT && tc[2] < CACHE_HIT ) ||
				  (tc[0] < CACHE_HIT && tc[1] < CACHE_HIT && tc[3] < CACHE_HIT ) ||
				  (tc[0] < CACHE_HIT && tc[2] < CACHE_HIT && tc[3] < CACHE_HIT ) ||
				  (tc[1] < CACHE_HIT && tc[2] < CACHE_HIT && tc[3] < CACHE_HIT ) )
			&& ! (tc[0] < CACHE_HIT && tc[1] < CACHE_HIT && tc[2] < CACHE_HIT && tc[3] < CACHE_HIT )

				    ) {

			bool check = true;
			for(int tp = 0; tp < 4; tp ++) {
				if ( tp == v && !( tc [tp] < CACHE_HIT) ) check = false;
				if ( tp != v && !( tc [tp] > CACHE_MISS)) check = false;
			}
			printf("v: %d, Time = %ld, %ld, %ld, %ld,  %c\n", v, tc[0], tc[1], tc[2], tc[3], check?'*':' ' );
			if (check) {
				table_is_used ++;
            }
			else
				table_is_not_used++;
		}

	}
	
   free(table1);
   free(table5);
   free(table6);
   free(table_sep);
   free(table0);
   printf("Non-prefetched tb1 load: %ld\n", non_prefetched_load_tb1_cnt );
   printf("used: %ld vs. unused:%ld\n", table_is_used, table_is_not_used);
   printf("store-load at least touched, but tb0 not touched:%ld\n", table0_not_accessed_while_later_reordered);
   printf("prefetcher effect: %ld\n", tb6_acc_prefetcher_effect);
   return u+v+ww+qi;

};

/*
int main()
{
	uint64_t msr;
	uint64_t msr2;
	unsigned char x;
	unsigned char y = rand()%256;
	
	int idx;
	int repeat;
	double t1avg = 0;
	double t2avg = 0;
	int ret = 0;
	
	for (idx = 0; idx < 64; idx ++ )
		table1[idx] = rand()%256;
	
    
    for (repeat = 0; repeat < REPEATCNT; repeat ++ )
    {
		clflush(table1);
		//table1[1] = table1[2];
		msr = rdtsc();
		x = table1[y];
		msr2 = rdtsc();
		ret += x;
		t1avg += msr2-msr;
	}
	
	for (repeat = 0; repeat < REPEATCNT; repeat ++ )
    {
		clflush(table1);
		table1[1] = table1[2];
		msr = rdtsc();
		x = table1[y];
		msr2 = rdtsc();
		ret += x;
		t2avg += msr2-msr;
	}
   					
   printf("%lf,%lf\n", t1avg/REPEATCNT, t2avg/REPEATCNT);
   return ret;
}
*/

/*
*/
/*

{
	int idx = 0;
	int rand = 
	for (; idx < 100; idx ++)
	{	// let's abuse the branch predictor to predict taken
		
		if( idx < 99 )
		{
			mul %%eax
			mul %%eax
			mov (%1,%%eax),%%edx
			mov (%2),
			
		}	
	}
}*/
