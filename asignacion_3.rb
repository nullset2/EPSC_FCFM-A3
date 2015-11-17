# Program Assignment: Asignacion 3
# Name: José Alfredo Gallegos Chavarría
# Enrollment number: 1383375
# Date: 16/11/2015
# Description: Linear Regression parameter calculator
# The Program reads data representing an n-number of (x, y) pairs from standard input, then populates a linked list of values with it
# Then it proceeds to calculate and output the parameters in a linear regression, Beta0, Beta1, r(x, y) and r^2
# Where:
# Beta1 = ( Sum(X*Y) - n * Average(X) * Average(Y) ) / ( Sum(X2) - n * Average(X) )
# Beta0 = Average(Y) - Beta1 * Average(X)
# r(x, y) = ( n * Sum(XY) - Sum(X) * Sum(Y) ) / Sqrt( [n * Sum(X2) - Sum(X)^2] * [n * Sum(Y2) - Sum(Y)^2] )
# r^2 = r * r
#
# How to call the program: from your preferred shell, invoke:
#       asignacion_3.rb
# And proceed to write the pairs of numbers separated by spaced when prompted:
# >? 130 186
#    650 699
#    99 132
#    150 272 ...

################################################################
# The following program section displays an explanatory message to the user in case she enters -h
# or -- help as arguments to the program when running it from the shell
################################################################
if ARGV[0] == "-h" || ARGV[0] == "--help"                                                                                                  #Code Type A
  puts "Program Assignment: Asignacion 3"                                                                                                  #Code Type A
  puts "Name: Jose Alfredo Gallegos Chavarria"                                                                                             #Code Type A
  puts "Enrollment number: 1383375"                                                                                                        #Code Type A
  puts "Date: 16/11/2015"                                                                                                                  #Code Type A
  puts "Description: Linear Regression parameter calculator"                                                                               #Code Type A
  puts "The Program reads data representing an n-number of (x, y) pairs from standard input, then populates a linked list of values with it"#Code Type A
  puts "Then it proceeds to calculate and output the parameters in a linear regression, Beta0, Beta1, r(x, y) and r^2"                     #Code Type A
  puts "Where:"                                                                                                                            #Code Type A
  puts "Beta1 = ( Sum(X*Y) - n * Average(X) * Average(Y) ) / ( Sum(X2) - n * Average(X) )"                                                 #Code Type A
  puts "Beta0 = Average(Y) - Beta1 * Average(X)"                                                                                           #Code Type A
  puts "r(x, y) = ( n * Sum(XY) - Sum(X) * Sum(Y) ) / Sqrt( [n * Sum(X2) - Sum(X)^2] * [n * Sum(Y2) - Sum(Y)^2] )"                         #Code Type A
  puts "r^2 = r * r"                                                                                                                       #Code Type A
  puts "How to call the program: from your preferred shell, invoke:"                                                                       #Code Type A
  puts "  asignacion_3.rb"                                                                                                                 #Code Type A
  puts "And proceed to write your (x, y) pairs separated by space when prompted:"                                                          #Code Type A
  puts ">? 130 186"                                                                                                                        #Code Type A
  puts "   650 699"                                                                                                                        #Code Type A
  puts "   99 132"                                                                                                                         #Code Type A
  puts "   150 272 ..."                                                                                                                    #Code Type A
  exit                                                                                                                                     #Code Type A
end                                                                                                                                        #Code Type A

################################################################
# Node code - Element of Linked List - improved from assignment 1
# some changes and refactorings have been performed to
# make this code reflect what I've learned so far
# the code has also changed to adapt itself to what's now needed
# from it in assigment 3
# has values (two datums per node, x and y) and address for next node
################################################################
class Node                                                                                                                                  #Code Type B
  attr_accessor :x, :y, :next #gets and sets for values and next                                                                            #Code Type M

  def initialize(x, y)                                                                                                                      #Code Type M
    @x = x                                                                                                                                  #Code Type M
    @y = y                                                                                                                                  #Code Type A
  end                                                                                                                                       #Code Type B
end                                                                                                                                         #Code Type B

