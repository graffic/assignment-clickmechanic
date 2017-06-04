require 'test_helper'
require 'simple_warehouse/cli'

describe "E2E" do
  it "Scenario for cli" do
    cli = SimpleWarehouse::CLI.new
    inputs = [
      "help",
      "init 5 5",
      "store 0 0 2 2 Fried chips", 
      "view",
      "locate Fried chips",
      "remove 1 1",
      "view",
      "exit"
    ].each
    next_input = lambda { inputs.next }

    singleton_class = class << cli; self; end
    singleton_class.send(:define_method, :gets) do
      next_input.call
    end


    outputs = []
    singleton_class.send(:define_method, :puts) do |output|
      outputs.push(output + "\n")
    end

    singleton_class.send(:define_method, :print) do |output|
      outputs.push(output)
    end

    cli.run

    outputs.must_equal [
      "Type `help` for instructions on usage\n",
      "> ",
      "help             Shows this help message.
init W H         (Re)Initialises the application as a W x H warehouse, with all spaces empty.
store X Y W H P  Stores a crate of product number P and of size W x H at position X,Y.
locate P         Show a list of positions where product number can be found.
remove X Y       Remove the crate at positon X,Y.
view             Show a representation of the current state of the warehouse, marking each position as filled or empty.
exit             Exits the application.\n",
      "> ",
      "Warehouse initialized 5x5.\n",
      "> ",
      "Stored!\n",
      "> ",
      "  .....
  .....
  .....
  XX...
0 XX...
  0    \n",
      "> ",
      "Product found in the following positions (x, y):
  - (0, 0)
  - (0, 1)
  - (1, 0)
  - (1, 1)\n",
      "> ",
      "Removed!\n",
      "> ", 
      "  .....
  .....
  .....
  .....
0 .....
  0    \n",
      "> ", 
      "Thank you for using simple_warehouse!\n"
    ]
  end
end
