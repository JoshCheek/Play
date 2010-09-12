#include "shared.c"

void sort( int ary[] , int size ) {
  
  // arrays with size <= 1 are already sorted
  if( size <= 1 ) return;
  int middle=size/2         ,                      i , // whole ary vars
      ary1size=middle       , ary1[ary1size] , ary1i , // left half vars
      ary2size=size-middle  , ary2[ary2size] , ary2i ; // right half vars
  
  // split the array in half
  for( i=0      ; i<middle ; ++i ) ary1[i]        = ary[i];
  for( i=middle ; i<size   ; ++i ) ary2[i-middle] = ary[i];
  
  // sort the halves
  sort( ary1 , ary1size );
  sort( ary2 , ary2size );
  
  // merge the halves until either half is completely merged
  for( i=ary1i=ary2i=0 ; i<size ; ++i )
    if( ary1i == ary1size || ary2i == ary2size )
      break;
    else
      ary[i] = ( ary1[ary1i] >= ary2[ary2i]  ?  ary2[ary2i++]  :  ary1[ary1i++] );
  
  // merge the remaining elements from the half that is not completely merged
  if( ary1i != ary1size) for( ; i<size ; ++i ) ary[i] = ary1[ary1i++];
  if( ary2i != ary2size) for( ; i<size ; ++i ) ary[i] = ary2[ary2i++];
}