################################################################
# Linked List code - improved from assignment 1
# this has also suffered changes and has been adapted to this assignment
# more notably, the operations for std deviation are not needed, so they have been deleted
# or rather, in this case, commented out
# also, the averaging operations have been adapted to different calculation scenarios
# according to the requirements in this assignment
################################################################
class LinkedList                                                                                                                            #Code Type B
  attr_accessor :head                                                                                                                       #Code Type M

  def initialize(x = nil, y = nil)                                                                                                          #Code Type M
    @head = nil                                                                                                                             #Code Type M
  end                                                                                                                                       #Code Type B

  def push(x, y)                                                                                                                            #Code Type M
    if @head.nil? #if there's no starting node to the list... add a new one and initialize it with the desired datum                        #Code Type B
      @head = Node.new(x, y)                                                                                                                #Code Type M
    else # else add a node to the end of the list                                                                                           #Code Type B
      current_node = @head                                                                                                                  #Code Type B

      while current_node.next #traverse the list until theres no next node                                                                  #Code Type B
        current_node = current_node.next                                                                                                    #Code Type B
      end                                                                                                                                   #Code Type B
      current_node.next = Node.new(x, y) #and after you found it, insert the value there                                                    #Code Type B
    end                                                                                                                                     #Code Type B
  end                                                                                                                                       #Code Type B

  #def find(value)                                                                                                                          #Code Type D
  #  current_node = @head #start searching from the top                                                                                     #Code Type D
  #
  #  while current_node != nil #return the right node when you find it by value                                                             #Code Type D
  #    return current_node if current_node.value == value                                                                                   #Code Type D
  #    #else, keep searching
  #    current_node = current_node.next                                                                                                     #Code Type D
  #  end                                                                                                                                    #Code Type D
  #  nil #else return nil => no value found                                                                                                 #Code Type D
  #end                                                                                                                                      #Code Type D

  #def remove(value) #remove by value                                                                                                       #Code Type D
  #  if @head.value == value #start from the top... if the first node you find has the value that you wish to delete                        #Code Type D
  #    @head = @head.next #get that node out of the game                                                                                    #Code Type D
  #  else                                                                                                                                   #Code Type D
  #    current_node = @head.next #otherwise keep searching                                                                                  #Code Type D
  #    prev_node = @head                                                                                                                    #Code Type D

  #    while current_node                                                                                                                   #Code Type D
  #      if current_node.value == value                                                                                                     #Code Type D
  #        prev_node.next = current_node.next                                                                                               #Code Type D
  #        return true                                                                                                                      #Code Type D
  #      end                                                                                                                                #Code Type D
  #      prev_node = current_node                                                                                                           #Code Type D
  #      current_node = current_node.next                                                                                                   #Code Type D
  #    end                                                                                                                                  #Code Type D

  #    nil #return nil if node is not found                                                                                                 #Code Type D
  #  end                                                                                                                                    #Code Type D
  #end                                                                                                                                      #Code Type D

  def print() #output all the values in the list                                                                                            #Code Type B
    current_node = @head #start from the top... yet,                                                                                        #Code Type B
    if current_node.nil? # if there's no head => the list is empty                                                                          #Code Type B
      return nil #exit out of this                                                                                                          #Code Type B
    end                                                                                                                                     #Code Type B
    puts "\nx\ty\n------------"                                                                                                             #Code Type A

    while current_node != nil                                                                                                               #Code Type B
      puts "#{current_node.x}\t#{current_node.y}"                                                                                           #Code Type M
      current_node = current_node.next                                                                                                      #Code Type B
    end                                                                                                                                     #Code Type B
  end                                                                                                                                       #Code Type B

  def length()                                                                                                                              #Code Type B
    i = 0                                                                                                                                   #Code Type B
    current_node = @head #start from the top... yet,                                                                                        #Code Type B

    if current_node.nil? # if there's no head => the list is empty                                                                          #Code Type B
      return 0                                                                                                                              #Code Type B
    end                                                                                                                                     #Code Type B

    while current_node != nil                                                                                                               #Code Type B
      i += 1                                                                                                                                #Code Type B
      current_node = current_node.next                                                                                                      #Code Type B
    end                                                                                                                                     #Code Type B
    i #return the amount of nodes in the list                                                                                               #Code Type B
  end                                                                                                                                       #Code Type B

  def average_x() #to calculate the average                                                                                                 #Code Type M
    return self.sum_x / self.length #and return the averages of the sums                                                                    #Code Type M
  end                                                                                                                                       #Code Type M

  def average_y() #to calculate the average                                                                                                 #Code Type M
    return self.sum_y / self.length #and return the averages of the sums                                                                    #Code Type M
  end                                                                                                                                       #Code Type M

  def sum_x()
    sum_x = 0                                                                                                                               #Code Type M
    current_node = @head #go through all the elements in the list from the top                                                              #Code Type M

    while current_node != nil #sum their datums into a grand total.                                                                         #Code Type B
      sum_x += current_node.x                                                                                                               #Code Type M
      current_node = current_node.next                                                                                                      #Code Type M
    end                                                                                                                                     #Code Type M

    sum_x # and return the sum                                                                                                              #Code Type M
  end                                                                                                                                       #Code Type M

  def sum_y()
    sum_y = 0                                                                                                                               #Code Type A
    current_node = @head #go through all the elements in the list from the top                                                              #Code Type A

    while current_node != nil #sum their datums into a grand total.                                                                         #Code Type A
      sum_y += current_node.y                                                                                                               #Code Type A
      current_node = current_node.next                                                                                                      #Code Type A
    end                                                                                                                                     #Code Type A

    sum_y # and return the sum                                                                                                              #Code Type A
  end                                                                                                                                       #Code Type A

  def sum_xy()
    sum_xy = 0                                                                                                                              #Code Type A
    current_node = @head #go through all the elements in the list from the top                                                              #Code Type A

    while current_node != nil #sum their datums into a grand total.                                                                         #Code Type A
      sum_xy += current_node.x * current_node.y                                                                                             #Code Type A
      current_node = current_node.next                                                                                                      #Code Type A
    end                                                                                                                                     #Code Type A

    sum_xy # and return the sum                                                                                                             #Code Type A
  end                                                                                                                                       #Code Type A

  def sum_x2()                                                                                                                              #Code Type A
    sum_x2 = 0                                                                                                                              #Code Type A
    current_node = @head #go through all the elements in the list from the top                                                              #Code Type A

    while current_node != nil #sum their datums into a grand total.                                                                         #Code Type A
      sum_x2 += current_node.x ** 2                                                                                                         #Code Type A
      current_node = current_node.next                                                                                                      #Code Type A
    end                                                                                                                                     #Code Type A

    sum_x2 # and return the sum                                                                                                             #Code Type A
  end                                                                                                                                       #Code Type A

  def sum_y2()                                                                                                                              #Code Type A
    sum_y2 = 0                                                                                                                              #Code Type A
    current_node = @head #go through all the elements in the list from the top                                                              #Code Type A

    while current_node != nil #sum their datums into a grand total.                                                                         #Code Type A
      sum_y2 += current_node.y ** 2                                                                                                         #Code Type A
      current_node = current_node.next                                                                                                      #Code Type A
    end                                                                                                                                     #Code Type A

    sum_y2 # and return the sum                                                                                                             #Code Type A
  end                                                                                                                                       #Code Type A

  def beta1()                                                                                                                               #Code Type A
    return ( self.sum_xy - self.length * self.average_x * self.average_y ) / (sum_x2 - self.length * ( self.average_x ** 2 ) )              #Code Type A
  end                                                                                                                                       #Code Type A

  def beta0()                                                                                                                               #Code Type A
    return ( self.average_y - self.beta1 * self.average_x )                                                                                 #Code Type A
  end                                                                                                                                       #Code Type A

  def r()                                                                                                                                   #Code Type A
    return ( self.length * self.sum_xy - self.sum_x * self.sum_y ) / Math::sqrt( ( self.length * self.sum_x2 - ( self.sum_x ** 2 ) ) * ( self.length * self.sum_y2 - ( self.sum_y ** 2 ) ) ) #Code Type A
  end                                                                                                                                       #Code Type A

  #def stdDev(numbers, avg) #to calculate the standard deviation                                                                            #Code Type D
  #  sum = 0                                                                                                                                #Code Type D
  #  current_node = numbers.head #go through all the elements in the list from the top                                                      #Code Type D

  #  while current_node != nil #sum the squares of their differences to the average                                                         #Code Type D
  #    sum += (current_node.value - avg) ** 2                                                                                               #Code Type D
  #    current_node = current_node.next                                                                                                     #Code Type D
  #  end                                                                                                                                    #Code Type D

  #  return Math.sqrt(sum / (numbers.length - 1))  #and return the square root of that sum                                                  #Code Type D
  #end                                                                                                                                      #Code Type D
