require 'simple_warehouse/commands/base'

module SimpleWarehouse::Commands
  class Locate < Base
    def initialize
      super("locate P",
            "Show a list of positions where product number can be found.",
            /^(.+)$/)  
    end

    def action(context, product)
      if context.warehouse.nil?
        return [:error, "No warehouse initialized"]
      end

      coords = context.warehouse.find(product).collect do |x, y|
        "  - (#{x}, #{y})"
      end

      if coords.empty?
        return [:ok, "No product found"]
      else
        coords.unshift("Product found in the following positions (x, y):")
        return [:ok, coords.join("\n")]
      end
    end
  end
end
