module Itinerary
  module Formatters
    class  HTML
      
      
      def self.format( nodes=[] , result=[] , depth=0 )
        result << html_headers(nodes)         if depth.zero?
        result << format_header(nodes.shift)  if nodes.first.kind_of?(Itinerary::Header)
        result << "      #{' '*depth*2}<ul>"
        nodes.each do |node|
          if node.children.empty?
            result << "      #{' '*depth*2}  <li>#{node}</li>"
          else
            result << "    #{' '*depth*2}  <li>#{node}"
            format node.children, result , depth.next
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