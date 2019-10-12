require_relative '../parking_lot.rb'

module CommandLineHelper
  def command_to_functionality
    {
      'create_parking_lot'=> lambda { |parking_lot_size| ParkingLot.new(parking_lot_size) },
      'park' => lambda { |vehicle| @parking_lot.allocate_parking(vehicle) },
      'leave' => lambda { |slot_id| @parking_lot.release(slot_id) },
      'status' => lambda { @parking_lot.status },
      'registration_numbers_for_cars_with_colour' => lambda { |colour| @parking_lot.get_vehicles_with_colour(colour) },
      'slot_numbers_for_cars_with_colour' => lambda { |colour| @parking_lot.get_slots_with_vehicle_colour(colour) },
      'slot_number_for_registration_number' => lambda { |registration_number| @parking_lot.get_slot_with_registration_number(registration_number) }
    }
  end

  def park(registration_number, colour)
    vehicle = Vehicle.new(registration_number, colour)
    begin
      slot = yield vehicle
      puts "Allocated slot number: #{slot.id}" if slot
    rescue ParkingFullException
      puts "Sorry, parking lot is full"
    end
  end

  def leave
    released = yield
    puts "Slot number #{released.id} is free" if released
  end

  def status
    status = yield
    unless status&.empty?
      puts "Slot No.    Registration No    Colour"
      status.each { |slot|
        puts "#{ slot[:slot_id] }           #{ slot[:registration_number] }      #{ slot[:colour] }"
      }
    end
  end

  def registration_numbers_for_cars_with_colour
    vehicles = yield
    puts vehicles&.map(&:registration_number)&.join(', ')
  end

  def slot_numbers_for_cars_with_colour
    slots = yield
    puts slots&.map(&:id)&.join(', ')
  end

  def slot_number_for_registration_number
    begin
      slot = yield
      puts slot.id
    rescue InvalidRegistrationNumberException
      puts "Not found"
    end
  end
end
