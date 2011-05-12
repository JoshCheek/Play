require File.dirname(__FILE__) + "/clf"

# one example of how you cold use the lib

sprites = <<SPRITES.split("\n").map { |line| line.split("|") }.transpose
    XXX   |    XXX   |    XXX   |    XXX   |
   X   X  |   X   X  |   X   X  |   X   X  |
   X   X  |   X   X  |   X   X  |   X   X  |
     X    |     X    |     X    |     X    |
    XXX X |    XXX   |    XXX   |    XXX   |
   X X X  |   X X X X|    XX    |   X XX   |
  X  X    |   X X    |    XXX   |   X X X  |
    X X   |    X X   |     XX   |    X X   |
 X X   X  |    X  X  |     XX   |    X  X  |
        X |   X  X   |    XX    |   X   X  |
SPRITES


# clear screen and draw black box to run across
print CLF.clear
for y in 0...20
  for x in 0...60
    print CLF.bgblack.goto(y,x) >> ' '
  end
end

# draw sprites running across screen
for x in 0..50 
  sprites[x%sprites.size].each_with_index do |line,offset|
    puts CLF.goto( 4+offset , x ) >> line 
  end
  sleep 0.1
end

# go to area after cleared screen
print CLF.goto(20,0)
