module Itinerary
  module Formatters
    class  Text 
       
      def self.format( nodes=[] , result=[] , depth=0 )
        result << format_header(nodes.shift) if nodes.first.kind_of?(Itinerary::Header)
        nodes.each do |node|
          type = node.class.to_s.split('::').last.upcase
          result << "#{'  '*depth}#{type}: #{node}"
          format node.children, result , depth.next
        end
        result.flatten
      end
      
      def self.format_header(header)
        [ header , 
          "  DESCRIPTION: #{header.description}",
          header.definitions.map { |key,value| "  #{key.upcase}: #{value}" }
        ].flatten
      end
      
    end
  end
end