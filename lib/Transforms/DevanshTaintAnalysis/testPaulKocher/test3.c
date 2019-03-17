#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
extern size_t array1_size, array2_size, array_size_mask;
extern uint8_t array1[], array2[], temp;

__declspec(noinline) void leakByteNoinlineFunction(uint8_t k) { temp &= array2[(k)* 512]; }
void victim_function_v03(size_t x) {
     if (x < array1_size)
          leakByteNoinlineFunction(array1[x]);
}
int main()
{
	size_t x;
		scanf("%zu",&x);
	victim_function_v03(x);	
}
