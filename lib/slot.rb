require_relative './vehicle.rb'
require_relative './exceptions.rb'

class Slot
  attr_reader :id
  attr_accessor :vehicle

  def initialize(id)
    id = id.to_i if id&.class == String
    raise ArgumentError, "Invalid id. Value shouln't be less than zero"  if (id < 1 || id < 1)
    @id = id
  end

  def park_vehicle(vehicle)
    raise ArgumentError, "Invalid vehicle passed. Cannot park in the slot." unless vehicle.class == Vehicle
    raise SlotFullException, "Slot is occupied cannot accomodate new vehicle" unless self.free?
    self.vehicle = vehicle
    self
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

  def self.get_nearest_free_slot(slots)
    (slots&.sort_by { |slot| slot.distance })&.find { |slot| slot.free? }
  end
end
