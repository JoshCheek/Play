class StopWatch
  def duration=(value)
    @duration = value
  end
  def duration
    (@duration || 1).to_i
  end
  def on_duration?
    seconds_passed % duration == 0
  end
  def to_s
    "%d:%02d:%02d" % hrs_mins_secs
  end
  alias_method :time_passed , :to_s
  def start
    @initial = Time.now
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




Shoes.app :width => 800 , :height => 600 , :resizable => false , :title => 'Chemistry Lab Timer' do
  
  @stopwatch = ::StopWatch.new
  
  def reset
    @stopwatch      =  ::StopWatch.new
    @recorded.text  =  @stopwatch.time_passed
  end
  
  flow do
    
    stack :width => 400 , :height => 600 do
      border black, :strokewidth => 5
      tagline 'Duration (in seconds):'
      @input = edit_line :width => 350
      tagline 'Past Durations:'
      @recorded = edit_box  :width => 350
      @recorded.text = ::StopWatch.new.time_passed
    end
    
    stack :width => 400 , :height => 600 do
      border black, :strokewidth => 5
      @time  = banner @stopwatch.time_passed , :align => 'center' ,:height => 100 , :size => 75

      @start_button = button 'start' do
        @time.text = @stopwatch.time_passed
        @stopwatch.duration = @input.text
        @stopwatch.start
        @every_block = every 1 do
          @time.replace @stopwatch.time_passed
          @recorded.text += "\n#{@stopwatch.time_passed}" if @stopwatch.on_duration?
        end
        @start_button.hide
        @stop_button.show
      end
      
      @stop_button = button 'stop' do
        reset
        @every_block.stop
        @stop_button.hide
        @start_button.show
      end
      @stop_button.hide # doesn't work for some reason
    end
  end  
end
