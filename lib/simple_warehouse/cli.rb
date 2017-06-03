require 'simple_warehouse/command_router'
require 'simple_warehouse/commands'

module SimpleWarehouse
  Context = Struct.new("Context", :router, :warehouse)

  class CLI
    def initialize
      @router = CommandRouter.new
      @router.add SimpleWarehouse::Commands::Help.new
      @router.add SimpleWarehouse::Commands::Exit.new
      @context = Context.new @router, nil
    end

    def run
      puts 'Type `help` for instructions on usage'
      while true
        print '> '
        entry = gets
        if entry.nil?
          break
        end
        command = entry.chomp
        status, msg = @router.route @context, command
        if msg
          puts msg
        end

        if status == :exit
          break
        end
      end
    end
  end
end
