module SimpleWarehouse
  class CommandRouter
    attr_accessor :commands

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

      parameters = command.extract arguments.join(' ')

      if parameters == :no_match
        return :wrong_arguments, command.full_command
      end

      command.action(context, *arguments)
    end
  end
end
