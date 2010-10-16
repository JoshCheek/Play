# just silencing the migration output
require 'stringio'
$stdout = StringIO.new
require File.dirname(__FILE__) + '/setting'
$stdout = STDOUT

# db starts off empty
Setting.count               # => 0

# querying sets to default
Setting::DEFAULT            # => false
Setting[:max_resets]        # => false

# set the value
Setting[:max_resets] = 12
Setting[:max_resets]        # => 12

# indifferent access
Setting[:max_resets]        # => 12
Setting['max_resets']       # => 12

# use custom default
Setting[:welcome_message,"why hello thar!"] # => "why hello thar!"
Setting[:welcome_message,"evening, gov'na"] # => "why hello thar!"

# some classes to store in the db
Example1 = Struct.new :a , :b
Example2 = Class.new do 
  attr_accessor :a , :b
  def initialize(a,b) @a,@b=a,b end
  def ==(ex2) @a,@b=ex2.a,ex2.b end
end

# store any data type
Setting[  :hash    ] = { :abc => 123 , 'def' => 456 }
Setting[  :array   ] = [1,2,'3','4',/5/,/6/,:'7',:'8']
Setting[  :fixnum  ] = 12
Setting[  :bignum  ] = 111_222_333_444_555_666_777_888_999_000
Setting[  :float   ] = 12.12
Setting[  :symbol  ] = :sym
Setting[  :string  ] = 'str'
Setting[  :true    ] = true
Setting[  :false   ] = false
Setting[  :nil     ] = nil
Setting[  :struct  ] = Example1.new(1,2)
Setting[  :class   ] = Example2.new(1,2)

Setting[  :hash    ] # => {:abc=>123, "def"=>456}
Setting[  :array   ] # => [1, 2, "3", "4", /5/, /6/, :"7", :"8"]
Setting[  :fixnum  ] # => 12
Setting[  :bignum  ] # => 111222333444555666777888999000
Setting[  :float   ] # => 12.12
Setting[  :symbol  ] # => :sym
Setting[  :string  ] # => "str"
Setting[  :true    ] # => true
Setting[  :false   ] # => false
Setting[  :nil     ] # => nil
Setting[  :struct  ] # => #<struct Example1 a=1, b=2>
Setting[  :class   ] # => #<Example2:0x000001011aecd8 @a=1, @b=2>

# did they make it into the db?
Setting.count # => 14
