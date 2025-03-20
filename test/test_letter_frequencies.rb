require_relative 'test_helper'
require 'stringio'

class TestLetterFrequencies < Test::Unit::TestCase
  def setup
    @interface = WordlSolverInterface.new
    @interface.instance_variable_set(:@possible_words, ["apple", "banana"])
  end
  
  def test_set_letter_frequencies
    @interface.send(:set_letters_frequencies)
    
    frequencies = @interface.instance_variable_get(:@frenquencies)
    puts "Frequencies: #{frequencies.inspect}"
    
    # Check each letter frequency
    puts "a: #{frequencies['a']}"
    puts "p: #{frequencies['p']}"
    puts "l: #{frequencies['l']}"
    puts "e: #{frequencies['e']}"
    puts "b: #{frequencies['b']}"
    puts "n: #{frequencies['n']}"
    
    # Assert the frequencies
    assert_equal 4, frequencies["a"]  # 'a' appears 4 times: once in "apple" and three times in "banana"
    assert_equal 2, frequencies["p"]  # 'p' appears 2 times: twice in "apple"
    assert_equal 1, frequencies["l"]  # 'l' appears 1 time: once in "apple"
    assert_equal 1, frequencies["e"]  # 'e' appears 1 time: once in "apple"
    assert_equal 1, frequencies["b"]  # 'b' appears 1 time: once in "banana"
    assert_equal 2, frequencies["n"]  # 'n' appears 2 times: twice in "banana"
  end
end
