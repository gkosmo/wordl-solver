#!/usr/bin/env ruby

require 'test/unit'
require_relative 'test_helper'
require_relative 'test_wordl_solver'
require_relative 'test_wordl_solver_interface'
require_relative 'test_integration'

# Create a custom test runner that writes results to a file
class FileOutputTestRunner < Test::Unit::UI::Console::TestRunner
  def initialize(suite, options={})
    @file = File.open('test_results.txt', 'w')
    super(suite, options)
  end

  def output(string)
    @file.puts(string)
    @file.flush
  end

  def finished(elapsed_time)
    super(elapsed_time)
    @file.close
  end
end

# Run the tests with the custom runner
suite = Test::Unit::TestSuite.new
suite << TestWordlSolver.suite
suite << TestWordlSolverInterface.suite
suite << TestIntegration.suite

FileOutputTestRunner.new(suite).start
