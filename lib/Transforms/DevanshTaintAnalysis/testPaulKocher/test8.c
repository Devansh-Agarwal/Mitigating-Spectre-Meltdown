#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
extern size_t array1_size, array2_size, array_size_mask;
extern uint8_t array1[], array2[], temp;

void victim_function_v08(size_t x) {
     temp &= array2[array1[x < array1_size ? (x + 1) : 0] * 512];
}
int main()
{
	size_t x;
	scanf("%zu",&x);
	victim_function_v08(x);	
}
