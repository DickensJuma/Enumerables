# frozen_string_literal: true

# rubocop :disable Metrics/BlockLength, Layout/LineLength
require_relative '../lib/main.rb'

describe Enumerable do
  let(:arr) { [1, 2, 3, 4, 5 ] }
  let(:arr_str) { %w[hat plan date] }
  let(:nil_arr) { [nil, true, 72] }
  let(:numerical_arr) { [1, 2i, 3.14] }
  let(:new_arr) { [] }

  describe '#my_each' do
    it 'returns each elements of the array if block is given' do
      expect(arr.my_each { |x| new_arr << x }).to eql(new_arr)
    end

    it "returns enumerator if block is not given." do
      expect(arr.my_each.class).to eql(Enumerator)
    end
  end
  
  describe '#my_each_with_index' do
    it 'it return element with index' do
      arr.my_each_with_index {|i, n| new_arr<< i+n}
      result=[1, 3, 5, 7, 9]
      expect(new_arr).to eql(result)
    end
  end

  
  describe '#my_select' do
    it 'returns an array of elements when the block returns true.' do
      expect(arr.my_select { |n| n > 4 }).to eql([5])
    end

    it "returns enumerator if block is not given." do
      expect(arr.my_select.class).to eql(Enumerator)
    end
  end

  describe '#my_all?' do
    context 'Find all elements matching' do
      it 'when all items executed in block return true.' do
          expect(arr_str.my_all? { |word| word.size > 3 }).to eql(false)
      end

      it "returns false if any value is false when any pattern or block is not provided." do
        expect(nil_arr.my_all?).to eql(false)
      end

      it 'when pattern provided if all elements are absolute  returns true equal to pattern.' do
        expect(arr_str.my_all?(/a/)).to eql(true)
      end
    end
  end

  describe '#my_any?' do
    it 'when any items executed in block returns true.' do
       expect(arr_str.my_any? { |word| word.size > 3 }).to eql(true)
    end

    it 'if any element is absolutely equal to given pattern returns true .' do
      expect(arr_str.my_any?(/d/)).to eql(true)
    end

    it "if all values are false when any pattern or block is not provided returns false ." do
      expect(nil_arr.my_any?).to eql(true)
    end

    
  end

  describe '#my_none?' do
    it 'when none of items executed in block returns true.' do
      expect(arr_str.my_none? { |word| word.size > 3 }).to eql(false)
    end

    it 'if any element is absolutely equal to given pattern returns false.' do
      expect(arr_str.my_none?(/d/)).to eql(false)
    end

    it "if any values is true when any pattern or block is not provided returns false." do
      expect(nil_arr.my_none?).to eql(false)
    end

   
  end

  describe '#my_count' do
    it 'returns the no. of items if any parameter or block not given' do
      expect(arr.my_count).to eql (5)
    end

    it 'returns the no. of items equal to parameter if any parameter given' do
      expect(arr.my_count(2)).to eql (1)
    end

    it 'returns the no. of items executed in block given that returns true' do
      expect(arr.my_count(&:odd?)).to eql (3)
    end
  end

  describe '#my_map' do
    it 'returns a new array contains elements after formed in the block' do
      expect(arr.my_map { |i| i * i }).to eql ([1, 4, 9, 16, 25])
    end

    it "returns enumerator if block is not given." do
      expect(arr.my_map.class).to eql(Enumerator)
    end
  end

  describe '#inject' do
    context 'if accumulator is defined' do
      it 'returns the result of accumulator and items by using given symbol' do
        expect((5..10).reduce(2, :*)).to eql 302_400
      end

      it 'returns the result of accumulator and items by using given block' do
        expect((5..10).inject(2) { |product, n| product * n }).to eql 302_400
      end
    end

    context "if accumulator is not defined" do
      it 'returns the result of items by using given symbol' do
        expect((5..10).reduce(:*)).to eql (151_200)
      end

      it 'returns the result of items by using given block' do
        expect((5..10).inject { |sum, n| sum + n }).to eql(45)
      end

      it 'returns the result of items by using given long block' do
        expect(arr_str.inject {|memo, word| memo.length > word.length ? memo : word}).to eql('date')
      end
    end
  end

end
