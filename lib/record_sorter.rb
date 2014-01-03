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

    sorter = new_sort(sorts)
    @rows.sort(&sorter)
  end

  # Create a new column/ordering sort given a list of sorts.
  #
  # @param [Array<Array(col,order)>] sorts
  # @return [Proc]
  def new_sort(sorts)
    col, order = sorts.first

    lambda { |a, b|
      result = a[col] <=> b[col]

      if result == 0 # Tie
        if sorts.empty?
          result
        else
          new_sort(sorts[1..-1]).call(a, b)
        end
      else
        order == :asc ? result : -result
      end
    }
  end
  private :new_sort
end
