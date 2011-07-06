Overview
--------

Must be compiled with GCC, because the callbacks use label pointers, which is nonstandard.

**I made this while working on a school project. But I can't really think of a good way to show it off. Rather than delete it, I'm just committing it as is, with the docs I wrote for that project. It will need a lot of work to be turned into something useful. If, however, you have a good simple state machine example that I could implement to make an example of how to use this, let me know.**


Required Definitions
--------------------

* Each container should define FSM_CONTAINER_NAMESPACE as the desired container namespace. 
* Each FSM should define FSM_NAMESPACE as the desired FSM namespace.
* For each container, some callbacks must be defined. So with container namespace cns, there must be a function `fsm_state_transition_cns(void*,void*)` which will receive notification each time there is a state transition. It will receive pointers to the previous and next states.
* There should also then be a function fsm_exit_cns(void*) which receives a pointer to the state the FSM was in when it exited.



Example Structure
-----------------

To use a container (named mood) FILE: ./main.c

    #include "mood/mood_callbacks.h"
    int main(){
      #include "moods/moods.fsmc"
      return 0;
    }

To define a container (named mood, with initial FSM of positive), FILE: mood/mood.fsmc

    #undef  FSM_CONTAINER_NAMESPACE
    #define FSM_CONTAINER_NAMESPACE mood
    FSM_CONTAINER( positive ) {
      //FSMs in this container
      #include "positive/positive.fsm"
      #include "negative/negative.fsm"
    } END_OF_FSM_CONTAINER;

To define an fsm (named positive, with initial state of happiness), FILE: mood/positive/positive.fsm

    #undef  FSM_NAMESPACE
    #define FSM_NAMESPACE positive
    FSM( happiness ) {
      //states
      #include "happiness.state"
      #include "joyful.state"
      #include "hopeful.state"
    }

To define a state (named happiness), FILE: mood/positive/happiness.state

    STATE(login) {
      //state code goes here
    } END_STATE;

Required callbacks (for container named mood), FILE: mood_callbacks.h

    #ifndef _MOOD_H_
    #define _MOOD_H_
    void fsm_exit_mood( void* );
    void fsm_state_transition_mood( void* , void* );
    #endif

required callbacks (for container named mood), FILE: mood_callbacks.c

    #include "fsm.h"
    void fsm_exit_bank_interface( void* exit_state )
    { 
      /* do whatever you like with this information */ 
    }
    void fsm_state_transition_bank_interface( void* previous_state , void* current_state )
    { 
      /* do whatever you like with this information */  
    }
    


What goes in a state file?
--------------------------

The states are then given in .state files, for flow of control, they are just C code. they have access to the macros defined in fsm.h
The macros are:
`GOTO_FSM(ns)` , `GOTO_FSM_STATE(ns,name)` , `GOTO_STATE(name)` , `GOTO_STORED_STATE(state_ptr)` , `EXIT_FSM`
Where ns is the namespace of the FSM, and name is the name of the state.

Other than this, they scoped to wherever the container is included into. In the above section, it is included in main, so they would have access to all variables at that point in main. 



----- IN DEFENSE OF THIS CODE'S USE OF GOTO -----

There seems to be a nearly religious hatred towards the use of goto, which is the glue holding the state machine together. I understand the reasons for this, as with anything that can be used, it can be abused. With the advent of control structures like if, else, while, and for, it is largely unnecessary, and using it in place of one of these control structures fractures the atomicity of logical steps, introducing convoluted logic. This seems to be the foundation of Edsger Dijkstra's criticism in his famous essay "[A Case against the GO TO Statement](http://www.cs.utexas.edu/users/EWD/ewd02xx/EWD215.PDF)" also known as "GO TO Statement Considered Harmful". 

In this case, however, the wiring of the state machine is maintained by the FSM code, and not by the coder. This causes it to be a control structure in a similar way to the for loop, which is translated into goto statements by the compiler, out of sight and mind of the coder. I have attempted to mimic this pattern by hiding the wiring in a series of useful macros and namespaces. Essentially, providing the higher level code that Dijkstra suggests should replace it. Unless one has to maintain the FSM code itself, the use of goto is trivial, as they need never write it.

There is also the criticism that it creates "spaghetti code" with complex difficult to follow and understand flow of control. 

While abuse of the goto can lead to this, the FSM should not suffer from this, the flow of control is quite clear, the entry point is specified in the container and FSM declaration, and each state need not care where it came from, only which state it is going to. The location it is going to is clear through the use of macros like GOTO_STATE(s), and what it is doing there is not convoluted, as it is well defined into a logical step called a state. To criticize it for this reason is to criticize state machines themselves.

If one is still turned off by the use of goto, let them realize that every time they use any control structure, they are using goto.

Dijkstra says

> The main point is that the value of these indices are outside the programmer's control: 
> they are generated (either by the write up of his program or by the dynamic evolution of
> the process) whether he wishes or not. They provide independen [sic] coordinates in which
> ti [sic] describe the progress of the process.
> 
> Why do we need such independent coordinates? The reason is -and this seems to be inherent
> to sequential processes- that we can interpret the value of a variable only with respect
> to the progress of the process.

I propose that this is exactly what this FSM provides.



Credit where credit is due
--------------------------

This finite state machine is inspired by, and loosely based off of [this](http://stackoverflow.com/questions/132241/hidden-features-of-c) response by Remo.d

Also, was able to refactor out a lot of painful configuration due to [help](http://stackoverflow.com/questions/1767683/c-programming-preprocessor-macros-as-tokens) from caf.

The callbacks are implemented using label pointers, (which are GCC specific). This solution was [revealed](http://stackoverflow.com/questions/1777990/c-programming-address-of-a-label) by Michael Aaron Safyan.

For a while I was a little uneasy about using goto so extensively, mostly because I was aware of the hatred for it, but not completely certain why it existed (worried some anvil was looming out of site above me). Reading [Dijkstra's essay](http://www.cs.utexas.edu/users/EWD/ewd02xx/EWD215.PDF) was very helpful to understand the reservations, and feel confident with my decision to use them.

Also, reading the [thoughts](http://kerneltrap.org/node/553/2131) of the noteworthy developers behind the Linux kernel was quite helpful as well.
