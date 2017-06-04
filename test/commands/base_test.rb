require 'simple_warehouse/commands/base'
require 'minitest/spec'

include SimpleWarehouse::Commands

describe Base do
  class TestBaseCommand < Base
    def initialize
      super("command A B",
            "Help",
            /^([1-9][0-9]*)\s([1-9][0-9]*)$/)
    end
  end

  let(:cmd) { TestBaseCommand.new }

  describe "Initialize" do
    it "right full_command" do
      cmd.full_command.must_equal "command A B"
    end

    it "has description" do
      cmd.description.must_equal "Help"
    end

    it "extracts command name" do
      cmd.command.must_equal "command"
    end
  end

  describe "Extract arguments" do
    it "returns :no_match on error" do
      cmd.extract("potato").must_equal :no_match
    end

    it "Returns an array with the captures" do
      cmd.extract("12 3").must_equal ["12", "3"]
    end
  end

  it "If no action, have a default one" do
    cmd.action(nil).must_equal [:ok, "did nothing"]
  end
end
