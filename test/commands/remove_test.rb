require 'test_helper'
require 'simple_warehouse/commands/remove'
require 'simple_warehouse/cli'

include SimpleWarehouse::Commands

describe Remove do
  let(:cmd) { Remove.new }

  it "has the right command" do
    cmd.command.must_equal "remove"
  end

  describe "action" do
    let(:warehouse) { MiniTest::Mock.new }
    let(:context) { SimpleWarehouse::Context.new nil, warehouse}

    it "returns ok if removed" do
      def warehouse.remove(*any)
        true
      end

      cmd.action(context, "1", "2").must_equal [:ok, "Removed!"]
    end

    it "returns error if a problem arises" do
      def warehouse.remove(*any)
        false
      end

      cmd.action(context, "1", "2").must_equal [:error, "Couldn't remove crate at (1, 2)"]
    end

    it "removes the right position" do
      warehouse.expect(:remove, true, [1, 2])
      cmd.action(context, "1", "2")
      warehouse.verify
    end
  end
end
