#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <inttypes.h>
extern size_t array1_size, array2_size, array_size_mask;
extern uint8_t array1[], array2[], temp;

void victim_function_v10(size_t x, int k) {
     if (x < array1_size) {
          if (array1[x] == k)
               temp &= array2[0];
     }
}

int main()
{
	size_t x;
	int k;
	scanf("%zu,%d",&x,&k);
	victim_function_v10(x, k);	
}