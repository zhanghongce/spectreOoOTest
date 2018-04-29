#include <stdio.h>
#include <stdint.h>
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

unsigned char table6[64];
unsigned char table1[64];
unsigned char table2[64];
unsigned char table3[64];
unsigned char table4[64];
unsigned char table5[64];

const int REPEATCNT = 100;


 __inline__ unsigned long probe(char *adrs) {
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
	int both_unfetch = 0;
	int fetch_old = 0;
	int OoO = 0;
	unsigned char det = rand()%256;
	int u = rand() % 256;
	int v;

	
	
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
		t1 = probe(table1);
		tt = probe(table1);
		//probe(table2);
		//probe(table3);
		//probe(table4); // make sure the following loads will miss
		probe(table5); // tb5 
		//probe(table6);
		
		//x  = table4[x%64];
		//x  = table3[x%64];
		//x  = table2[x%64];
		//if(x < 100)
		//{
			u *= u;
			u *= u;
			//u = *((unsigned int *)table1 );
			//v = *((unsigned int *)table5 + u%16 );
			
			
		//}
		t2 = probe(table1);
		tb5_2 = probe(table5); 
		//tb6_acc = probe(table6);
		
		//if (t2 > 100 && x >= 100 ) {
		
		if (tb5_2 < 100 && t2 > 100 ) {
			printf("%ld,%ld,%ld %c\n", t0, t1, t2,  x>=100?'*':' ');
			printf("%ld,%ld\n", tb5_1, tb5_2);
			OoO ++;
			}
		if (tb5_2 > 100  && t2 < 100 ) {
			fetch_old ++;
			}
		
		if (tb5_2 > 100  && t2 > 100 ) {
			both_unfetch ++;
			}
		if (tb6_acc < 100) {
			//printf("%ld, acc tb6!\n",tb6_acc);
		}
	}
	
	
   printf("%d,%d,%d\n", OoO, fetch_old, both_unfetch);
   return u+table1[0]+v;

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
