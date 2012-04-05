require 'spec_helper'

describe Task do
  before :each do
    @task = Task.new
  end

  it 'show correct answers for permutations' do
    @task.permutations(1).should == "Number must be > 2 to show effect"
  end

  it 'show correct answers for string_sort' do
    @task.string_sort("aa AA").should == ["AA","aa"]
    @task.string_sort("ca Zz za aA Aa Bb ga Gg").should == ["Aa","aA","Bb","ca","Gg","ga","Zz","za"]
  end

  it 'show correct answers for palindromes' do
    @task.palindromes("aa abba gaga huuh kkkl qqaa aaii prrp").should == ["aa", "abba", "huuh", "prrp"]
    @task.palindromes("gaga prrp huuh kkkl qqaa aaii aa abba").should == ["aa", "abba", "huuh", "prrp"]
  end

  it 'show file path with file mathing mask and contains words' do
    File.dirname(__FILE__).gsub('task_spec.rb','').gsub('spec','')
    @task.find_file_by_text(File.dirname(__FILE__).gsub('task_spec.rb','').gsub('spec',''), file_mask="*.*", 'adsfasdf').reverse[0..16].should == "temp_dir/test.txt".reverse
    @task.find_file_by_text(File.dirname(__FILE__).gsub('task_spec.rb','').gsub('spec',''), file_mask="*.*", 'word').reverse[0..6].should == "task.rb".reverse
  end

  it 'show exist time in time threshoulds' do
    start_time = "08:00"
    end_time   = "23:20"
    for h in 8..9 do
      for m in 1..59 do
        time = "#{h < 10 ? '0'+h.to_s : h.to_s}:#{m < 10 ? '0'+m.to_s : m}"
        @task.between?(time,start_time,end_time).should == true
      end
    end

    for h in 0..7 do
      for m in 1..59 do
        time = "0+#{h.to_s}:#{m < 10 ? '0'+m.to_s : m}"
        @task.between?(time,start_time,end_time).should == false
      end
    end

    #another case when start_time > end_time
    start_time = "23:00"
    end_time   = "08:00"

    for m in 1..59 do
      time = "23:#{m < 10 ? '0'+m.to_s : m}"
      @task.between?(time,start_time,end_time).should == true
    end

    for h in 0..7 do
      for m in 1..59 do
        time = "0"+"#{h.to_s}:#{m < 10 ? '0'+m.to_s : m}"
        @task.between?(time,start_time,end_time).should == true
      end
    end

    for h in 8..22 do
      for m in 1..59 do
        time = "#{h < 10 ? '0'+h.to_s : h.to_s}:#{m < 10 ? '0'+m.to_s : m}"
        @task.between?(time,start_time,end_time).should == false
      end
    end

  end

end
