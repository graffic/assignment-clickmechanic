require 'test_helper'
require 'simple_warehouse/cli'

include SimpleWarehouse

describe CLI do
  describe "run" do
    it "Nil in gets exits" do
      cli = CLI.new
      def cli.puts(x); end
      def cli.print(x); end

      cli.stub :gets, nil do
        cli.run
      end
    end
  end
end
