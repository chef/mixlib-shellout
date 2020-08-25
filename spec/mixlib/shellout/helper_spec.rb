require "spec_helper"
require "mixlib/shellout/helper"
require "logger"

# to use this helper you need to either:
#  1. use mixlib-log which has a trace level
#  2. monkeypatch a trace level into ruby's logger like this
#  3. override the __io_for_live_stream method
#
class Logger
  module Severity; TRACE=-1;end
  def trace(progname = nil, &block);add(TRACE, nil, progname, &block);end
  def trace?; @level <= TRACE; end
end

describe Mixlib::ShellOut::Helper, ruby: ">= 2.3" do
  class TestClass
    include Mixlib::ShellOut::Helper

    # this is a hash-like object
    def __config
      {}
    end

    # this is a train transport connection or nil
    def __transport_connection
      nil
    end

    # this is a logger-like object
    def __log
      Logger.new(IO::NULL)
    end
  end

  let(:test_class) { TestClass.new }

  it "works to run a trivial ruby command" do
    expect(test_class.shell_out("ruby -e 'exit 0'")).to be_kind_of(Mixlib::ShellOut)
  end
end
