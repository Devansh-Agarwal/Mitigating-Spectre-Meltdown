#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
extern size_t array1_size, array2_size, array_size_mask;
extern uint8_t array1[], array2[], temp;


void victim_function_v05(size_t x) {
     size_t i;
     if (x < array1_size) {
          for (i = x - 1; i >= 0; i--)
               temp &= array2[array1[i] * 512];
     }
}

int main()
{
	size_t x;
	scanf("%zu",&x);
	victim_function_v05(x);	
}
