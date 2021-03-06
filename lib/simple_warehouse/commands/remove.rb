require 'simple_warehouse/commands/base'

module SimpleWarehouse::Commands
  class Remove < Base
    def initialize
      super("remove X Y",
            "Remove the crate at positon X,Y.",
            /^([1-9][0-9]*)\s([1-9][0-9]*)$/)
    end

    def action(context, x, y)
      if context.warehouse.nil?
        return [:error, "No warehouse initialized"]
      end

      removed = context.warehouse.remove x.to_i, y.to_i
      if removed
        [:ok, "Removed!"]
      else
        [:error, "Couldn't remove crate at (#{x}, #{y})"]
      end
    end
  end
end
