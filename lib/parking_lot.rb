require_relative './vehicle.rb'
require_relative './slot.rb'
require_relative './exceptions.rb'

class ParkingLot
  def initialize(size)
    size = size.to_i if size.class == String
    raise InvalidParkingLotSize, "Invalid parking lot size" if size < 1
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
    slot = slots&.find { |slot| slot&.vehicle&.registration_number == registration_number }
    raise InvalidRegistrationNumberException, "No such vechicle is available such registration number" unless slot
    slot
  end

  def status
    occupied_slots = slots.filter { |slot| !slot.free? }
    occupied_slots.map { |slot| {slot_id: slot&.id, registration_number: slot&.vehicle&.registration_number, colour: slot&.vehicle&.colour}}
  end

  def slots
    slots ||= @slots
  end

  def release(slot_id)
    slot_id = slot_id.to_i if slot_id.class == String
    slot = slots.find {|slot| slot.id == slot_id }
    raise InvalidSlotId, "Invalid slot ID. Unable to process." unless slot
    slot&.remove_vehicle
    slot&.free?
  end

  private
  def init_slots
    @slots = []
    @size.times { |value| @slots << Slot.new(value+1) }
  end
end
