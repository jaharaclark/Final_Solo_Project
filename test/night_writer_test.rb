require 'minitest/autorun'
require 'minitest/pride'
require './lib/night_writer'

class NightWriterTest < Minitest::Test
  def setup
    @night_writer = NightWriter.new
  end

  def test_it_exists_and_has_attributes
    assert_instance_of NightWriter, @night_writer
  end
end