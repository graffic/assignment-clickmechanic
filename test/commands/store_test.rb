require 'simple_warehouse/commands/store'
require 'simple_warehouse/warehouse'
require 'simple_warehouse/cli'
require 'minitest/spec'

include SimpleWarehouse::Commands

describe Store do
  let(:cmd) { Store.new }

  it "has the command store" do
    cmd.command.must_equal "store"
  end

  describe "action" do
    let (:warehouse) { MiniTest::Mock.new }
    let (:context) { SimpleWarehouse::Context.new nil, warehouse }

    it "returns ok when stored" do
      def warehouse.store(*any)
        true
      end

      cmd.action(context, 1, 2, 3, 4, "Test a").must_equal [:ok, "Stored!"]
    end

    it "returns error if a problem arises" do
      def warehouse.store(*any)
        false
      end

      cmd.action(context, 1, 2, 3, 4, "Test a").must_equal [
        :error, "Cannot store at (1, 2)"]
    end

    it "stores at the right position" do
      warehouse.expect(:store, true, [1, 2, SimpleWarehouse::Crate])
      cmd.action(context, 1, 2, 3, 4, "Test a")
      warehouse.verify
    end
  end
end
