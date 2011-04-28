require File.dirname(__FILE__) + '/rhash'

h = RHash.new
h[:foo] # => nil
h[:foo] = 5
h[:foo] # => 5

h[:bar] # => nil
h.refer :bar => :foo
h[:bar] # => 5
h[:foo] = 6
h[:bar] # => 6


h # => #<RHash:0x00000100850ba0 @data={:foo=>6}, @references={:foo=>:foo, :bar=>:foo}>
h.refer :foo => :baz
h # => #<RHash:0x00000100850ba0 @data={}, @references={:foo=>:baz, :bar=>:foo}>

h[:baz] = 12
h[:foo] # => 12
h[:bar] # => 12
h[:baz] # => 12

h[:foo] = 40
h[:foo] # => 40
h[:bar] # => 40
h[:baz] # => 40

h.refer :foo => :foo
h # => #<RHash:0x00000100850ba0 @data={:baz=>40}, @references={:foo=>:foo, :bar=>:foo, :baz=>:baz}>
h[:foo] # => nil
h[:bar] # => nil
h[:baz] # => 40

h["garlic"] = "vampire"
h.refer :foo => 'garlic', :bar => :baz
h[:foo]       # => "vampire"
h['garlic']   # => "vampire"
h[:bar]       # => 40
h[:baz]       # => 40




# TEST SUITE

