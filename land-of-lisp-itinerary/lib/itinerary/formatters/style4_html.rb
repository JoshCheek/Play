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
    		<link rel="stylesheet" href="public/css/main.css" />
    	</head>
      <body>
        
        <!-- links to other days -->
  			<div class="footerMenu"> <!-- yes, I know it's called footer -.^ -->
    			<ul>
    			  <li><a href="index.html" <%= day ? '' : 'class="currentDay"' %>> Home </a></li>
    			  <% @days.each do |_day| %>
          	  <li>
          	    <a href='<%= day_to_url _day %>' <%= day == _day && 'class="currentDay"' %>>
          	      <%= _day.to_s.gsub(/\s+/,'') %>
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
    			
          <!-- main content goes here -->
    			<div class="contentMiddle clear">
    			  
            <!-- content for a given day -->
            <% if day %>
              <!-- LEFT SIDE: definitions -->
              <div class="leftContent">
                <dl>
                  <% @header.definitions.each do |key,value| %>
                    <dt class="type-<%= key.to_s.downcase.gsub(/[^a-z]/,'')%>"><%= key.upcase %></dt>
                    <dd class="type-<%= key.to_s.downcase.gsub(/[^a-z]/,'')%>"><%= value %></dd>
                  <% end %>
                </dl>
      				</div>
              <!-- RIGHT SIDE: itinerary -->
      				<div class="rightContent"><%= format_children day.children %></div>
      				
      			<!-- content for index -->
            <% else %>
              <div class="fullContent homePage">
                <h1><%= @header.to_s.split.join('<br />') %></h1>
                <% @header.descriptions.each do |description| %>
                  <p><%= description.text %></p>
                  <% if description.has_links? %>
                    <ul>
                      <% description.links.each do |link| %>
                        <li><a href="<%= link.url %>"><%= link.text %></a></li>
                      <% end %>
                    </ul>
                  <% end %>
                <% end %>
              </div>
            <% end %>            
            
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