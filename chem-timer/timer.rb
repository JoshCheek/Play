class StopWatch
  def progress
    return 0 unless started?
    (Time.now - initial) % duration / duration
  end
  def duration=(value)
    @duration = value
  end
  def duration
    (@duration || 1).to_i
  end
  def on_duration?
    started? && seconds_passed % duration == 0
  end
  def started?
    @initial
  end
  def to_s
    "%d:%02d:%02d" % hrs_mins_secs
  end
  alias_method :time_passed , :to_s
  def start
    @initial ||= Time.now
  end
  def initial
    @initial || Time.now
  end
  def seconds_passed
    (Time.now - initial).to_i
  end
  def hrs_mins_secs
    total_seconds = seconds_passed
    hms = Array.new
    3.times do
      hms << total_seconds % 60
      total_seconds /= 60
    end
    hms.reverse
  end
end



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
      @block = every 1 do
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
