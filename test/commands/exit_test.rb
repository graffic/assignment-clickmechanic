require 'simple_warehouse/commands/exit'
require 'minitest/spec'

include SimpleWarehouse::Commands

describe Exit do
  let (:cmd) { Exit.new }

  it "returns action :exit" do
    status, _ = cmd.action "context"
    status.must_equal :exit
  end

  it "returns msg" do
    _, msg = cmd.action "context"
    msg.must_equal "Thank you for using simple_warehouse!"
  end

  it "has the right command" do
    cmd.command.must_equal "exit"
  end
end
