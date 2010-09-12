#include "shared.c"

void sort( int ary[] , int size ) {
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

