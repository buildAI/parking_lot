require_relative './vehicle.rb'

class ParkingLot
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
    slots.any? { |slot| slot.free? }
  end

  def get_vehicles_with_colour(colour)
    return if colour&.empty?
    vehicles = slots&.map(&:vehicle)&.compact
    vehicles&.select { |vehicle| vehicle.colour == colour }
  end

  def get_slots_with_vehicle_colour(colour)
    return if colour&.empty?
    (slots&.select { |slot| slot&.vehicle&.colour == colour })&.compact
  end

  def get_slot_with_registration_number(registration_number)
    return if registration_number&.empty?
    slots&.find { |slot| slot&.vehicle&.registration_number == registration_number }
  end

  def status
    status = ["Slot No.    Registration No    Colour"]
    occupied_slots = slots.filter { |slot| !slot.free? }
    status + occupied_slots.map { |slot| "#{slot&.id}           #{slot&.vehicle&.registration_number}      #{slot&.vehicle&.colour}"}
  end

  def slots
    slots ||= @slots
  end

  private
  def init_slots
    @slots = []
    @size.times { |value| @slots << Slot.new(value+1) }
  end
end
