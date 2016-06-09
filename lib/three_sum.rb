class ThreeSum
  attr_accessor :given_sum, :given_numbers

  def initialize(number, array)
    @given_sum = number
    @given_numbers = array
  end

  def get_triplet_with_sum
    find_triplet_with_sum or raise 'Triplet with given sum does not exist!'
  end

  private

  def sort_given_numbers
    @given_numbers.sort!
  end

  def get_sum_for_indices(*indices)
    indices.collect { |i| @given_numbers[i] }.inject(:+)
  end

  def find_triplet_with_sum
    sort_given_numbers
    last = @given_numbers.size - 1
    for first in 0..last - 1
      second = first + 1
      third = last
      while second < third
        sum = get_sum_for_indices(first, second, third)
        case
        when sum > @given_sum
          third -= 1
        when sum < @given_sum
          second += 1
        when sum == @given_sum
          return [first, second, third].collect { |i| @given_numbers[i] }
        end
      end
    end
    nil
  end
end
