#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
extern size_t array1_size, array2_size, array_size_mask;
extern uint8_t array1[], array2[], temp;


__inline int is_x_safe(size_t x) { if (x < array1_size) return 1; return 0; }
void victim_function_v13(size_t x) {
     if (is_x_safe(x))
          temp &= array2[array1[x] * 512];
}

int main()
{
	size_t x;
	scanf("%zu",&x);
	victim_function_v13(x);	
}
