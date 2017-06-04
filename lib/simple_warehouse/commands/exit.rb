require 'simple_warehouse/commands/base'

module SimpleWarehouse::Commands
  class Exit < Base
    def initialize
      super("exit", "Exits the application.")
    end

    def action(context)
      [:exit,
        "Thank you for using simple_warehouse!"]
    end
  end
end
