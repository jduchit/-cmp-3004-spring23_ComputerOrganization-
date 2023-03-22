/* Johana Duchi 00321980
   Suma de 1 a n numeros usando for loops
*/
#include <stdio.h>

int main() {
  int n;
  printf("Ingrese el valor de n: ");
  scanf("%d", &n);

  int sum = 0;
  for (int i = 1; i <= n; i++) {
    sum += i;
  }

  printf("La suma de 1 a %d es %d\n", n, sum);
  return 0;
}

