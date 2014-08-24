# Course 1. Lesson 1. Calculator.rb

# Note about the operators hash:
# the keys are the number they'll select in the console. Values are the operator
#   to use in the calculation
# turns out the math operators are actually methods and you can pass them
#   as parameters to other methods!
#   2 ways to do it: 
#     1. obj.method(:meth_name).call(args) or 
#     2. obj.send(:meth_name, args)
#     Note the method needs to be specified as a symbol (with the colon)
#     I'm using the first method cuz it seems a little clearer
# 
# Apparently need to use the hashrocket syntax if using symbols as values
operators = {"1" => :+, "2" => :-, "3" => :*, "4" => :/ }

puts
puts "========================================================"
puts "Welcome to the most verbose calculator you'll ever use!"
puts "========================================================"
puts
puts "Please tell the first number you'd like to work with:"
num1 = gets.chomp

puts "Great, now give me a second number:"
num2 = gets.chomp

puts "What would you like me to do with these numbers?"
operators.each do |key, val|
  print "(#{key}) #{val}  \n"
end

selection = gets.chomp
op = operators[selection]

puts "\nSo let me get this straight, you want me to do the following calculation?"
puts "#{num1} #{op} #{num2}" 
puts "\n(Y)es | (N)o"
confirm = gets.chomp

if confirm.downcase.start_with?("y") 
  puts "Ok, here I go...\n" 
  puts "Calculating...\n"
  puts "..."
  puts "..."
  # do the calculation
  result = num1.to_f.method(op).call(num2.to_f)  # this is freakin awesome that you can do this!
  puts "The result of your calculation is: #{result}\n\n"
else 
  puts "Well, ok then...\n"
end

puts "So, um... I guess we're done here...\n"
