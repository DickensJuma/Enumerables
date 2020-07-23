#   my_each
#   puts
#   print [1, 2, 3].my_each { |n| print (n+ 1).to_s + " "} # => 2 3 4
#

#    my_each_with_index
#   puts
#   print [1, 2, 3].my_each_with_index { |elem, i| puts "#{elem} : #{i}" } # => 1 : 0, 2 : 1, 3 : 2
#

#   my_select
#   p [1,2,3,8,9].my_select { |n| n.even? } # => [2, 8]
#   p [0, 456, 1435, -7].my_select { |n| n > 0 } # => [456, 1435]
#   p [16, 11, 103].my_select(&:odd?) # => [11, 103]
#

#    my_all?
#   p [13, 5, 17, 11].my_all? { |n| n.odd? } # => true
#   p [-8, -9, -6].my_all? { |n| n < 0 } # => true
#
#    my_any?
#   p [32,45,64].my_any?(Integer) # => true
#   p [71, 10, 13, 5].my_any? { |n| n.even? } # => true
#   p [27, 10, 4, 5].my_any?() { |n| n.even? } # => true
#   p ["q", "r", "s", "i"].my_any? { |char| "aeiou".include?(char) } # => true
#

#    my_none?
#   p [3, 5, 7, 11].my_none? { |n| n.even? } # => true
#   p ["omenie", "apple", "kuki"].my_none? { |n| n[0] == "a" } # => true
#   p [3, 5, 4, 7, 11].my_none? { |n| n.even? } # => false
#

#   my_count
#   p [1,4,3,8].my_count { |n| n.even? } # => 2
#   p ["DICKENS", "HAT", "PLAN", "dave"].my_count { |s| s == s.upcase } # => 3
#

#    my_map
#   p [1,2,3,4,5].my_map { |n| 2 * n } # => [2,4,6,8,10]
#   p ["marry", "Juma"].my_map { |n| n + "?" } # => ["marry?", "Juma?"]

#    my_inject

#   p [1,2,3,4,5].my_inject { |acc, elem| acc + elem} # => 15
