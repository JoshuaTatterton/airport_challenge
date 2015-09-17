require_relative "plane"
require_relative "weather"

class Airport

  include Weather

  DEFAULT_MAX_PLANES = 10

  def initialize(capacity=DEFAULT_MAX_PLANES)
  	@capacity = capacity
    @planes = []
    @weather = set_weather
  end

  attr_accessor :capacity
  attr_reader :planes, :weather

  def land_plane(plane)
  	fail "Cannot land, weather conditions too bad" if (set_weather == :Stormy)
  	fail "Cannot land, airport full" if full?
  	plane.land
  	planes << plane
  end

  def leaving_plane(plane)
  	fail "The plane is not at this airport" if !planes.include?(plane)
  	fail "Cannot take off, weather conditions too bad" if (set_weather == :Stormy)
  	planes.delete(plane)
  	plane.take_off
  	plane
  end

  private

  def full?
    planes.length >= capacity
  end

end
