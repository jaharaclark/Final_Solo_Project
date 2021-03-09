require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/night_writer'
require './test/test_helper'

class NightWriterTest < Minitest::Test
  def setup
    @night_writer = NightWriter.new
  end

  def test_it_exists
    assert_instance_of NightWriter, @night_writer
  end

  def test_translate
    @night_writer.translate

    assert_equal "0.0.0.0.0....00.0.0.00\n00.00.0..0..00.0000..0\n....0.0.0....00.0.0...\n", @night_writer.create_limited_output
  end

  def test_it_can_make_capital
    assert_equal ["..0.", "..00", ".0.."], @night_writer.make_capital("h")
  end

  def test_it_can_make_minuscule
    assert_equal ["0.", "00", ".."], @night_writer.make_minuscule("h")
  end

  def test_it_can_write_message
    braille = File.open("#{ARGV[1]}", "r")
    assert_equal false, braille.read.empty?
  end

end

