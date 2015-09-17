class Plane

  def initialize
  	@flying = true
  end

  def land
  	@flying = false
  end

  def take_off
  	@flying = true
  end

  def flying?
  	@flying
  end

  def landed?
  	!@flying
  end

end
