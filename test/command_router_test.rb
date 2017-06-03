require 'simple_warehouse/command_router'
require 'minitest/spec'

include SimpleWarehouse

describe CommandRouter do
  let(:router) { CommandRouter.new }

    class DummyCmd
      def command
        "potato"
      end
      def action(context, one, two)
        @context = context
        @arguments = [one, two]
        "cool"
      end

      def status
        [@context, @arguments]
      end

      def match(arguments)
        /^[^\s]+\s+[^\s]+$/ =~ arguments
      end
    end

  it "route doesn't match parameters" do
    cmd = DummyCmd.new
    router.add cmd
    status, output = router.route "context", "potato for you all"
    status.must_equal :wrong_arguments
  end

  it "route executes command" do
    cmd = DummyCmd.new
    router.add cmd
    router.route "context", "potato for me"
    cmd.status.must_equal ["context", ["for", "me"]]
  end

  it "route returns result" do
    cmd = DummyCmd.new
    router.add cmd
    status, output = router.route "context", "potato for me"
    status.must_equal :ok
    output.must_equal "cool"
  end

  it "route returns :not_found when no command do" do
    cmd = DummyCmd.new
    router.add cmd
    status, output = router.route "context", "hey jude"
    status.must_equal :not_found
  end
end
