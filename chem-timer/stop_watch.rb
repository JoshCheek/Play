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
    if started?
      resume
    else
      @initial ||= Time.now
    end
  end
  
  def initial
    @initial || Time.now
  end
  
  def seconds_passed
    if paused?
      (Time.now - initial - paused_time).to_i
    else
      (Time.now - initial).to_i
    end
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
  
  def paused?
    @pause_start
  end
  
  def pause
    @pause_start ||= Time.now
  end
  
  def resume
    @initial += paused_time
    @pause_start = nil
  end
  
  def paused_time
    Time.now - @pause_start
  end
  
end