puts Solution.new('1. Fizz Buzz', <<SOLUTION)
  def fizzbuzz(n)(n%15==0?'FizzBuzz':n%3==0?'Fizz':n%5==0?'Buzz':n).to_s end
SOLUTION
  .test { fizzbuzz 3  }.expect { |result| result == "Fizz"      }
  .test { fizzbuzz 10 }.expect { |result| result == "Buzz"      }
  .test { fizzbuzz 45 }.expect { |result| result == "FizzBuzz"  }
  .test { fizzbuzz 31 }.expect { |result| result == "31"        }
