class RHash
  
  def initialize
    @hash = Hash.new
    @references = Hash.new
  end
  
  def [](key)
    return nil unless @references.has_key? key      # no endpoint
    actual_key = @references[key]
    return @hash[actual_key] if actual_key == key   # this is the endpoint
    return self[actual_key]                         # recursively follow the references
  end
  
  def []=(key,value)
    actual_key = @references[key]
    if @references.has_key? key     # if it is part of a reference chain
      if actual_key == key
        @hash[key] = value          # if it is an endpoint update its value
      else
        self[actual_key] = value    # if it is not an endpoint, recursively set the endpoint to the value
      end
    else
      @references[key] = key        # if it is not part of a reference chain, make it an endpoint in its own chain
      @hash[key] = value
    end
  end
  
  def refer(references)
    references.each do |from, to|
      @references[from] = to                # update the reference
      @hash.delete from unless from == to   # remove orphaned data
    end
  end
  
end