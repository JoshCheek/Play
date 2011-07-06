#ifndef _FSM_H_
#define _FSM_H_

  /* 
                                               HELPER MACROS DEFINED IN THIS FILE: 
                                            -----------------------------------------
                                                        CONTAINER MACROS
                                                FSM AND STATE DEFINITION MACROS
                                                    FLOW OF CONTROL MACROS




    Required definitions:
    FSM_CONTAINER_NAMESPACE should be defined before declaring the container, and should not be changed within the container
                            (if using more than one container, then redefine it for each one)
    
    FSM_NAMESPACE should be redefined before each FSM
                  Using PASTE I could have removed a lot of the redundancy in these macros
                  but I found that this rendered them completely unreadable... you know, because they're such a delight to read now :P
    
    Callbacks:
    If your container namespace was CNS, then there must be a function fsm_state_transition_CNS(void*,void*) which will receive notification
      each time there is a state transition. It will receive pointers to the previous and next states.
      - The first time this is invoked, it will be passed two pointers to the entry FSM (which forward control to the given state)
      - Afterwards, all callbacks be only between states, and (at present, anyway) not reveal changes to the FSM namespace
  
    There should also then be a function fsm_exit_CNS(void*) which receives a pointer to the state the FSM was in when it exited.
    
    Other notes: 
    Locations of states are tracked with &&labelname, stored in a void pointer, this is GCC only behaviour
      so GCC must be used, or remove the callback functionality.
  
    There are a lot of superfluous gotos included to shut up the compiler when -Wall is used
  */
  
  
  /* FOR USE IN THIS FILE ONLY */
  #define __CRNT_STATE_PTR(             cns                   ) __crnt_state_for_##cns 
  #define __FSM_LABEL(                  cns , ns              ) fsm_##cns##_##ns
  #define __STATE_LABEL(                cns , ns , statename  ) s_##cns##_##ns##_##statename 
  #define __EXIT_CNS_LABEL(             cns                   ) fsm_container_##cns##_end 
  #define __ENTER_CONTAINER_CALLBACK(   cns                   ) fsm_enter_##cns 
  #define __EXIT_CONTAINER_CALLBACK(    cns                   ) fsm_exit_##cns 
  #define __TRANSITION_CALLBACK(        cns                   ) fsm_state_transition_##cns 
  
  
  
  /* CONTAINER MACROS */
  
  // the variables are used by the state container (for storing data to pass to the callbacks)
  // declare a container to house several FSMs, pass which fsm namespace to start in (the FSM housing the entry state)
  #define __FSM_CONTAINER( cns , entry_ns )     void* __CRNT_STATE_PTR(cns) = &&__FSM_LABEL(cns,entry_ns) ;  \
                                                __ENTER_CONTAINER_CALLBACK(cns) ( __CRNT_STATE_PTR(cns) );   \
                                                goto *__CRNT_STATE_PTR(cns) ;
  #define  _FSM_CONTAINER( cns , entry_ns )     __FSM_CONTAINER(                     cns , entry_ns )
  #define   FSM_CONTAINER(       entry_ns )      _FSM_CONTAINER( FSM_CONTAINER_NAMESPACE , entry_ns )
  
  // used so that any state within any of the nested FSMs can exit the FSM
  #define __END_OF_FSM_CONTAINER( cns )         fsm_container_##cns##_end : ;               \
                                                __EXIT_CONTAINER_CALLBACK(cns) ( __CRNT_STATE_PTR(cns) );
  #define  _END_OF_FSM_CONTAINER( cns )         __END_OF_FSM_CONTAINER(                     cns )
  #define   END_OF_FSM_CONTAINER                 _END_OF_FSM_CONTAINER( FSM_CONTAINER_NAMESPACE )
  
  
  
  
  /* FSM AND STATE DEFINITION MACROS */
  
  // declare FSM, and which state to enter in (FSM's initial state)
  // declares label to goto this FSM later, invokes callback of prev/next , updates state pointer, goes to entry state
  #define __FSM( cns , ns , entry_state ) goto __FSM_LABEL(cns,ns) ;                                                                  \
                                               __FSM_LABEL(cns,ns) :                                                                  \
                                          __TRANSITION_CALLBACK(cns) ( __CRNT_STATE_PTR(cns) , &&__STATE_LABEL(cns,ns,entry_state) ); \
                                          __CRNT_STATE_PTR(cns) = &&__STATE_LABEL(cns,ns,entry_state) ;                               \
                                          goto *__CRNT_STATE_PTR(cns) ;
  #define  _FSM( cns , ns , entry_state ) __FSM(                     cns ,            ns , entry_state )
  #define   FSM(            entry_state )  _FSM( FSM_CONTAINER_NAMESPACE , FSM_NAMESPACE , entry_state )
  
  
  // declare a state
  #define __STATE( cns , ns , name )      __STATE_LABEL(cns,ns,name) : ;
  #define  _STATE( cns , ns , name )      __STATE(                     cns ,            ns , name )
  #define   STATE(            name )       _STATE( FSM_CONTAINER_NAMESPACE , FSM_NAMESPACE , name )
  
  
  // this notifies you of undefined behaviour, you should use one of the GOTO_... macros to leave a state
  // if there is some flow of control error, and you hit the end of your state, this will catch it, 
  // notify you, and halt the program with an error (hitting the end of a state is undefined behaviour)
  #define END_STATE { printf( "Unexpected state exit in %s on line %d\n" , __FILE__ , __LINE__ ); exit(1); }
  
  
  
  
  /* FLOW OF CONTROL MACROS */
  
  // jump to the FSM defined for the specified namespace
  #define __GOTO_FSM( cns , ns )  goto __FSM_LABEL(cns,ns)
  #define  _GOTO_FSM( cns , ns )  __GOTO_FSM(                     cns , ns )
  #define   GOTO_FSM(       ns )   _GOTO_FSM( FSM_CONTAINER_NAMESPACE , ns )
  
  
  // go to the specified state in an FSM with a different namespace
  #define __GOTO_FSM_STATE( cns , ns , name )   ({                                                                                      \
                                                  __TRANSITION_CALLBACK(cns) ( __CRNT_STATE_PTR(cns) , &&__STATE_LABEL(cns,ns,name) ) ; \
                                                  __CRNT_STATE_PTR(cns) = &&__STATE_LABEL(cns,ns,name) ;                                \
                                                  goto * __CRNT_STATE_PTR(cns) ;                                                        \
                                                })
  #define  _GOTO_FSM_STATE( cns , ns , name )   __GOTO_FSM_STATE(                     cns , ns , name )
  #define   GOTO_FSM_STATE(       ns , name )    _GOTO_FSM_STATE( FSM_CONTAINER_NAMESPACE , ns , name )
  
  
  // go to the specified state in current namespace
  #define GOTO_STATE( name )  GOTO_FSM_STATE( FSM_NAMESPACE , name )
  
  
  // go to some state stored in a void pointer (ie the states passed to the callbacks)
  // temp_state necessary, because macros use normal order evaluation, thus temp_state is probably being changed in the callback
  // then we jump to it's changed value instead of it's value on entry (which can cause previous state and current state to be the same)
  // so store it's evaluated value in a temp variable, thereby achieving applicative order evaluation
  #define __GOTO_STORED_STATE( cns , ns , state_ptr ) ({                                                                    \
                                                        void* temp_state = state_ptr;                                       \
                                                        __TRANSITION_CALLBACK(cns) ( __CRNT_STATE_PTR(cns) , temp_state ) ; \
                                                        __CRNT_STATE_PTR(cns) = temp_state ;                                \
                                                        goto * temp_state;                                                  \
                                                      })
  #define  _GOTO_STORED_STATE( cns , ns , state_ptr ) __GOTO_STORED_STATE(                     cns ,            ns , state_ptr )
  #define   GOTO_STORED_STATE(            state_ptr )  _GOTO_STORED_STATE( FSM_CONTAINER_NAMESPACE , FSM_NAMESPACE , state_ptr )
  
  // use to exit the fsm/container
  #define __EXIT_FSM( cns )   goto __EXIT_CNS_LABEL(cns)
  #define  _EXIT_FSM( cns )   __EXIT_FSM(                     cns )
  #define   EXIT_FSM           _EXIT_FSM( FSM_CONTAINER_NAMESPACE )
  
    
#endif

