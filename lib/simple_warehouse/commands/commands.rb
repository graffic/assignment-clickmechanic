module SimpleWarehouse::Commands
  class Base
    attr_accessor :full_command, :command, :description

    def initialize(full_command, description="", match=/^$/)
      @full_command = full_command
      @description = description
      @command = full_command.split(' ', 2)[0]
      @match = match
    end

    def match(arguments)
      @match =~ arguments
    end

    def action(context)
      [:ok, "did nothing"]
    end
    
  end

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

  class Init < Base
    def initialize
      super("init", /^[1-9][0-9]*\s[1-9][0-9]*$/)
    end
  end

  class Store < Base
    def initialize
      super("store")
    end
  end

  class Locate < Base
    def initialize
      super("locate")
    end
  end

  class Remove < Base
  end

  class View < Base
  end

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
