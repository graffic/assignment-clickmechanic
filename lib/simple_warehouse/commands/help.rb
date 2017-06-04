require 'simple_warehouse/commands/base'

module SimpleWarehouse::Commands
  class Help < Base
    def initialize
      super("help", "Shows this help message.")
    end

    def action(context)
      fulls = []
      descs = []
      full_max_size = 0

      context.router.commands.each_value do |cmd|
        fulls << cmd.full_command
        descs << cmd.description
        full_max_size = [full_max_size, cmd.full_command.length].max
      end

      full_max_size += 2
      fulls = fulls.zip(descs).collect do |entry,desc| 
        entry + (' ' * (full_max_size - entry.length)) + desc
      end

      [:ok, fulls.join("\n")]
    end
  end
end
