class Task

  def permutations(n)
    return 'Number must be > 2 to show effect' if n < 2
    array = (1..n).to_a
    array.permutation.to_a.each_with_index do |line,index|
      p "Line #{index+1}: #{line}"
    end
    p "Total Lines = #{array.inject(:*)}"
  end

  def string_sort(string)
    str_array = string.split
    str_array.sort!{|a,b| a.downcase <=> b.downcase}
    letter_start = []
    str_array.each_with_index do |item,index|
      if index == 0
        letter_start = [index,item]
        next
      end
      letter_start = [index,item] if item[0].downcase != letter_start[1][0].downcase

      if str_array[index-1][0].downcase == item[0].downcase && item[0].capitalize == item[0]
         str_array[letter_start[0]] = item
         str_array[index]   = letter_start[1]
         new_start_index = letter_start[0]+1
         letter_start = [new_start_index,str_array[new_start_index]]
         p str_array
      end
    end
  end

  def palindromes(words)
    words_array = words.split
    result = []
    words_array.each do |word|
      result << word.downcase if word.reverse == word
    end
    result.sort!{|a,b| a.downcase <=> b.downcase}
    result.each do |item|
      p item
    end
  end

  def find_file_by_text (start_dir, file_mask="*.*", text_pattern='')
    match_files = Dir[ File.join(start_dir.split(/\\/), "**", file_mask)]
    if match_files.length > 0
      file_path = nil
      match_files.each do |file|
        matching_text = File.read(file).include?(text_pattern) rescue false
        if matching_text
          file_path = file
          break
        end
      end
      p "#{file_path ? 'First searching file is: '+file_path : 'No files found'}"
    else
      "No files with mask '#{file_mask}' in directory '#{start_dir}'"
    end
  end

  def between?(time,start_time,end_time)
    if start_time < end_time
      time.between?(start_time,end_time)
    else
      time.between?(start_time,"23:59") || time.between?("00:00",end_time)
    end
  end


end
