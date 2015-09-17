module Weather

  def set_weather
    (rand(5) <= 3) ? :Sunny : :Stormy
  end

end