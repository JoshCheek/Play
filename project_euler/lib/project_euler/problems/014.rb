module ProjectEuler
  class Problem14
    
    Node = Struct.new :next_num, :size
    
    def initialize
      node = Node.new nil, 1
      @seen = { 1 => node }
    end
    
    def solution
      1.upto(1_000_000) { |crnt| follow crnt }
      find_longest
    end
    
    def follow(i)
      return @seen[i] if @seen.has_key? i
      next_num = (i.even?) ? (i/2) : (3*i+1)
      @seen[i] = Node.new(next_num, follow(next_num).size.next)
    end
    
    def find_longest
      @seen.max_by { |key, node| node.size }.first
    end
    
  end
end