require './lib/slot.rb'

describe Slot do
  describe ".initialize" do
    it 'creates a slot given row and column of the slot' do
      slot = Slot.new(1, 1)
      expect(slot.class).to eq described_class
    end
  end
end
