#! /usr/bin/ruby

require 'minitest/autorun'
require 'minitest/reporters'

# This make a nice ProgressBar, and Junit report for jenkins.
Minitest::Reporters.use! [Minitest::Reporters::ProgressReporter.new, Minitest::Reporters::JUnitReporter.new]

# Some doc on ruby unitesting.
class SimpleTest < Minitest::Test
  def setup
    gino = nil
  end

  # 1 This fail because no ex.
  def test_FOO_EXCEPTION
    assert_raises RuntimeError do
    end
  end

  # 2  Raise an exception and check the msg.
  def test_MSG_EXCEPTION
  # 2.1 check exception
     ex = assert_raises RuntimeError do
     raise "you are the best."
    end
  # 2.2 check msg exception  
    assert_equal("you are the best.", ex.message) 
  end
end

puts"########TESTING###########"
