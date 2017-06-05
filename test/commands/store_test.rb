require 'test_helper'
require 'simple_warehouse/commands/store'
require 'simple_warehouse/warehouse'
require 'simple_warehouse/cli'

include SimpleWarehouse::Commands

describe Store do
  let(:cmd) { Store.new }

  it "has the command store" do
    cmd.command.must_equal "store"
  end

  describe "parameters" do
    it "Matches X Y W H P parameters"  do
      cmd.extract("1 2 3 4 My house").must_equal ["1", "2", "3", "4", "My house"]
    end

    it "X Y can be zero" do
      cmd.extract("0 0 3 4 My house").must_equal ["0", "0", "3", "4", "My house"]
    end
  end

  describe "action" do
    let (:warehouse) { MiniTest::Mock.new }
    let (:context) { SimpleWarehouse::Context.new nil, warehouse }

    before do
      def warehouse.nil?
        false
      end
    end

    it "checks for non initialized warehouse" do
      context.warehouse = nil
      cmd.action(context, 1, 2, 3, 4, "Test a").must_equal [
        :error, "No warehouse initialized"]
    end

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
