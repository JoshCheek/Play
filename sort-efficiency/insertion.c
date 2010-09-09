#include <stdio.h>
#include <stdarg.h>

#define bool int
#define true 1
#define false 0

void print_ary( int ary[] , int size ) {
  int i;
  printf( "[ " );
  for( i=0; i<size ; ++i )
    printf( "%d " , ary[i] );
  printf( "]\n");
}

bool is_sorted( int ary[] , int size ) {
  while(--size)
    if( ary[size] < ary[size-1] )
      return false;
  return true;
}

void populate( int ary[] , int size ) {
  int i;
  for( i=0 ; i<size ; ++i )  ary[i]=rand();
}


void insertion_sort( int ary[] , int size ) {
  int wall; // wall separates sorted left from unsorted right
  
  for( wall=0 ; wall < size ; ++wall ) {                                        
    
    // shift each element greater than to_insert up an index
    int to_insert=ary[wall] , shifter;
    for( shifter = wall ; shifter && ary[shifter-1] > to_insert ; --shifter )
      ary[shifter] = ary[shifter-1];
      
    // place to_insert into the empty index opened up by the shifting
    ary[shifter] = to_insert;
  }
  
}

// pass in array size, and number of times to test
int main( int argc , char const *argv[] ) {
  int i=0 , size=atoi(argv[1]) , ary[size] , times_to_test=atoi(argv[2]);
  while( i++ < times_to_test ) {
    populate(ary,size);
    insertion_sort(ary,size);
    // if( !is_sorted(ary,size) ) {
    //   printf( "failure: not sorted\n" );
    //   print_ary(ary,size);
    // }
  }
  return 0;
}