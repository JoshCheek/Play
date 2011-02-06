require File.dirname(__FILE__) + "/stop_watch"

Shoes.app :width => 800 , :height => 400 , :resizable => false , :title => 'Chemistry Lab Timer' do
  
  @stopwatch = ::StopWatch.new
  
    
  flow do
    
    # LHS
    stack :width => 400 , :height => 400 do
      border black , :strokewidth => 5
      tagline 'Duration (in seconds):'        , :displace_left => 20 , :displace_top => 10
      @input = edit_line                        :displace_left => 20                        , :width => 350
      tagline 'Past Durations:'               , :displace_left => 20 , :displace_top => 10
      @recorded = edit_box                      :displace_left => 25 , :height => 265       , :width => 350
    end
    
    # RHS
    stack :width => 400 , :height => 400 do
      border black, :strokewidth => 5
      displace_top = 90 
      @time = banner @stopwatch.time_passed , :align => 'center' , :size => 75 , :displace_top => displace_top
      _progress = progress :width => 300 , :displace_left => 50 , :displace_top => displace_top
      @progress = animate { _progress.fraction = @stopwatch.progress }.stop
      @block = animate do
        @time.replace @stopwatch.time_passed
        if @stopwatch.on_duration? && @recorded.text[/.*\Z/] != @stopwatch.time_passed
          @recorded.text += "#{@stopwatch.time_passed}\n" 
          Thread.new { system 'say  measure mutha fucka -v cellos' }
        end
      end
      
      started = false
      button 'START / PAUSE' , :width => 200 , :displace_left => 100 , :displace_top => displace_top+5 do
        if ( @input.text !~ /^\d+/ || @input.text == '0' ) && !started
          alert "You need to input a duration\n(positive number of seconds)"
          @input.focus
        elsif started
          started = false
          @stopwatch.pause
          @block.stop
          @progress.stop
        else
          started = true
          @block.start
          @progress.start
          @stopwatch.start
          @stopwatch.duration = @input.text
        end
      end
    end
  end  
end
