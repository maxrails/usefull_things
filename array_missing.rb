# We've got an array (1..k), but we lost 2 numbers somewhere in the array - we need to find them.
class ArrayMissing

  def initialize(k,first_random,second_random)
    @last_number = k
    @array = (1..@last_number).to_a  #exisiting array
    @first_random = first_random
    @second_random = second_random
  end

  def search_missing
    # delete from array 2 numbers
    @array.delete(@first_random)
    @array.delete(@second_random)

    lost_values = []
    @array.each_with_index do |item,index|
      if item - (index+1+lost_values.length) == 1
        lost_values << item.to_i - 1
        break if lost_values.length == 2 # don't need to pass through other values
      elsif item - (index+1+lost_values.length) == 2 # if numbers goes one after another (100,101 for example)
        lost_values << item.to_i - 1
        lost_values << item.to_i - 2
        break
      elsif item == @last_number - 2 && lost_values.length == 0 # if last is last_number - 2
        lost_values << item.to_i + 1
        lost_values << item.to_i + 2
      end
      lost_values << @last_number.to_i if lost_values.length == 1 && item == @last_number-1 # if we missed last_number
    end
    lost_values
  end

end
