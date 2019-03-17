#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
extern size_t array1_size, array2_size, array_size_mask;
extern uint8_t array1[], array2[], temp;

void victim_function_v09(size_t x, int *x_is_safe) {
     if (*x_is_safe)
          temp &= array2[array1[x] * 512];
}
int main()
{
	size_t x, x_is_safe;
	scanf("%zu",&x,&x_is_safe);
	victim_function_v09(x,&x_is_safe);	
}
