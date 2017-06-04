module SimpleWarehouse::Commands
  class Base
    attr_accessor :full_command, :command, :description

    def initialize(full_command, description="", match=/^$/)
      @full_command = full_command
      @description = description
      @command = full_command.split(' ', 2)[0]
      @match = match
    end

    def extract(arguments)
      matches = @match.match(arguments)
      if matches.nil?
        return :no_match
      end
      matches.captures
    end

    def action(context)
      [:ok, "did nothing"]
    end
  end
end
