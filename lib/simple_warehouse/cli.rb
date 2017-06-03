
module SimpleWarehouse
  class CLI
    def run
      puts 'Type `help` for instructions on usage'
      while true
        print '> '
        command = gets.chomp
        case command
          when 'help'
            show_help_message
          when 'exit'
            exit
            break
          else
            show_unrecognized_message
        end
      end
    end

    private

    def show_help_message
      puts 'help             Shows this help message
init W H         (Re)Initialises the application as a W x H warehouse, with all spaces empty.
store X Y W H P  Stores a crate of product number P and of size W x H at position X,Y.
locate P         Show a list of positions where product number can be found.
remove X Y       Remove the crate at positon X,Y.
view             Show a representation of the current state of the warehouse, marking each position as filled or empty.
exit             Exits the application.'
    end

    def show_unrecognized_message
      puts 'Command not found. Type `help` for instructions on usage'
    end

    def exit
      puts 'Thank you for using simple_warehouse!'
    end
    
  end

end
