module Itinerary
  module Nestable
    
    def initialize(*args,&nested)
      instance_eval(&nested) if nested
    end

    def children
      @children ||= Array.new
    end
    
    # define the action methods
    %w( read discuss complete supplement show live_code! comment ).each do |action|
      define_method action do |*args,&block|
        klass_name = action.split(/[^a-zA-Z]/).map(&:capitalize).join
        children << Itinerary::Actions.const_get(klass_name).new(*args,&block)
      end
    end
        
  end
end