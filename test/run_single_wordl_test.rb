#!/usr/bin/env ruby

require 'test/unit'
require_relative 'test_helper'

# Define a simple test case that runs a single test from TestWordlSolver
class SingleWordlTest < Test::Unit::TestCase
  def test_find_possible_words
    # Set up the test
    WordlSolver.instance_variable_set(:@possible_words, nil)
    
    # Run the test
    greys = []
    greens = { 0 => nil, 1 => nil, 2 => nil, 3 => nil, 4 => nil }
    yellows = { 0 => [], 1 => [], 2 => [], 3 => [], 4 => [] }
    
    result = WordlSolver.find_possible_words(greys, greens, yellows)
    
    # Write the result to a file
    File.write('wordl_test_result.txt', "Test ran successfully. Result size: #{result.size}")
  end
end

# Run the test
Test::Unit::AutoRunner.run
