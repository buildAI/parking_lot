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
end
