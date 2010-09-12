#include <stdio.h>
#include <stdarg.h>

#define bool int
#define true 1
#define false 0

void print_ary( int ary[] , int size ) {
  int i;
  printf( "[ " );
  for( i=0 ; i<size ; ++i )   printf( "%d " , ary[i] );
  printf( "]\n");
}

bool is_sorted( int ary[] , int size ) {
  while(--size)   if( ary[size] < ary[size-1] )   return false;
  return true;
}

void populate( int ary[] , int size ) {
  int i;
  for( i=0 ; i<size ; ++i )  ary[i]=rand(); // pseudo random number
}

void sort( int* , int );

// pass in array size, and number of times to test
int main( int argc , char const *argv[] ) {
  int i=0 , size=atoi(argv[1]) , ary[size] , times_to_test=atoi(argv[2]);
  while( i++ < times_to_test ) {
    populate(ary,size);
    sort(ary,size);
    // if( !is_sorted(ary,size) ) {
    //   printf( "failure: not sorted\n" );
    //   print_ary(ary,size);
    // }
  }
  return 0;
}