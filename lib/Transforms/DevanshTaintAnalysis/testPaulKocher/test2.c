#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
extern size_t array1_size, array2_size, array_size_mask;
extern uint8_t array1[], array2[], temp;

void leakByteLocalFunction_v02(uint8_t k) { 
	temp &= array2[(k)* 512]; 
}
void victim_function_v02(size_t x) {
     if (x < array1_size) {
          leakByteLocalFunction_v02(array1[x]);
     }
}

int main()
{
	size_t x;
	scanf("%zu",&x);
	victim_function_v02(x);	
}
