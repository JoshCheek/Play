class RHash
  
  def initialize
    @data = Hash.new
    @references = Hash.new
  end
  
  def [](key)
    return nil unless in_reference_chain? key
    @data[actual key]
  end
  
  def []=(key,value)
    @data[actual key] = value
  end
  
  def refer(references)
    references.each do |from, to|
      reference_chain from, to
      @data.delete from if orphaned? from
    end
  end

private
  
  def orphaned?(from)
    @references[from] != from
  end

  def in_reference_chain?(key)
    @references.has_key? key
  end
  
  def reference_chain(from, to=from)
    @references[from] = to
  end
  
  def actual(key)
    reference_chain key unless in_reference_chain? key
    referenced = @references[key]
    return referenced if referenced == key
    return actual referenced
  end
end
