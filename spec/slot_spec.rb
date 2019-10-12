require_relative '../lib/slot.rb'
require_relative '../lib/vehicle.rb'

describe Slot do
  describe '.initialize' do
    it 'creates a slot given id of the slot' do
      slot = Slot.new(1)
      expect(slot.class).to eq described_class
    end

    it 'throws an error when id of slot is less than zero' do
      expect { Slot.new(0) }.to raise_error(ArgumentError, "Invalid id. Value shouln't be less than zero")
    end
  end

  describe '#id' do
    it 'gives integer id is string' do
      slot = Slot.new('1')
      id = slot.id
      expect(id.class).to eq Integer
      expect(id).to eq 1
    end
  end

  describe "#park_vehicle" do
    let(:slot) { Slot.new(1) }
    let(:registration_number) { 'KA-01-HH-1234' }
    let(:colour) { 'White' }
    let(:vehicle) { Vehicle.new(registration_number, colour) }

    it 'returns the slot allocated and parks the vehicle in the spot' do
      allocated_slot = slot.park_vehicle(vehicle)
      expect(allocated_slot.class).to eq Slot
      expect(allocated_slot.vehicle).to eq vehicle
    end

    it "throws an exception when slot is not empty and tried to park" do
      vehicle_2 = Vehicle.new('KA-01-HH-1235', 'Orange')
      allocated_slot = slot.park_vehicle(vehicle)
      expect { slot.park_vehicle(vehicle_2) }.to raise_error(SlotFullException, "Slot is occupied cannot accomodate new vehicle")
    end

    it "throws an exception when vehicle is not sent is not used to park" do
      expect { slot.park_vehicle('KA-01-HH-1235') }.to raise_error(ArgumentError, "Invalid vehicle passed. Cannot park in the slot.")
    end
  end

  describe "#free?" do
    let(:slot) { Slot.new(1) }
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
    let(:slot) { Slot.new(1) }
    let(:registration_number) { 'KA-01-HH-1234' }
    let(:colour) { 'White' }
    let(:vehicle) { Vehicle.new(registration_number, colour) }

    it 'sets the slot free' do
      slot.park_vehicle(vehicle)
      slot.remove_vehicle
      expect(slot.free?).to eq true
    end
  end

  describe "#distance" do
    it 'returns distance from the entry point' do
      slot = Slot.new(1)
      expect(slot.distance).to eq (1)
    end
  end

  describe ".get_nearest_free_slot" do
    it 'returns the nearest free slot' do
      slots = []
      vehicles = []
      5.times { |value| slots << Slot.new(value+1) }
      4.times { |value| vehicles << Vehicle.new("KA-01-HH-123#{value}", ["Pink", "Orange"].sample) }
      vehicles.each_with_index { |vehicle, index| slots[index].park_vehicle(vehicle) }
      expect(Slot.get_nearest_free_slot(slots)).to eq slots.last
    end
  end
end
