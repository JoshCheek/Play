by 'Dec 28' do
  
  read "This ain't your daddy's wumpus" => 129-152 do
    complete   "the Grand Theft Wumpus game"
    live_code! "play a round on the game you created"
  end
  
  read "Advanced datatypes and generic programing" => 153-171 do
    comment   "note that this is not the complete chapter"
    complete  "faster Grand Theft Wumpus with hash tables"
    discuss   "difference between Lisp arrays and arrays in other languages"
    discuss   "give some examples of where lists would be better than arrays"
    discuss   "give some examples of where arrays would be better than lists"
    discuss   "difference between Lisp hashes and hashes in other languages"
    discuss   "when would you use alists?"
  end
  
  supplement  "your belly with a couple of beers :D"
  comment     "enjoy new years!"
  
end