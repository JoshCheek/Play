by 'Dec 20' do
  
  read "Exploring the syntax of Lisp code" => 31-48 do
    discuss "differencese in symbols, numbers, and strings in Lisp vs other languages"
    discuss "code and data mode"
    discuss "strenghts and weaknesses of Lisp syntax"
    discuss "do parentheses keep the syntax to a minimum?"
    supplement "Think about what the data structure for cons would look like. "   \
               "Implement this data structure in C, with integer data, then "     \
               "show that you can use it to create lists by chaining them as "    \
               "shown in the figure on page 38. Print the list in two ways, the " \
               "first reflecting the cons implementation, as in ( 0 ( 1 ( 2 ))) " \
               "and the second reflecting the more standard notation, with the "  \
               "conses hidden, as in ( 0 1 2 )" do
      show "your data structure and implementation"
    end
    supplement "Create the list ((PEAS CARROTS TOMATOES) (PORK BEEF CHICKEN)) "   \
               "using cons commands. The solution is on page 42, but try to "     \
               "do it without looking at the solution. I had to draw the boxes "  \
               "with the arrows, and then translate that to code. Even then, my " \
               "first attempt was wrong, so it might take some effort, but I "    \
               "know you can do it ^_^" do
      comment "Pay attention to what formatting you use. Does it make it easier " \
              "for you to keep track of the structure? Does it make it harder? "  \
              "Look at Barski's solution, is yours the same? Whose is easier "    \
              "to read?"
    end
    supplement "Consider the following list of commands. Predict what you think " \
               "the result should be. Were you correct? If not, spend some time " \
               "considering how you view the commands, and think of a way to "    \
               "view them that leads to the correct answer. After you finish "    \
               "the next section, come back and try again." do               
     complete "( car    '((1 2 3) (11 22 33) (111 222 333)) )"
     complete "( caar   '((1 2 3) (11 22 33) (111 222 333)) )"
     complete "( cddr   '((1 2 3) (11 22 33) (111 222 333)) )"
     complete "( cdaddr '((1 2 3) (11 22 33) (111 222 333)) )"
     complete "( cdar   '((1 2 3) (11 22 33) (111 222 333)) )"
     complete "( caddr  '((1 2 3) (11 22 33) (111 222 333)) )"
     complete "( cdr    '((1 2 3) (11 22 33) (111 222 333)) )"
     complete "( cadadr '((1 2 3) (11 22 33) (111 222 333)) )"
     complete "( cadr   '((1 2 3) (11 22 33) (111 222 333)) )"
    end
  end
  
  read "Making decisions with conditions" => 49-66 do
    discuss    "strengths and weaknesses of the symmetry of nil and ()"
    discuss    "why there are so many equality functions."
    live_code! "write a function named my-length that calculates the length of a list"
    live_code! "write a function that calculates the number of a given item in a list"
  end
  
end
