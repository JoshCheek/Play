# encoding: utf-8

by 'Dec 18' do
  
  read "Introduction" => 1-14 do
    discuss "What makes lisp so cool and unusual?"
    discuss "If Lisp is so great, why don't more people use it?"
    discuss "Where does lisp come from?"
    discuss "Where does lisp get its power?"
  end
  
  read "Getting started with Lisp" => 15-20 do
    discuss  "Lisp dialects"
    complete "Install CLISP"
    complete "Launch the REPL, play with it for ≥10 minutes"
  end
  
  read "Creating your first Lisp program" => 21-30 do
    supplement "Allow user to play again"
    supplement "Have the program keep a score"
    show       "your program"
    discuss    "your implementation"
  end
  
  discuss "your first impression"
  
end
