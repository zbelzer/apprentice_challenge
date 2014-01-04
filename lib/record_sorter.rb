# Sorts an array of Hasshes
class RecordSorter
  def initialize(rows)
    @rows = rows
  end

  # Sort the given row data based on the given options.
  #
  # @param [Array<Array(col,order)>] sorts
  # @return [Array<Hash>]
  def sort(sorts)
    return @rows if sorts.nil? || sorts.empty?

    sorter = column_sort(sorts)
    @rows.sort(&sorter)
  end

  # Create a new column/ordering sort given a list of sorts.
  #
  # @param [Array<Array(col,order)>] sorts
  # @return [Proc]
  def column_sort(sorts)
    current_sort    = sorts[0]
    remaining_sorts = sorts[1..-1]

    col, order = *current_sort

    lambda { |a, b|
      result = a[col] <=> b[col]

      if result == 0 # Tie
        return result if sorts.empty? # Base case

        column_sort(remaining_sorts).call(a, b)
      else
        order == :asc ? result : -result
      end
    }
  end
  private :column_sort
end
