require 'test_helper'
require 'simple_warehouse/commands/init'
require 'simple_warehouse/cli'
require 'simple_warehouse/warehouse'

include SimpleWarehouse::Commands

describe Init do
  let (:cmd) { Init.new }
  let (:context) { SimpleWarehouse::Context.new nil, nil }

  it "Has the right command name" do
    cmd.command.must_equal "init"
  end

  it "Creates a new Warehouse" do
    cmd.action context, 2, 3
    context.warehouse.must_be_kind_of SimpleWarehouse::Warehouse
  end

  it "Has the right dimension" do
    cmd.action context, 2, 3
    context.warehouse.width.must_equal 2
    context.warehouse.height.must_equal 3
  end

  it "Returns ok" do
    status, message = cmd.action context, 2, 3
    status.must_equal :ok
    message.must_equal "Warehouse initialized 2x3."
  end

  describe "extract" do
    it "matches single digit" do
      cmd.extract("1 2").must_equal ["1", "2"]
    end

    it "does not match a zero" do
      cmd.extract("1 0").must_equal :no_match
    end
  end
end
