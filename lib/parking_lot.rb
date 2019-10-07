class ParkingLot
  attr_reader :slots

  def initialize(size)
    @size = size
    init_slots
  end

  private
  def init_slots
    @slots = []
    @size.times { |value| @slots << Slot.new(value+1) }
  end
end
