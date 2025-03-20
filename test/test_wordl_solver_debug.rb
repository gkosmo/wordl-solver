require_relative 'test_helper'

class TestWordlSolverDebug < Test::Unit::TestCase
  def test_find_possible_words_debug
    # Reset the possible_words instance variable
    WordlSolver.instance_variable_set(:@possible_words, nil)
    
    # Set up test parameters
    greys = []
    greens = { 0 => nil, 1 => nil, 2 => nil, 3 => nil, 4 => nil }
    yellows = { 0 => [], 1 => [], 2 => [], 3 => [], 4 => [] }
    
    # Print the size of LETTER_WORDS
    puts "LETTER_WORDS size: #{LETTER_WORDS.size}"
    puts "LETTER_WORDS first 5 elements: #{LETTER_WORDS[0..4].inspect}"
    
    # Call the method
    result = WordlSolver.find_possible_words(greys, greens, yellows)
    
    # Print the result
    puts "Result size: #{result.size}"
    puts "Result first 5 elements: #{result[0..4].inspect}"
    
    # Print the instance variables
    puts "@possible_words: #{WordlSolver.instance_variable_get(:@possible_words).inspect}"
    puts "@greys: #{WordlSolver.instance_variable_get(:@greys).inspect}"
    puts "@greens: #{WordlSolver.instance_variable_get(:@greens).inspect}"
    puts "@yellows: #{WordlSolver.instance_variable_get(:@yellows).inspect}"
    
    # Assert that the result is not empty
    assert_not_empty result
  end
end
