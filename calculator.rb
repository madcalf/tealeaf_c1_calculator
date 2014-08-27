# Course 1. Lesson 1. Calculator.rb

# ----- Methods -----

# if val is a string and has a '.' in it, it's converted to float
# otherwise converted to an int
def convert_to_num(val)
 if val.class == String
   if val.include?(".")
      val.to_f
    else
      val.to_i
    end
  else
    # if it's not a string assume it's already a num
    # and just return it
    val
  end
end

def numeric?(str) 
  # using a regex found online.
  # regexp = /^-?(?:\d+|\d{1,3}(?:,\d{3})+)?(?:\.\d+)?$/
  # val.match(regexp)

  # using Float this way seems to be a popular way to do this on SO
  # anything wrong with it? 
  # is it ok to rely on an exception to set a value?
  begin 
    result = Float(str) ? true : false
  rescue
    result = false
  ensure
    return result
  end
end
    
# just uses a case statement to test for the correct operation
# and performs the calculation
def calculate val1, val2, operator
  puts
  puts "Ok, calculating... give me a minute...\n\n"

  result = case operator[:name]
  when "add"
    val1 + val2
  when "subtract"
    val1 - val2
  when "multiply"
    val1 * val2
  when "divide"
    begin
      val1 / val2
    rescue ZeroDivisionError => e
      puts "ERROR: '#{e.class}: #{e.message}'. I told you that wasn't gonna work!\n\n"
      nil
     end
  when "mod"
    val1 % val2 
  end
  if result then puts "The result of your calculation is: #{result}\n\n" end
end


def confirm_divide_by_zero?
  puts "\nYou really want me to divide this by zero? How's that gonna work?"
  puts "\n(Y)es | (N)o"
  confirm = gets.chomp
  confirm.downcase.start_with?("y") ? true : false
end

def confirm_do_over 
  puts "So, um... I guess we're done here.\n"
  puts "Unless you want to do another calculation? \n(Y)es | (N)o" 
  gets.chomp.downcase == "y"
end

# ----- End Methods -----

operators = [{name:"add", symbol: "+"}, {name:"subtract", symbol: "-"}, 
             {name:"multiply", symbol: "*"}, {name:"divide", symbol: "/"},
             {name:"mod", symbol: "%"}
            ]

puts
puts "========================================================"
puts "Welcome to the most verbose calculator you'll ever use!"
puts "========================================================"
puts  

loop do
  # prompt for inputs
  puts "Please tell me the first number you'd like to work with:"
  input_str1 = gets.chomp

  # keep prompting until they supply a number
  while !numeric?(input_str1) 
    puts "That won't work. Enter a number"
    input_str1 = gets.chomp    
  end

  puts
  puts "Great, now give me a second number:"
  input_str2 = gets.chomp

  # keep prompting until they supply a number
  while !numeric?(input_str2) 
    puts "That won't work. Enter a number. "
    input_str2 = gets.chomp    
  end

  # prompt for operator and display options
  puts
  puts "What would you like me to do with these numbers?"
  operators.each_with_index do |item, index|
    puts "(#{index + 1}) #{item[:name]}"
  end
  selection_str = "0"

  # keep prompting until they supply a valid choice
  while !selection_str.to_i.between?(1, 5)
    puts "That's not an option. Select 1, 2, 3, 4, or 5"
    selection_str = gets.chomp
  end

  # convert selection string to array index
  index = selection_str.to_i - 1
  operator = operators[index]

  # confirm the calculation
  puts "\nSo let me get this straight, you want me to do the following calculation?"
  puts "#{input_str1} #{operator[:symbol]} #{input_str2}" 
  puts "\n(Y)es | (N)o"
  confirm = gets.chomp

  if confirm.downcase.start_with?("y") 
    num1 = convert_to_num(input_str1)
    num2 = convert_to_num(input_str2)
    # confirm if they're trying to divide an int by zero. Floats are ok.
    if (operator[:name] == "divide") && (num1.class == Fixnum) && (num2 == 0)
      if !confirm_divide_by_zero?
        break if !confirm_do_over
      end
    end
    calculate(num1, num2, operator)
  end
  break if !confirm_do_over
end  # end loop
puts "Ok, no problem. Bye!"