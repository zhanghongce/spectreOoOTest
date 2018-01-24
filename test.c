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

unsigned char table1[64];
unsigned char table2[64];
unsigned char table3[64];
unsigned char table4[64];

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
	unsigned char y = rand()%64;
	int idx = 0;
	unsigned long t0;
	unsigned long t1;
	unsigned long t2;
	unsigned char det = rand()%256;
	
	
	for (idx = 0; idx < 64; idx ++ )
		table1[idx] = rand()%256;
		
	t0 = probe(table1);	 // clear table1 cache
	t1 = probe(table1);
	//idx += *((unsigned int *)table1);
	//idx += *((unsigned int *)table1+1);
	//idx += *((unsigned int *)table1+2);
	*((unsigned int *)table1+0) = 0;
	t2 = probe(table1);
	
	
	
   printf("%ld,%ld,%ld\n", t0, t1, t2);
   return idx;

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
