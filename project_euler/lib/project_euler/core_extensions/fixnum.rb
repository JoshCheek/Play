class Fixnum
  def digits
    working_int, digits = self, Array.new
    until working_int.zero?
      digits.unshift working_int % 10
      working_int /= 10
    end
    digits
  end
end
