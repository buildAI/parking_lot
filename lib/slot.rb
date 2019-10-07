class Slot
  attr_reader :column, :row

  def initialize(column, row)
    column = column.to_i if column&.class == String
    row =  row.to_i if row&.class == String
    raise ArgumentError, "Invalid row/column value be less than zero"  if (column < 1 || row < 1)
    @column = column
    @row = row
  end

  def id
    "#{column}#{row}".to_i
  end
end
