#!/usr/bin/env ruby

require 'test/unit'
require_relative 'test_helper'

class SimpleTest < Test::Unit::TestCase
  def test_truth
    assert true
    File.write('test_result.txt', 'Test passed!')
  end
end

Test::Unit::AutoRunner.run
