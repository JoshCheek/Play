module Itinerary
  module Nestable
    
    def initialize(*args,&nested)
      instance_eval(&nested) if nested
    end

    def todo
      @todo ||= Array.new
    end
    
    # define the action methods
    %w( read discuss complete supplement show live_code! ).each do |action|
      define_method action do |*args,&block|
        klass_name = action.split(/[^a-zA-Z]/).map(&:capitalize).join
        todo << Itinerary.const_get(klass_name).new(*args,&block)
      end
    end
    
    def to(type)
      [ yield ,
        case type
        when :text then to_text
        end
      ].flatten
    end
    
    def to_text
      todo.map do |task|
        result = task.to :text
        if result.is_a? String
          "  #{result}"
        else
          result.map { |line| "  #{line}" }
        end
      end
    end
    
  end
end