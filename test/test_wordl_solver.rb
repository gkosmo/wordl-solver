require_relative 'test_helper'

class TestWordlSolver < Test::Unit::TestCase
  def setup
    # Reset the possible_words instance variable before each test
    WordlSolver.instance_variable_set(:@possible_words, nil)
    
    # Make sure LETTER_WORDS is not empty
    assert_not_empty LETTER_WORDS, "LETTER_WORDS array is empty"
    
    # Print some debug information
    puts "LETTER_WORDS size: #{LETTER_WORDS.size}"
    puts "LETTER_WORDS first 5 elements: #{LETTER_WORDS[0..4].inspect}"
  end

  def test_find_possible_words_with_no_constraints
    greys = []
    greens = { 0 => nil, 1 => nil, 2 => nil, 3 => nil, 4 => nil }
    yellows = { 0 => [], 1 => [], 2 => [], 3 => [], 4 => [] }
    
    result = WordlSolver.find_possible_words(greys, greens, yellows)
    
    assert_equal LETTER_WORDS, result
    assert_not_empty result
  end

  def test_filter_words_with_green_letters
    greys = []
    greens = { 0 => 'a', 1 => nil, 2 => nil, 3 => nil, 4 => nil }
    yellows = { 0 => [], 1 => [], 2 => [], 3 => [], 4 => [] }
    
    result = WordlSolver.find_possible_words(greys, greens, yellows)
    
    assert_not_empty result
    result.each do |word|
      assert_equal 'a', word[0]
    end
  end

  def test_filter_words_with_multiple_green_letters
    greys = []
    greens = { 0 => 'a', 1 => nil, 2 => 'p', 3 => nil, 4 => 'e' }
    yellows = { 0 => [], 1 => [], 2 => [], 3 => [], 4 => [] }
    
    result = WordlSolver.find_possible_words(greys, greens, yellows)
    
    assert_not_empty result
    result.each do |word|
      assert_equal 'a', word[0]
      assert_equal 'p', word[2]
      assert_equal 'e', word[4]
    end
  end

  def test_filter_words_with_yellow_letters
    greys = []
    greens = { 0 => nil, 1 => nil, 2 => nil, 3 => nil, 4 => nil }
    yellows = { 0 => ['a'], 1 => [], 2 => [], 3 => [], 4 => [] }
    
    result = WordlSolver.find_possible_words(greys, greens, yellows)
    
    assert_not_empty result
    result.each do |word|
      assert_includes word, 'a'
      assert_not_equal 'a', word[0]
    end
  end

  def test_filter_words_with_multiple_yellow_letters
    greys = []
    greens = { 0 => nil, 1 => nil, 2 => nil, 3 => nil, 4 => nil }
    yellows = { 0 => ['a'], 1 => ['p'], 2 => [], 3 => [], 4 => [] }
    
    result = WordlSolver.find_possible_words(greys, greens, yellows)
    
    assert_not_empty result
    result.each do |word|
      assert_includes word, 'a'
      assert_includes word, 'p'
      assert_not_equal 'a', word[0]
      assert_not_equal 'p', word[1]
    end
  end

  def test_filter_words_with_grey_letters
    greys = ['z']
    greens = { 0 => nil, 1 => nil, 2 => nil, 3 => nil, 4 => nil }
    yellows = { 0 => [], 1 => [], 2 => [], 3 => [], 4 => [] }
    
    result = WordlSolver.find_possible_words(greys, greens, yellows)
    
    assert_not_empty result
    result.each do |word|
      assert_not_includes word, 'z'
    end
  end

  def test_filter_words_with_multiple_grey_letters
    greys = ['z', 'q', 'x']
    greens = { 0 => nil, 1 => nil, 2 => nil, 3 => nil, 4 => nil }
    yellows = { 0 => [], 1 => [], 2 => [], 3 => [], 4 => [] }
    
    result = WordlSolver.find_possible_words(greys, greens, yellows)
    
    assert_not_empty result
    result.each do |word|
      assert_not_includes word, 'z'
      assert_not_includes word, 'q'
      assert_not_includes word, 'x'
    end
  end

  def test_handle_combination_of_green_yellow_and_grey_letters
    greys = ['z', 'q', 'x']
    greens = { 0 => 'a', 1 => nil, 2 => nil, 3 => nil, 4 => 'e' }
    yellows = { 0 => [], 1 => ['p'], 2 => [], 3 => [], 4 => [] }
    
    result = WordlSolver.find_possible_words(greys, greens, yellows)
    
    assert_not_empty result
    result.each do |word|
      assert_equal 'a', word[0]
      assert_equal 'e', word[4]
      assert_includes word, 'p'
      assert_not_equal 'p', word[1]
      assert_not_includes word, 'z'
      assert_not_includes word, 'q'
      assert_not_includes word, 'x'
    end
  end

  def test_handle_letter_both_green_and_grey
    greys = ['a']
    greens = { 0 => 'a', 1 => nil, 2 => nil, 3 => nil, 4 => nil }
    yellows = { 0 => [], 1 => [], 2 => [], 3 => [], 4 => [] }
    
    result = WordlSolver.find_possible_words(greys, greens, yellows)
    
    assert_not_empty result
    result.each do |word|
      assert_equal 'a', word[0]
      assert_equal 1, word.count('a')  # Should only have one 'a'
    end
  end

  def test_return_empty_array_when_no_words_match
    greys = []
    greens = { 0 => 'z', 1 => 'z', 2 => 'z', 3 => 'z', 4 => 'z' }
    yellows = { 0 => [], 1 => [], 2 => [], 3 => [], 4 => [] }
    
    result = WordlSolver.find_possible_words(greys, greens, yellows)
    
    assert_empty result
  end
end
