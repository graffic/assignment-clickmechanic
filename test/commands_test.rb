require 'simple_warehouse/commands'
require 'simple_warehouse/cli'
require 'minitest/spec'

include SimpleWarehouse::Commands

class DummyRouter
  attr_accessor :commands
  def initialize(cmds)
    @commands = cmds
  end
end

DummyCmd2 = Struct.new("DummyCmd", :full_command, :description)

describe Help do
  let (:cmd) { Help.new }

  it "has the right command" do
    cmd.command.must_equal "help"
  end

  it "lists all commands" do
    commands = {
      :A => DummyCmd2.new("A", "My A"),
      :B => DummyCmd2.new("B C D", "My B"),
    }
    context = SimpleWarehouse::Context.new DummyRouter.new(commands), nil
    status, res = cmd.action(context)

    res.must_equal "A      My A\nB C D  My B"
  end
end

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
