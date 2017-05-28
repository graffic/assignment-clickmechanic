require 'simple_warehouse/warehouse'
require 'minitest/spec'

include SimpleWarehouse

describe Warehouse do
  let(:warehouse) { Warehouse.new(5, 5) }
  let(:crate) { Crate.new(2, 2, "potatoes") }

  [
    [-1, 0, "left"],
    [-1, -1, "bottom left"],
    [0, -1, "bottom"],
    [5, 0, "right"],
    [5, 5, "top right"],
    [0, 5, "top"]
  ].each do |x, y, desc|
    it "cannot store ouside limits #{desc}" do
      warehouse.store!(x, y, crate).must_equal false
    end
  end

  [
    [0, 0, "bottom left"],
    [2, 0, "bottom"],
    [3, 0, "bottom right"],
    [0, 1, "left"],
    [3, 1, "right"],
    [0, 3, "top left"],
    [2, 3, "top"],
    [3, 3, "top right"]
  ].each do |x, y, desc|
    it "cannot store if overlaps #{desc}" do
      warehouse.store!(1, 1, Crate.new(3, 3, "potatoes"))
      warehouse.store!(x, y, crate).must_equal false
    end
  end
end

describe StoredCrate do
  let(:crate) { Crate.new(3, 3, "potatoes") }
  let(:sut) { StoredCrate.new(Position.new(3, 3), crate) }

  describe "It does not overlap" do
    [
      [0, 0, "bottom left"],
      [3, 0, "bottom"],
      [6, 0, "bottom right"],
      [0, 3, "left"],
      [6, 3, "right"],
      [0, 6, "top left"],
      [3, 6, "top"],
      [6, 6, "top right"]
    ].each do |x, y, desc|
      it "to the #{desc}" do
        other = StoredCrate.new(Position.new(x, y), crate)
        sut.overlaps?(other).must_equal false
      end
    end

  end

  describe "It does overlap" do
    [
      [1, 1, "bottom left"],
      [3, 1, "bottom"],
      [5, 1, "bottom right"],
      [1, 3, "left"],
      [5, 3, "right"],
      [1, 5, "top left"],
      [3, 5, "top"],
      [5, 5, "top right"]
    ].each do |x, y, desc|
      it "to the #{desc}" do
        other = StoredCrate.new(Position.new(x, y), crate)
        sut.overlaps?(other).must_equal true
      end
    end
  end
end

