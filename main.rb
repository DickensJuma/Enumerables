# rubocop: disable Metrics/CyclomaticComplexity, Metrics/MethodLength,Metrics/ModuleLength, Metrics/PerceivedComplexity

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

    0.upto(to_a.size - 1) do |i|
      yield to_a[i], i
    end
    to_a
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    result = []
    my_each { |i| result << i if yield(i) }
    result
  end

  def my_all?(arg = nil, &block)
    return true if !block_given? && arg.nil? && include?(nil) == false && include?(false) == false
    return false unless block_given? || !arg.nil?

    if block_given?
      my_each { |i| return false if block.call(i) == false }
    elsif arg.class == Regexp
      my_each { |i| return false if arg.match(i).nil? }
    elsif arg.class <= Numeric || arg.class <= String
      my_each { |i| return false if i != arg }
    else
      my_each { |i| return false if (i.is_a? arg) == false }
    end
    true
  end

  def my_any?(arg = nil, &block)
    return false unless block_given? || !arg.nil? || arg.nil? && arg == false

    if block_given?
      my_each { |i| return true if block.call(i) }
    elsif arg.class == Regexp
      my_each { |i| return true unless arg.match(i).nil? }
    elsif arg.class <= Numeric || arg.class <= String
      my_each { |i| return true if i == arg }
    elsif !block_given? & arg.nil? & arg == false
      return false
    else
      my_each { |i| return true if i.class <= arg }
    end
    false
  end

  def my_none?(*args)
    if block_given?
      to_a.my_each do |i|
        return false if yield i
      end
    elsif args.length.positive? && to_a.length.positive?
      if args[0].class == Regexp
        to_a.my_each do |i|
          return false if i.to_s =~ args[0]
        end
      elsif args[0].class == Class
        to_a.my_each do |i|
          return false if i.is_a? args[0]
        end
      else
        to_a.my_each do |i|
          return false if i == args[0]
        end
      end
    else
      to_a.my_each do |i|
        return false if i
      end
    end
    true
  end

  def my_count(arg = nil, &block)
    result = 0
    my_each do |i|
      if block_given?
        result += 1 if block.call(i)
      elsif !arg.nil?
        result += 1 if i == arg
      else
        result = length
      end
    end
    result
  end

  def my_map(block = nil)
    return to_enum(:my_map) unless block_given?

    arr = []
    my_each { |i| arr << block.call(i) } if block_given? && block
    my_each { |i| arr << yield(i) } if block.nil?
    arr
  end

  def my_inject(arg = nil, symbol = nil, &block)
    arg = arg.to_symbol if arg.is_a?(String) && !symbol && !block
    if arg.is_a?(Symbol) && !symbol
      block = arg.to_proc
      arg = nil
    end

    symbol = symbol.to_symbol if symbol.is_a?(String)
    block = symbol.to_proc if symbol.is_a?(Symbol)

    my_each { |i| arg = arg.nil? ? i : block.yield(arg, i) }
    arg
  end
end

# rubocop: enable Metrics/CyclomaticComplexity, Metrics/MethodLength,Metrics/ModuleLength, Metrics/PerceivedComplexity
