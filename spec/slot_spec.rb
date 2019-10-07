require './lib/slot.rb'

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
end
