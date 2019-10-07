class Slot
  attr_reader :column, :row

  def initialize(column, row)
    @column = column
    @row = row
  end

  def id
    "#{column}#{row}".to_i
  end
end
