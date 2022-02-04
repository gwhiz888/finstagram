=begin
- Write a method that accepts a 10 character string of letters (both uppercase and lowercase)
- if not 10 characters in length, return false
- else:
  - define empty string variable (phone_number)
  - loop through string
  - compare letter to telephone mappings and concat to variable (phone_number)
  - return the variable (phone_number)

* You may need to ensure the letter casing of the input string *
=end


def yellow_pager(word)
    if word.length = 10
       
   else
        phone_num =""

        word.each_char do |letter|

            phone_num += letter
   end
      
   phone_num
  end

  p yellow_pager("Lighthouse")