require './lib/slot.rb'
require './lib/vehicle.rb'

describe Slot do
  describe '.initialize' do
    it 'creates a slot given column and row of the slot' do
      slot = Slot.new(1, 1)
      expect(slot.class).to eq described_class
    end

    it 'throws an error when row or column is less than zero' do
      expect { Slot.new(0, 1) }.to raise_error(ArgumentError, "Invalid row/column value be less than zero")
    end
  end

  describe '#id' do
    it 'gives the id which is column, row combination' do
      slot = Slot.new(1, 2)
      id = slot.id
      expect(id.class).to eq Integer
      expect(id).to eq 12
    end

    it 'gives id integer when colum or row is string' do
      slot = Slot.new('1', '2')
      id = slot.id
      expect(id.class).to eq Integer
      expect(id).to eq 12
    end
  end

  describe "#park_vehicle" do
    let(:slot) { Slot.new(1, 1) }
    let(:registration_number) { 'KA-01-HH-1234' }
    let(:colour) { 'White' }
    let(:vehicle) { Vehicle.new(registration_number, colour) }

    it 'parks the vehicle in the spot' do
      slot.park_vehicle(vehicle)
      expect(slot.vehicle).to eq vehicle
    end
  end

  describe "#free?" do
    let(:slot) { Slot.new(1, 1) }
    let(:registration_number) { 'KA-01-HH-1234' }
    let(:colour) { 'White' }
    let(:vehicle) { Vehicle.new(registration_number, colour) }

    it 'returns true when slot is empty' do
      expect(slot.free?).to be_truthy
    end

    it 'returned false when vehicle is parked' do
      slot.park_vehicle(vehicle)
      expect(slot.free?).to eq false
    end
  end

  describe "#remove_vehicle" do
    let(:slot) { Slot.new(1, 1) }
    let(:registration_number) { 'KA-01-HH-1234' }
    let(:colour) { 'White' }
    let(:vehicle) { Vehicle.new(registration_number, colour) }

    it 'sets slot the slot free' do
      slot.park_vehicle(vehicle)
      slot.remove_vehicle
      expect(slot.free?).to eq true
    end
  end

  describe "#distance" do
    it 'returns distance from the entry point' do
      slot = Slot.new(1, 1)
      expect(slot.distance).to eq (1)
    end
  end
end
