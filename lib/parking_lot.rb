require_relative './vehicle.rb'

class ParkingLot
  attr_reader :slots

  def initialize(size)
    @size = size
    init_slots
  end

  def allocate_parking(registration_number, colour)
    vehicle = Vehicle.new(registration_number, colour)
    nearest_free_slot = Slot.get_nearest_free_slot(self.slots) if vehicle
    nearest_free_slot.park_vehicle(vehicle) if nearest_free_slot
  end

  def slots_available?
    @slots.any? { |slot| slot.free? }
  end

  private
  def init_slots
    @slots = []
    @size.times { |value| @slots << Slot.new(value+1) }
  end
end
