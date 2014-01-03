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
  #
  # Feature Opportunity:
  # Take col and row separators as an argument
  def print(*columns)
    rows = [columns.join(COL_SEP)]
    rows += @rows.map do |row|
      values = columns.map do |col|
        value = row[col.to_sym] 

        if value.respond_to?(:strftime)
          value.strftime("%m/%d/%Y")
        else
          value
        end
      end

      values.join(COL_SEP)
    end
    
    rows.join(ROW_SEP)
  end
end
