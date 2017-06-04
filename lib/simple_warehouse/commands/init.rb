require 'simple_warehouse/commands/base'
require 'simple_warehouse/warehouse'

module SimpleWarehouse::Commands
  class Init < Base
    def initialize
      super("init W H",
            "(Re)Initialises the application as a W x H warehouse, with all spaces empty.",
            /^([1-9][0-9]*)\s([1-9][0-9]*)$/)
    end

    def action(context, width, height)
      context.warehouse = SimpleWarehouse::Warehouse.new width.to_i, height.to_i
      [:ok, "Warehouse initialized #{width}x#{height}."]
    end
  end
end
