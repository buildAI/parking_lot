require_relative '../lib/parking_lot.rb'
require_relative '../lib/slot.rb'

describe ParkingLot do
  describe ".initialize" do
    before(:each) {
      @parking_lot = ParkingLot.new(6)
    }

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

  describe "#allocate_parking" do
    before(:each) {
      @parking_lot = ParkingLot.new(6)
    }

    it 'allocates parking in the parking lot' do
      registration_number = 'KA-01-HH-1234'
      colour = 'White'
      allocated_slot = @parking_lot.allocate_parking(registration_number, colour)
      expect(allocated_slot.class).to eq Slot
      expect(allocated_slot.vehicle.registration_number).to eq registration_number
      expect(allocated_slot.vehicle.colour).to eq colour
    end
  end

  describe '#slots_available' do
    before(:each) {
      @parking_lot = ParkingLot.new(6)
    }

    it 'returns true when at least one slot is free' do
      5.times { |value| @parking_lot.allocate_parking("KA-01-HH-123#{value}", ["Pink", "Orange"].sample) }
      expect(@parking_lot.slots_available?).to be_truthy
    end

    it 'returns false when parking lot is full' do
      6.times { |value| @parking_lot.allocate_parking("KA-01-HH-123#{value}", ["Pink", "Orange"].sample) }
      expect(@parking_lot.slots_available?).to eq false
    end
  end
end
