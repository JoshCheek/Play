# http://en.wikipedia.org/wiki/ANSI_escape_code
# http://ascii-table.com/ansi-escape-sequences.php
class CLF
  
  # ease the pains of metaprogramming
  define_class_method = lambda do |meth,&block|
    ( class << self ; self ; end ).send( :define_method , meth , &block )
  end
  
  # define the SGR (Select Graphic Rendition) methods (type m)
  { :fgblack => 30 , :fgred => 31 , :fggreen => 32 , :fgyellow => 33 , :fgblue => 34, :fgmagenta => 35, :fgcyan => 36, :fgwhite => 37 ,
    :bgblack => 40 , :bgred => 41 , :bggreen => 42 , :bgyellow => 43 , :bgblue => 44, :bgmagenta => 45, :bgcyan => 46, :bgwhite => 47 ,
    :reset => 0 , :invert => 7 , :bold => 1 , :nobold => 22 , :underline => 4 , :nounderline => 24 , :blink => 5 , :noblink => 25 ,
  }.each do |meth,code|
    define_class_method.call(meth) { new.send meth }
    define_method(meth) { command 'm' , code }
  end
  
  # define other methods that work for us
  { :goto           =>  lambda { |y=0,x=0| command 'H' , y , x       },
    :up             =>  lambda { |n=1|     command 'A' , n           },
    :down           =>  lambda { |n=1|     command 'B' , n           },
    :left           =>  lambda { |n=1|     command 'D' , n           },
    :right          =>  lambda { |n=1|     command 'C' , n           },
    :save           =>  lambda {           command 's'               },
    :restore        =>  lambda {           command 'u'               },
    :clear          =>  lambda {           command("J",2).goto(0,0)  },
    :kill_line      =>  lambda {           command 'K' , 2           },
    :kill_forward   =>  lambda {           command 'K' , 0           },
    :kill_backward  =>  lambda {           command 'K' , 1           },
  }.each do |meth,definition|
    define_class_method.call(meth) { |*args| new.send meth ,*args }
    define_method meth , &definition
  end
      
  # don't initialize yourself, use the factories
  def initialize( prev=nil , type="" , *commands )
    @prev , @type , @commands = prev , type , commands
  end

  def >>(text)
    to_s << text
  end
  
  def to_s
    control_sequence_introducer = 27.chr << '['  # 27 is ascii value of escape
    @prev.to_s << control_sequence_introducer << @commands.join(';') << @type
  end
  
  def command(*args)
    self.class.new( self , *args )
  end

end
