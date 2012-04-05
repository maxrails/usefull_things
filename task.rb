class Task
  # return all permutations in new lines of range we pass in it
  def permutations(n)
    return 'Number must be > 2 to show effect' if n < 2
    array = (1..n).to_a
    array.permutation.to_a.each_with_index do |line,index|
      p "Line #{index+1}: #{line}"
    end
    p "Total Lines = #{array.inject(:*)}"
  end

#  Write a function: string_sort (str), which sorts speech input string in alphabetical order (as in the dictionary). For an input string it is guaranteed that it can contain only whitespace characters and the Latin alphabet (iin both registers).
#For example, the input string «Cheers to You and Us» should be replaced by «and Cheers to Us You». Among two words beginning by the same letter, but in different registers, the word with a capital letter, should go to the left. For example, «artur and Anton» should be replaced by «Anton and artur», «anton Nes antenu Anton» «Anton antenu anton Nes».
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

#Write a program that accepts words and identifies whether they are palindromes. A palindrome is a word that reads the same when read back to front. The program should print the alphabetically sorted list of palindromes (one per line). The program output should be in lowercase.

#If the following input is given to the program:

#waas
#gaag
#haaha
#ABBA

#Then the output of program should be:

#abba
#gaag
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


#  Write a function to search for files containing the specified string.
#Function prototype: find_file_by_text (start_dir, file_mask, text_pattern);
#Your function should scan a directory tree starting from the first start_dir, and find the first file containing a string text_pattern, whose name corresponds to the mask file_mask.
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

#Write a function: between? (Time, start, end), where time, start, end: time in format "hh: mm",
#for example, "23:15". The function should return TRUE, if "Time" falls between the 'Start' and 'End'. Case End < Start, for example ("23:11" "8:05") should be considered as: from 'Start' to 'End' the next day.
  def between?(time,start_time,end_time)
    if start_time < end_time
      time.between?(start_time,end_time)
    else
      time.between?(start_time,"23:59") || time.between?("00:00",end_time)
    end
  end

end
