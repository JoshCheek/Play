module Itinerary
module Formatters
class  Style4HTML

  def initialize(root_dir,nodes)
    require 'erb'
    @root_dir  =  root_dir
    @header    =  nodes.shift
    @days      =  nodes
  end
  
  def format!
    File.open "#{@root_dir}/index.html" , 'w' do |f|
      f.puts content
    end
    @days.each do |day|
      File.open "#{@root_dir}/#{day_to_url day}" , 'w' do |f|
        f.puts( content day )
      end
    end
  end
  
  def content(day=nil)
    ERB.new(<<-END_OF_HTML.gsub(/^ {8}/,'')).result(binding)
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml">
    	<head>
    		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    		<% if day %>
          <title><%= @header.title %> - <%= day %></title>
        <% else %>
          <title><%= @header.title %></title>
        <% end %>
    		<script type="text/javascript" src="resources/js/jquery.js"></script>
    		<script type="text/javascript" src="resources/js/main.js"></script>
    		<link rel="stylesheet" href="public/css/main.css" />
    	</head>
      <body>
        
        <!-- links to other days -->
  			<div class="footerMenu"> <!-- yes, I know it's called footer -.^ -->
    			<ul>
    			  <li><a href="index.html">Home</a></li>
    			  <% @days.each do |day| %>
          	  <li>
          	    <a href='<%= day_to_url day %>'>
          	      <%= day.to_s.gsub(/\s+/,'') %>
          	    </a>
          	  </li>
        	  <% end %>
      	  </ul>
  			</div>
  			
  			
        <!-- BIG CONTENT BOX -->
    		<div class="container">
          
    			<!-- <div class="errorLabel"></div> -->
    			
    			<div class="contentHeader">
    			</div>
    			
          <!-- definition lists -->
    			<div class="contentMiddle clear">
            <div class="leftContent">
              <dl>
                <% @header.definitions.each do |key,value| %>
                  <dt class="type-<%= key.to_s.downcase.gsub(/[^a-z]/,'')%>"><%= key.upcase %></dt>
                  <dd class="type-<%= key.to_s.downcase.gsub(/[^a-z]/,'')%>"><%= value %></dd>
                <% end %>
              </dl>
    				</div>
    				
            <!-- main content goes here -->
    				<div class="rightContent">
              <% if day %>
                <%= format_children day.children %>
              <% else %>
              <!-- for index page -->
                <h1><%= @header %></h1>
                <p><%= @header.description %></p>
              <% end %>
            </div>
            
            
          </div>
    			<div class="contentFooter"></div>
        </div>
      </body>
    </html>
    END_OF_HTML
  end
    
  def day_to_url(day)
    day.to_s.strip.gsub(/\s+/,'-') << '.html'
  end
  
  def format_children( nodes=[] , result=[] , depth=0 , container_type='day' )
    return [] if nodes.empty?
    result << "<ul class='depth-#{depth} type-#{container_type}'>"
    nodes.each do |node|
      type = node.class.to_s.split('::').last.downcase
      if node.children.empty?
        result << "<li class='depth-#{depth.next} type-#{type}'>#{node}</li>"
      else
        result << "<li class='depth-#{depth.next} type-#{type}'>#{node}"
        format_children node.children , result , depth+2 , type
        result << "</li>"
      end
    end
    result << "</ul>"
    result.flatten!             if depth.zero?
    result = result.join("\n")  if depth.zero?
    result
  end
  
end end end