require "spec_helper"
require "mixlib/shellout/helper"

RSpec.describe Mixlib::ShellOut::Helper do
  # The helper expects the including class to supply __config, __log and
  # __transport_connection. This mirrors how chef and ohai wire it up.
  let(:helper_class) do
    Class.new do
      include Mixlib::ShellOut::Helper

      attr_accessor :__transport_connection, :__log

      def __config
        { internal_locale: "C.UTF-8" }
      end
    end
  end

  let(:log) { double("log", trace?: false) }
  let(:helper) { helper_class.new.tap { |h| h.__log = log } }
  let(:ruby) { RbConfig.ruby }

  describe "#shell_out" do
    it "returns a Mixlib::ShellOut that has been run" do
      cmd = helper.shell_out(ruby, "-e", "print :hi")
      expect(cmd).to be_a(Mixlib::ShellOut)
      expect(cmd.stdout).to eq("hi")
      expect(cmd.exitstatus).to eq(0)
    end

    it "does not raise on a non-zero exit" do
      cmd = helper.shell_out(ruby, "-e", "exit 3")
      expect(cmd.exitstatus).to eq(3)
      expect(cmd.error?).to be(true)
    end

    # chef's own specs stub shell_out_compacted, so this calling contract is public in practice
    it "flattens, compacts and stringifies arguments before calling shell_out_compacted" do
      expect(helper).to receive(:shell_out_compacted).with("foo", "bar", "baz", "1")
      helper.shell_out("foo", ["bar", nil, :baz], nil, 1)
    end

    it "passes options through to shell_out_compacted" do
      expect(helper).to receive(:shell_out_compacted).with("foo", timeout: 5, cwd: "/")
      helper.shell_out("foo", timeout: 5, cwd: "/")
    end

    it "does not mutate the caller's options hash" do
      options = { timeout: 5, default_env: false }
      helper.shell_out(ruby, "-e", "exit 0", **options)
      expect(options).to eq(timeout: 5, default_env: false)
    end
  end

  describe "#shell_out!" do
    it "flattens, compacts and stringifies arguments before calling shell_out_compacted!" do
      expect(helper).to receive(:shell_out_compacted!).with("foo", "bar")
      helper.shell_out!(["foo", nil], "bar")
    end

    it "returns the command on success" do
      expect(helper.shell_out!(ruby, "-e", "print :ok").stdout).to eq("ok")
    end

    it "raises ShellCommandFailed on a non-zero exit" do
      expect { helper.shell_out!(ruby, "-e", "exit 3") }
        .to raise_error(Mixlib::ShellOut::ShellCommandFailed, /received '3'/)
    end

    it "honors the returns option" do
      expect { helper.shell_out!(ruby, "-e", "exit 3", returns: [0, 3]) }.not_to raise_error
    end
  end

  describe "default environment" do
    def env_passed_to_shellout(**options)
      captured = nil
      allow(Mixlib::ShellOut).to receive(:new).and_wrap_original do |original, *args, **opts|
        captured = opts
        original.call(*args, **opts)
      end
      helper.shell_out(ruby, "-e", "exit 0", **options)
      captured
    end

    let(:path_key) { windows? ? "Path" : "PATH" }

    it "sets the locale and PATH by default" do
      opts = env_passed_to_shellout
      expect(opts[:environment]).to include(
        "LC_ALL" => "C.UTF-8",
        "LANG" => "C.UTF-8",
        "LANGUAGE" => "C.UTF-8",
        path_key => helper.default_paths
      )
    end

    it "lets caller-supplied variables override the defaults" do
      opts = env_passed_to_shellout(environment: { "LC_ALL" => "fr_FR.UTF-8", "FOO" => "bar" })
      expect(opts[:environment]).to include("LC_ALL" => "fr_FR.UTF-8", "LANG" => "C.UTF-8", "FOO" => "bar")
    end

    it "keeps the :env key when the caller used :env rather than :environment" do
      opts = env_passed_to_shellout(env: { "FOO" => "bar" })
      expect(opts).not_to have_key(:environment)
      expect(opts[:env]).to include("FOO" => "bar", "LC_ALL" => "C.UTF-8")
    end

    it "does not inject anything when default_env is false" do
      opts = env_passed_to_shellout(default_env: false)
      expect(opts).to eq({})
    end

    it "actually exports the default locale to the child process" do
      cmd = helper.shell_out(ruby, "-e", "print ENV['LC_ALL']")
      expect(cmd.stdout).to eq("C.UTF-8")
    end
  end

  describe "timeouts for chef providers" do
    # The helper sniffs ancestors by name so it never has to load chef itself.
    let(:helper_class) do
      provider = Class.new { def self.name = "Chef::Provider" }
      Class.new(provider) do
        include Mixlib::ShellOut::Helper

        attr_accessor :new_resource, :__log

        def __config = {}
        def __transport_connection = nil
      end
    end

    before { helper.new_resource = resource }

    context "when the resource has a timeout" do
      let(:resource) { double("resource", timeout: 42) }

      it "passes the resource timeout as a float" do
        expect(helper).to receive(:shell_out_compacted).with("foo", timeout: 42.0)
        helper.shell_out("foo")
      end

      it "prefers an explicit timeout option" do
        expect(helper).to receive(:shell_out_compacted).with("foo", timeout: 7)
        helper.shell_out("foo", timeout: 7)
      end
    end

    context "when the resource timeout is nil" do
      let(:resource) { double("resource", timeout: nil) }

      it "falls back to 900 seconds" do
        expect(helper).to receive(:shell_out_compacted).with("foo", timeout: 900)
        helper.shell_out("foo")
      end
    end
  end

  it "does not inject a timeout for classes that are not chef providers" do
    expect(helper).to receive(:shell_out_compacted).with("foo")
    helper.shell_out("foo")
  end

  describe "live streaming" do
    it "streams to STDOUT when the logger is at trace level" do
      allow(log).to receive(:trace?).and_return(true)
      expect(helper.send(:__io_for_live_stream)).to be(STDOUT)
    end

    it "does not stream otherwise" do
      expect(helper.send(:__io_for_live_stream)).to be_nil
    end
  end

  # Used by chef target mode, where commands run over a train connection
  # instead of locally.
  context "with a transport connection" do
    let(:result) { Struct.new(:stdout, :stderr, :exit_status).new("out", "err", exit_status) }
    let(:exit_status) { 0 }
    let(:connection) { double("train connection") }

    before do
      helper.__transport_connection = connection
      allow(ChefUtils).to receive(:windows?).and_return(false)
      # default_paths probes the remote PATH over the connection; keep that out of the way
      allow(helper).to receive(:default_paths).and_return("/usr/bin:/bin")
    end

    def expect_remote_command(command)
      expect(connection).to receive(:run_command).with(command, anything).and_return(result)
    end

    it "does not run anything locally" do
      allow(connection).to receive(:run_command).and_return(result)
      expect(Mixlib::ShellOut).not_to receive(:new)
      helper.shell_out("echo", "hi")
    end

    it "joins arguments into a single command, quoting any that contain spaces" do
      expect_remote_command('echo "hello world"')
      helper.shell_out("echo", "hello world")
    end

    it "wraps the command in a subshell to honor cwd" do
      expect_remote_command("sh -c 'cd /tmp; ls'")
      helper.shell_out("ls", cwd: "/tmp")
    end

    it "feeds input to the command with a heredoc" do
      expect_remote_command("cat<<'COMMANDINPUT'\nsome input\nCOMMANDINPUT\n")
      helper.shell_out("cat", input: "some input")
    end

    it "returns a ShellOut-like result" do
      allow(connection).to receive(:run_command).and_return(result)
      cmd = helper.shell_out("true")
      expect(cmd).to have_attributes(stdout: "out", stderr: "err", exitstatus: 0)
      expect(cmd.status.success?).to be(true)
      expect(cmd.error?).to be(false)
    end

    context "when the remote command fails" do
      let(:exit_status) { 2 }

      before { allow(connection).to receive(:run_command).and_return(result) }

      it "reports failure without raising from shell_out" do
        cmd = helper.shell_out("false")
        expect(cmd.status.success?).to be(false)
        expect(cmd.error?).to be(true)
      end

      it "raises ShellCommandFailed from shell_out!" do
        expect { helper.shell_out!("false") }
          .to raise_error(Mixlib::ShellOut::ShellCommandFailed, /Unexpected exit status of 2.*err/)
      end

      it "honors the returns option" do
        expect { helper.shell_out!("false", returns: [0, 2]) }.not_to raise_error
      end
    end
  end
end