end                                                                                                                                         #Code Type B

#puts "PESC Ago-Dic 2015 -- Asignacion 1"                                                                                                   #Code Type D
#print ">? "                                                                                                                                #Code Type D
#capture from stdin and parse as floats into an array that we'll use to store our data temporarily
#numbers = gets.split(" ").map!(&:to_f)                                                                                                     #Code Type D
#list = LinkedList.new()                                                                                                                    #Code Type D
#op = Operations.new()                                                                                                                      #Code Type D

#if numbers.size == 0                                                                                                                       #Code Type D
#  exit                                                                                                                                     #Code Type D
#else                                                                                                                                       #Code Type D
#  #get all the numbers captured before into the linkedlist                                                                                 #Code Type D
#  numbers.each do |i|                                                                                                                      #Code Type D
#    list.push(i)                                                                                                                           #Code Type D
#  end                                                                                                                                      #Code Type D

#  avg = op.average(list) #then run our magic.                                                                                              #Code Type D
#  stdev = op.stdDev(list, avg)                                                                                                             #Code Type D

#  puts "\nPromedio: %.2f Desviacion estandar: %.2f" % [ avg, stdev ]                                                                       #Code Type D
#end                                                                                                                                        #Code Type D


################################################################
# Finally, the following part of the program outputs what has been
# calculated and evaluates yk as stated in the requirements
################################################################
puts "(type \"end\" to finish input)"                                                                                                       #Code Type A
data = LinkedList.new                                                                                                                       #Code Type A
puts ">? "                                                                                                                                  #Code Type A

