require "test_helper"

class SimpleWarehouseTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::SimpleWarehouse::VERSION
  end
end
