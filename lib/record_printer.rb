# Class used to print rows of hashes
class RecordPrinter
  # Column separator
  COL_SEP = ","

  # Row separator
  ROW_SEP = "\n"

  # Create a new RecordPrinter with given rows
  def initialize(rows)
    @rows = rows
  end

  # Print the rows with the columns in the given order
  def print(*columns)
    rows = [columns.join(COL_SEP)]
    rows += @rows.map do |row|
      columns.map { |col| row[col.to_sym] }.join(COL_SEP)
    end
    
    rows.join(ROW_SEP)
  end
end