loop do                                                                                                                                     #Code Type A
  input = gets.chomp!                                                                                                                       #Code Type A

  if input == "end"                                                                                                                         #Code Type A
    break                                                                                                                                   #Code Type A
  else                                                                                                                                      #Code Type A
    x, y = *input.split(" ").map!(&:to_f)                                                                                                   #Code Type A
    data.push(x, y)                                                                                                                         #Code Type A
  end                                                                                                                                       #Code Type A
end                                                                                                                                         #Code Type A

data.print                                                                                                                                  #Code Type A

beta1 = data.beta1                                                                                                                          #Code Type A
r = data.r                                                                                                                                  #Code Type A
beta0 = data.beta0                                                                                                                          #Code Type A

puts "\nBeta1\t= #{'%.4f' % beta1}"                                                                                                         #Code Type A
puts "r(x, y)\t= #{'%.4f' % r}"                                                                                                             #Code Type A
puts "r^2\t= #{'%.4f' % r ** 2}"                                                                                                            #Code Type A
puts "Beta0\t= #{'%.4f' % beta0}"                                                                                                           #Code Type A

puts "\nLinear regression model for the entered dataset:"                                                                                   #Code Type A
puts "yk = #{'%.4f' % beta0} + #{'%.4f' % beta1}xk"                                                                                         #Code Type A
puts "with r(x, y) = #{'%.4f' % r}, r^2 = #{'%.4f' % r ** 2}"                                                                               #Code Type A

print "\nEnter xk to evaluate against the Linear regression model... >? "                                                                   #Code Type A
x = gets.chomp.to_f                                                                                                                         #Code Type A
puts "yk(#{x}) = #{'%.4f' % beta0} - #{'%.4f' % beta1}#{x} => #{'%.4f' % (beta0 + beta1 * x)}"                                              #Code Type A