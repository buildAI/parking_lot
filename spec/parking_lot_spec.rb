require_relative '../lib/parking_lot.rb'
require_relative '../lib/slot.rb'
require_relative '../lib/vehicle.rb'

describe ParkingLot do
  describe ".initialize" do
    before(:each) {
      @parking_lot = ParkingLot.new(6)
    }

    it 'should setup parking lot with certain number of slots even when stringified number is passed' do
      parking_lot = ParkingLot.new('6')
      expect(parking_lot.class).to eq ParkingLot
      expect(parking_lot.slots.count).to eq 6
    end

    it 'throws an exception when size is less than 1' do
      expect { ParkingLot.new(0) }.to raise_error(InvalidParkingLotSize, "Invalid parking lot size")
    end

    it 'should setup parking lot with certain number of slots' do
      expect(@parking_lot.class).to eq ParkingLot
    end

    it 'should create slots equating the size of the parking lot' do
      slots = @parking_lot.slots
      expect(slots.count).to eq 6
      expect(slots.map(&:class).uniq).to eq [Slot]
      expect(slots.map(&:id)).to eq [1, 2, 3, 4, 5, 6]
    end
  end

  context "parking lot is alread available" do
    before(:each) {
      @parking_lot = ParkingLot.new(6)
    }

    describe "#size" do
      it 'returns the size of parking lot' do
        expect(@parking_lot.size).to eq 6
      end
    end

    describe "#allocate_parking" do
      it 'allocates parking in the parking lot' do
        registration_number = 'KA-01-HH-1234'
        colour = 'White'
        vehicle = Vehicle.new(registration_number, colour)
        allocated_slot = @parking_lot.allocate_parking(vehicle)
        expect(allocated_slot.class).to eq Slot
        expect(allocated_slot.vehicle.registration_number).to eq vehicle.registration_number
      end

      it 'raises an exception when non vehicle is tried for parking' do
        expect { @parking_lot.allocate_parking('KA-01-HH-1234') }.to raise_error(ArgumentError, "Invalid vehicle object. Not able to process it")
      end

      it "throws an error when parking is full" do
        6.times { |value|
          vehicle = Vehicle.new("KA-01-HH-123#{value}", ["Pink", "Orange"].sample)
          @parking_lot.allocate_parking(vehicle)
        }
        vehicle = Vehicle.new("KA-01-HH-1236", "Pink")
        expect { @parking_lot.allocate_parking(vehicle) }.to raise_error(ParkingFullException, "Parking lot is full")
      end
    end

    describe '#slots_available' do
      it 'returns true when at least one slot is free' do
        5.times { |value|
          vehicle = Vehicle.new("KA-01-HH-123#{value}", ["Pink", "Orange"].sample)
          @parking_lot.allocate_parking(vehicle)
        }
        expect(@parking_lot.slots_available?).to be_truthy
      end

      it 'returns false when parking lot is full' do
        6.times { |value|
          vehicle = Vehicle.new("KA-01-HH-123#{value}", ["Pink", "Orange"].sample)
          @parking_lot.allocate_parking(vehicle)
        }
        expect(@parking_lot.slots_available?).to eq false
      end
    end

    describe '#get_slot_with_registration_number' do
      it 'returns vehicles with orange colour' do
        registration_number = "KA-01-HH-1231"
        vehicle = Vehicle.new(registration_number, "Pink")
        slot = @parking_lot.allocate_parking(vehicle)
        expect(@parking_lot.get_slot_with_registration_number(registration_number)).to eq slot
      end

      it 'raises an exeption when invalid registration number is sent' do
        expect { @parking_lot.get_slot_with_registration_number("random number") }.to raise_error(InvalidRegistrationNumberException, "No such vechicle is available such registration number")
      end
    end

    describe '#status' do
      it 'returns the details of slots and vechile details' do
        slots = 4.times { |value|
          vehicle = Vehicle.new("KA-01-HH-123#{value}", "White")
          (@parking_lot.allocate_parking(vehicle))
        }
        expect(@parking_lot.status).to eq [{:colour=>"White", :registration_number=>"KA-01-HH-1230", :slot_id=>1},
          {:colour=>"White", :registration_number=>"KA-01-HH-1231", :slot_id=>2},
          {:colour=>"White", :registration_number=>"KA-01-HH-1232", :slot_id=>3},
          {:colour=>"White", :registration_number=>"KA-01-HH-1233", :slot_id=>4}]
      end
    end

    describe '#release' do
      it 'frees up the slot id in the parking lot' do
        registration_number = "KA-01-HH-1231"
        vehicle = Vehicle.new(registration_number, "Pink")
        slot = @parking_lot.allocate_parking(vehicle)
        @parking_lot.release(slot.id)
        expect(@parking_lot.slots.first.free?).to be_truthy
      end

      it 'frees up the slot id even when slot id is string' do
        registration_number = "KA-01-HH-1231"
        vehicle = Vehicle.new(registration_number, "Pink")
        slot = @parking_lot.allocate_parking(vehicle)
        @parking_lot.release(slot.id.to_s)
        expect(@parking_lot.slots.first.free?).to be_truthy
      end

      it 'throws an exception when invalid slot id is sent' do
        expect{@parking_lot.release(rand(100..1000))}.to raise_error(InvalidSlotId, 'Invalid slot ID. Unable to process.')
      end
    end

    context "all slots are occupied" do
      before(:each) {
        @vehicles = []
        @slots = []
        6.times { |value|
          vehicle = Vehicle.new("KA-01-HH-123#{value}", ["Pink", "Orange"].sample)
          @slots << @parking_lot.allocate_parking(vehicle)
        }
        @vehicles = @slots.map(&:vehicle)
      }

      describe '#get_vehicles_with_colour' do
        it 'returns vehicles with orange colour' do
          orange_vehicles = @vehicles.select { |vehicle| vehicle.colour == "Orange" }
          expect(@parking_lot.get_vehicles_with_colour("Orange")).to eq orange_vehicles
        end
      end

      describe '#get_slots_with_vehicle_colour' do
        it 'returns vehicles with orange colour' do
          slots_with_orange_vehicle = @slots.select { |slot| slot&.vehicle&.colour == "Orange" }
          expect(@parking_lot.get_slots_with_vehicle_colour("Orange")).to eq slots_with_orange_vehicle
        end
      end
    end
  end
end
