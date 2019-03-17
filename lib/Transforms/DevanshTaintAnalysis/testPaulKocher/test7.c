#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
extern size_t array1_size, array2_size, array_size_mask;
extern uint8_t array1[], array2[], temp;

void victim_function_v07(size_t x) {
     static size_t last_x = 0;
     if (x == last_x)
          temp &= array2[array1[x] * 512];
     if (x < array1_size)
          last_x = x;
}

int main()
{
	size_t x;
	scanf("%zu",&x);
	victim_function_v07(x);	
}
