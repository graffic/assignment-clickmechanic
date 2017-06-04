require 'test_helper'
require 'simple_warehouse/commands/locate'
require 'simple_warehouse/cli'

include SimpleWarehouse::Commands

describe Locate do
  let(:cmd) { Locate.new }

  it "has the right command" do
    cmd.command.must_equal "locate"
  end

  describe "arguments" do
    it "Matches one string as argument" do
      cmd.extract("this is").must_equal ["this is"]
    end

    it "Matches even one letter" do
      cmd.extract("a").must_equal ["a"]
    end
  end

  describe "action" do
    let(:warehouse) { Object.new }
    let(:context) { SimpleWarehouse::Context.new nil, warehouse }

    it "Says product not found if not found" do
      def warehouse.find(product)
        []
      end

      cmd.action(context, "potato").must_equal [:ok, "No product found"]
    end

    it "Renders coordinates" do
      def warehouse.find(product)
        [[1, 2], [3, 4]]
      end

      cmd.action(context, "potato").must_equal [
        :ok, "Product found in the following positions (x, y):
  - (1, 2)
  - (3, 4)"]

    end
  end
end
