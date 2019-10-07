class Slot
  attr_reader :column, :row

  def initialize(column, row)
    raise ArgumentError, "Invalid row/column value be less than zero"  if (column < 1 || row < 1)
    @column = column
    @row = row
  end

  def id
    "#{column}#{row}".to_i
  end
end
