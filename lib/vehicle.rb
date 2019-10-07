class Vehicle
  attr_reader :registration_number, :colour

  def initialize(registration_number, colour)
    @registration_number = registration_number
    @colour = colour
  end
end
