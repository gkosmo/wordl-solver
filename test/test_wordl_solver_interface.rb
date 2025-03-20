
require_relative 'test_helper'
require 'stringio'

class TestWordlSolverInterface < Test::Unit::TestCase
  def setup
    # Save original stdin and stdout
    @original_stdin = $stdin
    @original_stdout = $stdout
    
    # Create new stdin and stdout for testing
    @input = StringIO.new
    @output = StringIO.new
    $stdin = @input
    $stdout = @output
    
    # Create a new instance of the interface
    @interface = WordlSolverInterface.new
  end
  
  def teardown
    # Restore original stdin and stdout
    $stdin = @original_stdin
    $stdout = @original_stdout
  end
  
  def test_initialize_with_empty_constraints
    assert_equal [], @interface.instance_variable_get(:@greys)
    
    greens = @interface.instance_variable_get(:@greens)
    assert_equal 5, greens.size
    assert_nil greens[0]
    assert_nil greens[1]
    assert_nil greens[2]
    assert_nil greens[3]
    assert_nil greens[4]
    
    yellows = @interface.instance_variable_get(:@yellows)
    assert_equal 5, yellows.size
    assert_equal [], yellows[0]
    assert_equal [], yellows[1]
    assert_equal [], yellows[2]
    assert_equal [], yellows[3]
    assert_equal [], yellows[4]
  end
  
  def test_sort_grey_letters
    @interface.send(:sort_letter_upon_color, "sa", 0)
    
    assert_equal ["a"], @interface.instance_variable_get(:@greys)
    assert_nil @interface.instance_variable_get(:@greens)[0]
    assert_equal [], @interface.instance_variable_get(:@yellows)[0]
  end
  
  def test_sort_yellow_letters
    @interface.send(:sort_letter_upon_color, "ya", 0)
    
    assert_equal [], @interface.instance_variable_get(:@greys)
    assert_nil @interface.instance_variable_get(:@greens)[0]
    assert_equal ["a"], @interface.instance_variable_get(:@yellows)[0]
  end
  
  def test_sort_green_letters
    @interface.send(:sort_letter_upon_color, "ga", 0)
    
    assert_equal [], @interface.instance_variable_get(:@greys)
    assert_equal "a", @interface.instance_variable_get(:@greens)[0]
    assert_equal [], @interface.instance_variable_get(:@yellows)[0]
  end
  
  def test_validate_input_letters
    assert @interface.send(:word_is_correct?, "sa")
    assert @interface.send(:word_is_correct?, "ya")
    assert @interface.send(:word_is_correct?, "ga")
    
    assert !@interface.send(:word_is_correct?, "a")
    assert !@interface.send(:word_is_correct?, "saa")
    assert !@interface.send(:word_is_correct?, "xa")
  end
  
  def test_remove_grey_letters_that_are_also_green_or_yellow
    @interface.instance_variable_set(:@greys, ["a", "b", "c"])
    @interface.instance_variable_set(:@greens, { 0 => "a", 1 => nil, 2 => nil, 3 => nil, 4 => nil })
    @interface.instance_variable_set(:@yellows, { 0 => [], 1 => ["b"], 2 => [], 3 => [], 4 => [] })
    
    @interface.send(:sort_letter_upon_color, "sd", 2)
    
    greys = @interface.instance_variable_get(:@greys)
    assert_equal ["c", "d"], greys.sort
    assert_not_includes greys, "a"
    assert_not_includes greys, "b"
  end
  
    def test_set_letter_frequencies
      # Mock possible_words
      @interface.instance_variable_set(:@possible_words, ["apple", "banana"])
      
      @interface.send(:set_letters_frequencies)
      
      frequencies = @interface.instance_variable_get(:@frenquencies)
      assert_equal 4, frequencies["a"]  # 'a' appears 4 times: once in "apple" and three times in "banana"
      assert_equal 2, frequencies["p"]  # 'p' appears 2 times: twice in "apple"
      assert_equal 1, frequencies["l"]  # 'l' appears 1 time: once in "apple"
      assert_equal 1, frequencies["e"]  # 'e' appears 1 time: once in "apple"
      assert_equal 1, frequencies["b"]  # 'b' appears 1 time: once in "banana"
      assert_equal 2, frequencies["n"]  # 'n' appears 2 times: twice in "banana"
    end
  
  def test_retrieve_input_letters
    # Simulate user input
    @input.string = "sa\n"
    @input.rewind
    
    result = @interface.send(:retrieve_input_letters)
    
    assert_equal "sa", result
  end
  
  def test_ask_for_input_again_if_invalid
    # Simulate user input with an invalid input followed by a valid one
    @input.string = "invalid\nsa\n"
    @input.rewind
    
    result = @interface.send(:retrieve_input_letters)
    
    assert_equal "sa", result
    assert_includes @output.string, "sorry, didn't catch that, try again"
  end
end
