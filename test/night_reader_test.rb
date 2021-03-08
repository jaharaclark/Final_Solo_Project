require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/night_reader'
require './test/test_helper'

class NightReaderTest < Minitest::Test
  def setup
    @night_reader = NightReader.new
    @night_reader.stubs(:message).returns(["0.", "00", ".."])
    @night_reader.stubs(:braille).returns("hello world")
  end

  def test_it_exists
    assert_instance_of NightReader, @night_reader
  end

  def test_it_can_create_symbol_array
    assert_equal [[["0.0.0.0.0....00.0.0.00"]], [["00.00.0..0..00.0000..0"]], [["....0.0.0....00.0.0..."]]], @night_reader.create_symbol_array
  end

  def test_it_can_create_letter_array
 expected =   
 [["0", ".", "0", "0", ".", "."],
 ["0", ".", ".", "0", ".", "."],
 ["0", ".", "0", ".", "0", "."],
 ["0", ".", "0", ".", "0", "."],
 ["0", ".", ".", "0", "0", "."],
 [".", ".", ".", ".", ".", "."],
 [".", "0", "0", "0", ".", "0"],
 ["0", ".", ".", "0", "0", "."],
 ["0", ".", "0", "0", "0", "."],
 ["0", ".", "0", ".", "0", "."],
 ["0", "0", ".", "0", ".", "."]]
 assert_equal expected, @night_reader.create_letter_array
  end
  
  def test_generate_output
    assert_equal "hello world", @night_reader.generate_output
  end
  
  def test_it_can_write_message
    message = File.open("#{ARGV[1]}", "r")
    assert_equal false, message.read.empty?
  end

  def test_confirmation
    assert_nil @night_reader.confirmation
  end
end