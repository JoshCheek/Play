#include <stdio.h>
int main() {
  char a[]="#include <stdio.h>%2$cint main() {%2$c  char a[]=%3$c%1$s%3$c;%2$c  printf(a,a,10,34);%2$c  return 0;%2$c}";
  printf(a,a,10,34);
  return 0;
}