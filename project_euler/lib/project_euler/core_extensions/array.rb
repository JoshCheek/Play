class Array
  
  def palindrome?
    first = 0
    last  = size - 1
    while first < last
      return false if self[first] != self[last]
      first += 1
      last  -= 1
    end
    true
  end
  
  def sum
    inject :+
  end
  
end
