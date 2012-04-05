require 'spec_helper'

describe ArrayMissing do
  before :each do
    @last_number = rand(1000000)+1
    @first_random = rand(@last_number)+1
    @second_random = @first_random + rand(@last_number - @first_random)
    @array = ArrayMissing.new(@last_number,@first_random,@second_random)
  end
  1000.times do
    it{values = @array.search_missing; p @second_random; p @first_random; p values;values.length.should == 2; values.include?(@first_random).should be_true;values.include?(@second_random).should be_true;}
  end
end
