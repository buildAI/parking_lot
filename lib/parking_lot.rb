require_relative './vehicle.rb'

class ParkingLot
  attr_reader :slots

  def initialize(size)
    @size = size
    init_slots
  end

  def allocate_parking(registration_number, colour)
    raise ParkingFullException, "Parking lot is full" unless slots_available?
    vehicle = Vehicle.new(registration_number, colour)
    nearest_free_slot = Slot.get_nearest_free_slot(self.slots) if vehicle
    nearest_free_slot.park_vehicle(vehicle) if nearest_free_slot
  end

  def slots_available?
    @slots.any? { |slot| slot.free? }
  end

  def get_vehicles_with_colour(colour)
    return if colour&.empty?
    vehicles = @slots&.map(&:vehicle)&.compact
    vehicles&.select { |vehicle| vehicle.colour == colour }
  end

  def get_slots_with_vehicle_colour(colour)
    return if colour&.empty?
    (@slots&.select { |slot| slot&.vehicle&.colour == colour })&.compact
  end

  private
  def init_slots
    @slots = []
    @size.times { |value| @slots << Slot.new(value+1) }
  end
end
