#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
extern size_t array1_size, array2_size, array_size_mask;
extern uint8_t array1[], array2[], temp;

void victim_function_v12(size_t x, size_t y) {
     if ((x + y) < array1_size)
          temp &= array2[array1[x + y] * 512];
}

int main()
{
	size_t x, y;
	scanf("%zu, %zu",&x,&y);
	victim_function_v12(x, y);	
}
