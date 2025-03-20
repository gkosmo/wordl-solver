begin
  require 'simplecov'
  SimpleCov.start if ENV["COVERAGE"]
rescue LoadError
  # SimpleCov is not available, skipping coverage
end

require 'test/unit'

begin
  require 'shoulda'
rescue LoadError
  # Shoulda is not available, skipping
  puts "Shoulda gem not found. Some tests may not work correctly."
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'wordl_solver'
require 'wordl_solver_interface'
