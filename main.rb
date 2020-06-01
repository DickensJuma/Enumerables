# rubocop: disable Metrics/CyclomaticComplexity, Metrics/ModuleLength, Metrics/MethodLength, Metrics/PerceivedComplexity

module Enumerable
    def my_each
      return enum_for(:my_each) unless block_given?
  
      0.upto(to_a.size - 1) do |n|
        yield to_a[n]
      end
      to_a
    end
  
    def my_each_with_index
      return enum_for(:my_each) unless block_given?
  
      0.upto(to_a.size - 1) do |k|
        yield to_a[k], k
      end
      to_a
    end
  
    def my_select
      return to_enum(:my_select) unless block_given?
  
      result = []
      my_each { |item| result << item if yield(item) }
      result
    end
  
    def my_all?(*args)
      result = true
      if !args[0].nil?
        my_each { |n| result = false unless args[0] == n }
      elsif !block_given?
        my_each { |n| result = false unless n }
      else
        my_each { |n| result = false unless yield(n) }
      end
      result
    end
  
    def my_all?(arg = nil)
      check = true
      if arg.class == Class
        my_each { |i| check = false unless arg === i }
      elsif arg.class == Regexp
        my_each { |i| check = false unless arg.match? i }
      elsif block_given?
        my_each { |i| check = false unless yield i }
      elsif arg
        my_each { |i| check = false unless arg == i }
      else
        my_each { |i| check = false unless i }
      end
      check
    end
  
    def my_none?(*args)
      if block_given?
        to_a.my_each do |item|
          return false if yield item
        end
      elsif args.length.positive? && to_a.length.positive?
        if args[0].class == Regexp
          to_a.my_each do |item|
            return false if item.to_s =~ args[0]
          end
        elsif args[0].class == Class
          to_a.my_each do |item|
            return false if item.is_a? args[0]
          end
        else
          to_a.my_each do |item|
            return false if item == args[0]
          end
        end
      else
        to_a.my_each do |item|
          return false if item
        end
      end
      true
    end
  
    def my_count(arg = nil, &prc)
      result = 0
      my_each do |elem|
        if block_given?
          result += 1 if prc.call(elem)
        elsif !arg.nil?
          result += 1 if elem == arg
        else
          result = length
        end
      end
      result
    end
  
    def my_map(prc = nil)
      return to_enum(:my_map) unless block_given?
  
      arr = []
      my_each { |elem| arr << prc.call(elem) } if block_given? && prc
      my_each { |elem| arr << yield(elem) } if prc.nil?
      arr
    end
  
    def my_inject(arg = nil, symbol = nil, &prc)
      arg = arg.to_symbol if arg.is_a?(String) && !symbol && !prc
  
      if arg.is_a?(Symbol) && !symbol
        prc = arg.to_proc
        arg = nil
      end
  
      symbol = symbol.to_symbol if symbol.is_a?(String)
      prc = symbol.to_proc if symbol.is_a?(Symbol)
  
      my_each { |elem| arg = arg.nil? ? elem : prc.yield(arg, elem) }
      arg
    end
  end
  
  # rubocop: enable Metrics/CyclomaticComplexity, Metrics/ModuleLength, Metrics/MethodLength, Metrics/PerceivedComplexity
  