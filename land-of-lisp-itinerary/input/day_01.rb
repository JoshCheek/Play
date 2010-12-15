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
    complete "Install CLISP" do
      comment "I installed it on my Mac with `$ sudo port install clisp`"
      comment "Book says that `$ apt-get install clisp` should work on Debian"
      comment "If that doesn't work, check http://clisp.sourceforge.net/"
    end
    complete "Launch the REPL, play with it for ≥10 minutes" do
      comment "remember, `$ clisp` to start, `(quit)` to stop"
    end
  end
  
  read "Creating your first Lisp program" => 21-30 do
    supplement "After being shown the code for the guess-my-number function, "  \
               "think for a bit, and write the bigger and lower functions "     \
               "without looking further ahead. Select the number 17, can your " \
               "program determine that this is your number?" do
      comment "Take a look at the book's solution, what are the differences?"
    end
    supplement "Have the program keep an average of how many guesses it took"
    show       "Put your whole program in a file and show what it looks like"
    discuss    "Your implementation of the average function"
    discuss    "Limits keeping your program from being better."
  end
  
  discuss "your first impression"
  
end
