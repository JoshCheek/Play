by 'Dec 20' do
  
  read "Exploring the syntax of Lisp code" => 31-48 do
    discuss "differencese in symbols, numbers, and strings in Lisp vs other languages"
    discuss "code and data mode"
    discuss "strenghts and weaknesses of Lisp syntax"
    discuss "do parentheses keep the syntax to a minimum?"
  end
  
  read "Making decisions with conditions" => 49-66 do
    discuss    "strengths and weaknesses of the symmetry of nil and ()"
    live_code! "write a function that calculates the length of a list"
    live_code! "write a function that calculates the number of a given item in a list"
  end
  
end
