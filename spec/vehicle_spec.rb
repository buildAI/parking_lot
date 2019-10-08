require './lib/vehicle.rb'

describe Vehicle do
  describe '.initialize' do
    it 'should create a new vehicle with registration number and colour' do
      registration_number = 'KA-01-HH-1234'
      colour = 'White'
      vehicle = Vehicle.new(registration_number, colour)
      expect(vehicle.class).to eq described_class
      expect(vehicle.registration_number).to eq registration_number
      expect(vehicle.colour).to eq colour
    end
  end
end
