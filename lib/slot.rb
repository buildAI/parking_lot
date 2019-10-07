require_relative './vehicle.rb'

class Slot
  attr_reader :id
  attr_accessor :vehicle

  def initialize(id)
    id = id.to_i if id&.class == String
    raise ArgumentError, "Invalid id. Value shouln't be less than zero"  if (id < 1 || id < 1)
    @id = id
  end

  def park_vehicle(vehicle)
    return unless vehicle.class == Vehicle
    self.vehicle = vehicle
  end

  def free?
    self.vehicle.nil?
  end

  def remove_vehicle
    self.vehicle = nil
  end

  def distance
    # ASSUMPTION: IDs value is proortional to distance from entry
    return id
  end
end
