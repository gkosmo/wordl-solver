require_relative 'test_helper'

class TestSimpleWordlSolver < Test::Unit::TestCase
  def test_letter_words_loaded
    # Test that LETTER_WORDS is loaded from the CSV file
    assert_not_empty LETTER_WORDS
    assert_instance_of Array, LETTER_WORDS
    assert_instance_of String, LETTER_WORDS.first
    assert_equal 5, LETTER_WORDS.first.length
  end
end
