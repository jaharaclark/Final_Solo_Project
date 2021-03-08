require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/night_writer'

class NightWriterTest < Minitest::Test
  def setup
    @night_writer = NightWriter.new
    @night_writer.stubs(:message).returns("hello world")
  end

  def test_it_exists
    assert_instance_of NightWriter, @night_writer
  end

  def test_translate
    assert_equal "0.0.0.0.0....00.0.0.00\n00.00.0..0..00.0000..0\n....0.0.0....00.0.0...\n", @night_writer.translate
  end

end

# read_message
    # translate
    # write_message
    # confirmation
    # make_capital(letter)
    # make_minuscule(letter)