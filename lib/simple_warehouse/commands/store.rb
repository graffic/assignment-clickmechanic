require 'simple_warehouse/commands/base'

module SimpleWarehouse::Commands
  class Store < Base
    def initialize
      super("store X Y W H P",
            "Stores a crate of product number P and of size W x H at position X,Y.",
            /^([1-9][0-9]*)\s([1-9][0-9]*)\s([1-9][0-9]*)\s([1-9][0-9]*)\s(..*)$/)
    end

    def action(context, x, y, width, height, product)
      crate = SimpleWarehouse::Crate.new width.to_i, height.to_i, product
      stored = context.warehouse.store x.to_i, y.to_i, crate
      if stored
        return :ok, "Stored!"
      end
      return :error, "Cannot store at (#{x}, #{y})"
    end
  end
end
