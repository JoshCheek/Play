module Itinerary
  module Formatters
    class  SimpleHTML
      
      
      def self.format( nodes=[] , result=[] , depth=0 , container_type='days' )
        result << html_headers(nodes)         if depth.zero?
        result << format_header(nodes.shift)  if nodes.first.kind_of?(Itinerary::Header)
        result << "      #{' '*depth*2}<ul class='depth-#{depth} type-#{container_type}'>"
        nodes.each do |node|
          type = node.class.to_s.split('::').last.downcase
          if node.children.empty?
            result << "      #{' '*depth*2}  <li class='depth-#{depth} type-#{type}'>#{type.upcase}: #{node}</li>"
          else
            result << "    #{' '*depth*2}  <li class='depth-#{depth} type-#{type}'>#{type.upcase}: #{node}"
            format node.children, result , depth.next , type
            result << "    #{' '*depth*2}  </li>"
          end
        end
        result << "      #{' '*depth*2}</ul>"
        result << html_footers      if depth.zero?
        result.flatten!             if depth.zero?
        result = result.join("\n")  if depth.zero?
        result
      end
      
      def self.html_headers(nodes)
        title = "Itinerary"
        title = nodes.first.title if nodes.first.kind_of?(Itinerary::Header)
        <<-HEADER.gsub(/^ {8}/,'')
        <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
        <html lang="en-US" xml:lang="en-US" xmlns="http://www.w3.org/1999/xhtml">
          <head>
            <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
            <title>#{title}</title>
            <link rel="stylesheet" href="public/css/itinerary.css" type="text/css" media="screen" />
          </head>
          <body>        
        HEADER
      end
      
      def self.html_footers
        <<-HEADER.gsub(/^ {8}/,'')
          </body>
        </html>
        HEADER
      end
      
      def self.format_header(header)
        [ "    <h1>#{header}</h1>",
          "    <p>#{header.description}</p>",
          "    <dl>",
          header.definitions.map { |key,value| "      <dt>#{key.upcase}</dt><dd>#{value}</dd>" },
          "    </dl>",
        ].flatten
      end
      
    end
  end
end