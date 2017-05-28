require 'simple_warehouse/warehouse'
require 'minitest/spec'

include SimpleWarehouse

describe StoredCrate do
  let(:crate) { Crate.new(3, 3, "potatoes") }
  let(:sut) { StoredCrate.new(Position.new(3, 3), crate) }

  describe "It does not overlap" do
    [
      [0, 0, "top left"],
      [3, 0, "top"],
      [6, 0, "top right"],
      [0, 3, "left"],
      [6, 3, "right"],
      [0, 6, "bottom left"],
      [3, 6, "bottom"],
      [6, 6, "bottom right"]
    ].each do |x, y, desc|
      it "to the #{desc}" do
        other = StoredCrate.new(Position.new(x, y), crate)
        sut.overlaps?(other).must_equal false
      end
    end

  end

  describe "It does overlap" do
    [
      [1, 1, "top left"],
      [3, 1, "top"],
      [5, 1, "top right"],
      [1, 3, "left"],
      [5, 3, "right"],
      [1, 5, "bottom left"],
      [3, 5, "bottom"],
      [5, 5, "bottom right"]
    ].each do |x, y, desc|
      it "to the #{desc}" do
        other = StoredCrate.new(Position.new(x, y), crate)
        sut.overlaps?(other).must_equal true
      end
    end
  end
end

