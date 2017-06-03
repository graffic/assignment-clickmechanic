module SimpleWarehouse
  class CommandRouter
    def initialize
      @commands = {}
    end

    def add(cmd)
      @commands[cmd.command] = cmd
    end

    ##
    # routes a line entry to the right command
    def route(context, entry)
      command_name, *arguments = entry.split
      command = @commands[command_name]
      if command == nil
        return :not_found, nil
      end

      if not command.match arguments.join(' ')
        return :wrong_arguments, nil
      end

      output = command.action(context, *arguments)
      return :ok, output
    end
  end
end
