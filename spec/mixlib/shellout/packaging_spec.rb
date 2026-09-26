require "spec_helper"
require "rbconfig"

RSpec.describe "mixlib-shellout packaging" do
  let(:root) { File.expand_path("../../..", __dir__) }

  def load_gemspec(name)
    Dir.chdir(root) { Gem::Specification.load(name) }
  end

  describe "version" do
    # Expeditor bumps VERSION and then rewrites version.rb with a sed regex
    # (.expeditor/update_version.sh). Catch the two drifting apart.
    it "matches the VERSION file" do
      expect(Mixlib::ShellOut::VERSION).to eq(File.read(File.join(root, "VERSION")).strip)
    end

    it "is a valid gem version" do
      expect(Gem::Version.correct?(Mixlib::ShellOut::VERSION)).to be(true)
    end
  end

  describe "mixlib-shellout.gemspec" do
    subject(:spec) { load_gemspec("mixlib-shellout.gemspec") }

    it "is valid" do
      expect { spec.validate(false) }.not_to raise_error
    end

    it "is a pure ruby gem" do
      expect(spec.platform).to eq(Gem::Platform::RUBY)
    end

    it "ships every library file and the license" do
      lib_files = Dir.chdir(root) { Dir.glob("lib/**/*.rb") }
      expect(spec.files).to include("LICENSE", *lib_files)
    end

    it "does not ship specs or repo tooling" do
      expect(spec.files).to all(start_with("lib/").or(eq("LICENSE")))
    end

    it "does not depend on the windows-only gems" do
      expect(spec.runtime_dependencies.map(&:name)).to contain_exactly("chef-utils")
    end
  end

  describe "mixlib-shellout-universal-mingw-ucrt.gemspec" do
    subject(:spec) { load_gemspec("mixlib-shellout-universal-mingw-ucrt.gemspec") }

    it "is valid" do
      expect { spec.validate(false) }.not_to raise_error
    end

    it "targets the ucrt windows platform" do
      expect(spec.platform.to_s).to eq("x64-mingw-ucrt")
    end

    it "adds the win32 dependencies used by lib/mixlib/shellout/windows.rb" do
      expect(spec.runtime_dependencies.map(&:name))
        .to contain_exactly("chef-utils", "win32-process", "wmi-lite", "win32ole", "ffi-win32-extensions")
    end

    it "ships the same files as the ruby platform gem" do
      expect(spec.files).to match_array(load_gemspec("mixlib-shellout.gemspec").files)
    end
  end

  # These run in a fresh interpreter: this process has already loaded plenty
  # of stdlib, so checking $LOADED_FEATURES here would prove nothing.
  describe "requiring the library" do
    def ruby_in_clean_process(*flags, code)
      cmd = Mixlib::ShellOut.new(RbConfig.ruby, *flags, "-I", File.join(root, "lib"), "-e", code)
      cmd.run_command
      expect(cmd.stderr).to eq("")
      cmd.error!
      cmd.stdout
    end

    # Regression guard for https://github.com/chef/mixlib-shellout/pull/282:
    # every chef/ohai/inspec process pays for whatever this gem loads.
    it "does not load tmpdir or fileutils", :unix_only do
      # Diff against a baseline: under `bundle exec` bundler has already loaded its own vendored fileutils.
      out = ruby_in_clean_process(<<~RUBY)
        before = $LOADED_FEATURES.dup
        require "mixlib/shellout"
        Mixlib::ShellOut.new("true").run_command.error!
        print ($LOADED_FEATURES - before).grep(%r{/(tmpdir|fileutils)\\.rb$}).join(",")
      RUBY
      expect(out).to eq("")
    end

    it "loads and runs a command with frozen string literals and warnings enabled" do
      # windows/core_ext.rb deliberately redefines win32-process's Process.create,
      # which -w reports, so only check frozen string literals there.
      flags = windows? ? [] : ["-W:deprecated", "-w"]
      out = ruby_in_clean_process(*flags, "--enable-frozen-string-literal", <<~RUBY)
        require "mixlib/shellout"
        require "mixlib/shellout/helper"
        cmd = Mixlib::ShellOut.new(#{RbConfig.ruby.dump}, "-e", "print :ok")
        cmd.live_stream = String.new
        print cmd.run_command.stdout
      RUBY
      expect(out).to eq("ok")
    end
  end
end
