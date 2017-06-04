require 'test_helper'
require 'simple_warehouse/commands/view'
require 'simple_warehouse/cli'

include SimpleWarehouse::Commands

describe View do
  let(:cmd) { View.new }

  it "has the right command" do
    cmd.command.must_equal "view"
  end

  it "returns error if no warehouse initialized" do
    context = SimpleWarehouse::Context.new nil, nil
    cmd.action(context).must_equal [:error, "No warehouse initialized"]
  end

  it "renders warehouse space" do
    warehouse = Object.new
    def warehouse.width
      15
    end
    
    def warehouse.space
      row_empty = [:empty] * 15
      row_filled = [:filled] * 15

      [
        row_empty,
        row_empty,
        row_empty,
        row_filled,
        row_filled,
        row_empty,
        row_empty,
        row_filled,
        row_filled,
        row_empty,
        row_empty
      ]
    end

    context = SimpleWarehouse::Context.new nil, warehouse
    expected = "10 ...............
   ...............
   XXXXXXXXXXXXXXX
   XXXXXXXXXXXXXXX
   ...............
   ...............
   XXXXXXXXXXXXXXX
   XXXXXXXXXXXXXXX
   ...............
   ...............
 0 ...............
   0        10    "
    cmd.action(context).must_equal [:ok, expected]
  end
end
