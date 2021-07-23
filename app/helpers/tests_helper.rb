module TestsHelper
  def display_timer(test)
    test.timer ? test.timer.strftime("%H:%M:%S") : "--:--"
  end
end
