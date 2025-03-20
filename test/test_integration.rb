require_relative 'test_helper'
require 'stringio'

class TestIntegration < Test::Unit::TestCase
  def setup
    # Save original stdin and stdout
    @original_stdin = $stdin
    @original_stdout = $stdout
    
    # Create new stdin and stdout for testing
    @input = StringIO.new
    @output = StringIO.new
    $stdin = @input
    $stdout = @output
    
    # Reset WordlSolver state
    WordlSolver.instance_variable_set(:@possible_words, nil)
  end
  
  def teardown
    # Restore original stdin and stdout
    $stdin = @original_stdin
    $stdout = @original_stdout
  end
  
  def test_find_possible_words_based_on_user_input
    # Simulate a game where the user inputs:
    # - First position: green 'a'
    # - Second position: yellow 'p'
    # - Third position: grey 's'
    # - Fourth position: grey 'k'
    # - Fifth position: green 'e'
    # - Then answers 'y' to "have you found it?"
    @input.string = "ga\nyp\nss\nsk\nge\ny\n"
    @input.rewind
    
    interface = WordlSolverInterface.new
    
    # Capture the exception that will be raised when the method tries to exit
    begin
      interface.run
    rescue SystemExit
      # This is expected
    end
    
    # Check that the output contains some expected words
    output_string = @output.string
    
    # Verify that the interface asked for input for each position
    assert_match(/for position 1/, output_string)
    assert_match(/for position 2/, output_string)
    assert_match(/for position 3/, output_string)
    assert_match(/for position 4/, output_string)
    assert_match(/for position 5/, output_string)
    
    # Verify that the interface presented possible words
    assert_match(/here are the existing words/, output_string)
    
    # Verify that the constraints were set correctly
    greys = interface.instance_variable_get(:@greys)
    greens = interface.instance_variable_get(:@greens)
    yellows = interface.instance_variable_get(:@yellows)
    
    assert_includes greys, 's'
    assert_includes greys, 'k'
    assert_equal 'a', greens[0]
    assert_equal 'e', greens[4]
    assert_includes yellows[1], 'p'
    
    # Verify that WordlSolver was called with the correct constraints
    possible_words = interface.instance_variable_get(:@possible_words)
    assert_not_nil possible_words
    assert_not_empty possible_words
    
    # All words should start with 'a' and end with 'e'
    possible_words.each do |word|
      assert_equal 'a', word[0]
      assert_equal 'e', word[4]
      assert_includes word, 'p'
      assert_not_equal 'p', word[1]  # 'p' is yellow in position 1
      assert_not_includes word, 's'
      assert_not_includes word, 'k'
    end
  end
end
