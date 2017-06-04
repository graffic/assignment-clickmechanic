require 'simple_warehouse/commands/base'

module SimpleWarehouse::Commands
  class View < Base
    def initialize
      super("view",
            "Show a representation of the current state of the warehouse, marking each position as filled or empty.")
    end

    def action(context)
      warehouse = context.warehouse
      if warehouse.nil?
        return [:error , "No warehouse initialized"]
      end

      lines = warehouse.space.reverse.collect do |line|
        line.collect {|x| x == :empty ? '.' : 'X'} .join('')
      end
      lines.push(x_axis(warehouse.width))
      lines = y_axis(lines)

      [:ok, lines.join("\n")]
    end

    private

    def y_axis(lines)
      height = lines.length - 1
      number_width = height.to_s.length
      empty = ' ' * (number_width + 1)

      new_lines = height.downto(0).collect do |index| 
        line = lines[height - index]
        current = index - 1
        if current % 10 == 0
          sprintf("%#{number_width}d ", current) + line
        else
          empty + line
        end
      end
      new_lines
    end

    def x_axis(width)
      line = (0..width)
        .step(10)
        .drop(1)
        .reduce("") { |memo, x| memo + sprintf("%10d", x) }
      "0" + line + (' ' * ((width - 1) % 10))
    end
  end
end
