require 'simple_warehouse/command_router'
require 'minitest/spec'

include SimpleWarehouse

describe CommandRouter do
  let(:router) { CommandRouter.new }
  let(:cmd) { DummyCmd.new }

  class DummyCmd
    def command
      "potato"
    end
    def action(context, one, two)
      @context = context
      @arguments = [one, two]
      [:ok, "cool"]
    end

    def status
      [@context, @arguments]
    end

    def match(arguments)
      /^[^\s]+\s+[^\s]+$/ =~ arguments
    end

    def full_command
      "full command"
    end
  end

  before do
    router.add cmd
  end

  describe "route doesn't match parameters" do
    before do
      @status, @output = router.route "context", "potato for you all"
    end

    it "returns :wrong_arguments" do
      @status.must_equal :wrong_arguments
    end

    it "returns full_command" do
      @output.must_equal "full command"
    end
  end

  it "route executes command" do
    router.route "context", "potato for me"
    cmd.status.must_equal ["context", ["for", "me"]]
  end

  it "route returns result" do
    status, output = router.route "context", "potato for me"
    status.must_equal :ok
    output.must_equal "cool"
  end

  it "route returns :not_found when no command do" do
    status, output = router.route "context", "hey jude"
    status.must_equal :not_found
  end
end
