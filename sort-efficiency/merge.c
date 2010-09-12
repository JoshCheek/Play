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



void sort( int ary[] , int size ) {
  
  // arrays with size <= 1 are already sorted
  if( size <= 1 ) return;
  int middle=size/2 , ary1size=middle , ary2size=size-middle , ary1[ary1size] , ary2[ary2size] , i , ary1i , ary2i;
  
  // split the array in half
  for( i=0      ; i<middle ; ++i ) ary1[i]        = ary[i];
  for( i=middle ; i<size   ; ++i ) ary2[i-middle] = ary[i];
  
  // sort the halves
  sort( ary1 , ary1size );
  sort( ary2 , ary2size );
  
  // merge the halves either half is completely merged
  for( i=ary1i=ary2i=0 ; i<size ; ++i )
    if( ary1i == ary1size || ary2i == ary2size )
      break;
    else
      ary[i] = ( ary1[ary1i] >= ary2[ary2i]  ?  ary2[ary2i++]  :  ary1[ary1i++] );
  
  // merge the remaining elements from the half that is not completely merged
  if( ary1i != ary1size) for( ; i<size ; ++i ) ary[i] = ary1[ary1i++];
  if( ary2i != ary2size) for( ; i<size ; ++i ) ary[i] = ary2[ary2i++];
}


// pass in array size, and number of times to test
int main( int argc , char const *argv[] ) {
  int i=0 , size=atoi(argv[1]) , ary[size] , times_to_test=atoi(argv[2]);
  while( i++ < times_to_test ) {
    populate(ary,size);
    sort(ary,size);
    if( !is_sorted(ary,size) ) {
      printf( "failure: not sorted\n" );
      print_ary(ary,size);
    }
  }
  return 0;
}