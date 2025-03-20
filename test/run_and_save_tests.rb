#!/usr/bin/env ruby

require 'test/unit'
require_relative 'test_helper'
require_relative 'test_wordl_solver'
require_relative 'test_wordl_solver_interface'
require_relative 'test_integration'

# Redirect Test::Unit output to a file
output_file = File.open('test_results.txt', 'w')
Test::Unit::UI::Console::TestRunner.output = output_file

# Run the tests
Test::Unit::AutoRunner.run

# Close the file
output_file.close

puts "Tests completed. Results saved to test_results.txt"
