class Plane

  def initialize
  	@flying = true
  end
  
  attr_accessor :flying
  
  def land
  	@flying = false
  end

  def take_off
  	@flying = true
  end

  def flying?
  	return flying
  end

  def landed?
  	return !flying
  end

end
