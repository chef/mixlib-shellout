require "spec_helper"

# FIXME: these are stubby enough unit tests that they almost run under unix, but the
# Mixlib::ShellOut object does not mixin the Windows behaviors when running on unix.
describe "Mixlib::ShellOut::Windows", :windows_only do

  describe "Utils" do
    describe ".should_run_under_cmd?" do
      subject { Mixlib::ShellOut.new.send(:should_run_under_cmd?, command) }

      def self.with_command(_command, &example)
        context "with command: #{_command}" do
          let(:command) { _command }
          it(&example)
        end
      end

      context "when unquoted" do
        with_command(%q{ruby -e 'prints "foobar"'}) { is_expected.not_to be_truthy }

        # https://github.com/chef/mixlib-shellout/pull/2#issuecomment-4825574
        with_command(%q{"C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\Bin\NETFX 4.0 Tools\gacutil.exe" /i "C:\Program Files (x86)\NUnit 2.6\bin\framework\nunit.framework.dll"}) { is_expected.not_to be_truthy }

        with_command(%q{ruby -e 'exit 1' | ruby -e 'exit 0'}) { is_expected.to be_truthy }
        with_command(%q{ruby -e 'exit 1' > out.txt}) { is_expected.to be_truthy }
        with_command(%q{ruby -e 'exit 1' > out.txt 2>&1}) { is_expected.to be_truthy }
        with_command(%q{ruby -e 'exit 1' < in.txt}) { is_expected.to be_truthy }
        with_command(%q{ruby -e 'exit 1' || ruby -e 'exit 0'}) { is_expected.to be_truthy }
        with_command(%q{ruby -e 'exit 1' && ruby -e 'exit 0'}) { is_expected.to be_truthy }
        with_command(%q{@echo TRUE}) { is_expected.to be_truthy }

        with_command(%q{echo %PATH%}) { is_expected.to be_truthy }
        with_command(%q{run.exe %A}) { is_expected.to be_falsey }
        with_command(%q{run.exe B%}) { is_expected.to be_falsey }
        with_command(%q{run.exe %A B%}) { is_expected.to be_falsey }
        with_command(%q{run.exe %A B% %PATH%}) { is_expected.to be_truthy }
        with_command(%q{run.exe %A B% %_PATH%}) { is_expected.to be_truthy }
        with_command(%q{run.exe %A B% %PATH_EXT%}) { is_expected.to be_truthy }
        with_command(%q{run.exe %A B% %1%}) { is_expected.to be_falsey }
        with_command(%q{run.exe %A B% %PATH1%}) { is_expected.to be_truthy }
        with_command(%q{run.exe %A B% %_PATH1%}) { is_expected.to be_truthy }

        context "when outside quotes" do
          with_command(%q{ruby -e "exit 1" | ruby -e "exit 0"}) { is_expected.to be_truthy }
          with_command(%q{ruby -e "exit 1" > out.txt}) { is_expected.to be_truthy }
          with_command(%q{ruby -e "exit 1" > out.txt 2>&1}) { is_expected.to be_truthy }
          with_command(%q{ruby -e "exit 1" < in.txt}) { is_expected.to be_truthy }
          with_command(%q{ruby -e "exit 1" || ruby -e "exit 0"}) { is_expected.to be_truthy }
          with_command(%q{ruby -e "exit 1" && ruby -e "exit 0"}) { is_expected.to be_truthy }
          with_command(%q{@echo "TRUE"}) { is_expected.to be_truthy }

          context "with unclosed quote" do
            with_command(%q{ruby -e "exit 1" | ruby -e "exit 0}) { is_expected.to be_truthy }
            with_command(%q{ruby -e "exit 1" > "out.txt}) { is_expected.to be_truthy }
            with_command(%q{ruby -e "exit 1" > "out.txt 2>&1}) { is_expected.to be_truthy }
            with_command(%q{ruby -e "exit 1" < "in.txt}) { is_expected.to be_truthy }
            with_command(%q{ruby -e "exit 1" || "ruby -e "exit 0"}) { is_expected.to be_truthy }
            with_command(%q{ruby -e "exit 1" && "ruby -e "exit 0"}) { is_expected.to be_truthy }
            with_command(%q{@echo "TRUE}) { is_expected.to be_truthy }

            with_command(%q{echo "%PATH%}) { is_expected.to be_truthy }
            with_command(%q{run.exe "%A}) { is_expected.to be_falsey }
            with_command(%q{run.exe "B%}) { is_expected.to be_falsey }
            with_command(%q{run.exe "%A B%}) { is_expected.to be_falsey }
            with_command(%q{run.exe "%A B% %PATH%}) { is_expected.to be_truthy }
            with_command(%q{run.exe "%A B% %_PATH%}) { is_expected.to be_truthy }
            with_command(%q{run.exe "%A B% %PATH_EXT%}) { is_expected.to be_truthy }
            with_command(%q{run.exe "%A B% %1%}) { is_expected.to be_falsey }
            with_command(%q{run.exe "%A B% %PATH1%}) { is_expected.to be_truthy }
            with_command(%q{run.exe "%A B% %_PATH1%}) { is_expected.to be_truthy }
          end
        end
      end

      context "when quoted" do
        with_command(%q{run.exe "ruby -e 'exit 1' || ruby -e 'exit 0'"}) { is_expected.to be_falsey }
        with_command(%q{run.exe "ruby -e 'exit 1' > out.txt"}) { is_expected.to be_falsey }
        with_command(%q{run.exe "ruby -e 'exit 1' > out.txt 2>&1"}) { is_expected.to be_falsey }
        with_command(%q{run.exe "ruby -e 'exit 1' < in.txt"}) { is_expected.to be_falsey }
        with_command(%q{run.exe "ruby -e 'exit 1' || ruby -e 'exit 0'"}) { is_expected.to be_falsey }
        with_command(%q{run.exe "ruby -e 'exit 1' && ruby -e 'exit 0'"}) { is_expected.to be_falsey }
        with_command(%q{run.exe "%PATH%"}) { is_expected.to be_truthy }
        with_command(%q{run.exe "%A"}) { is_expected.to be_falsey }
        with_command(%q{run.exe "B%"}) { is_expected.to be_falsey }
        with_command(%q{run.exe "%A B%"}) { is_expected.to be_falsey }
        with_command(%q{run.exe "%A B% %PATH%"}) { is_expected.to be_truthy }
        with_command(%q{run.exe "%A B% %_PATH%"}) { is_expected.to be_truthy }
        with_command(%q{run.exe "%A B% %PATH_EXT%"}) { is_expected.to be_truthy }
        with_command(%q{run.exe "%A B% %1%"}) { is_expected.to be_falsey }
        with_command(%q{run.exe "%A B% %PATH1%"}) { is_expected.to be_truthy }
        with_command(%q{run.exe "%A B% %_PATH1%"}) { is_expected.to be_truthy }

        context "with unclosed quote" do
          with_command(%q{run.exe "ruby -e 'exit 1' || ruby -e 'exit 0'}) { is_expected.to be_falsey }
          with_command(%q{run.exe "ruby -e 'exit 1' > out.txt}) { is_expected.to be_falsey }
          with_command(%q{run.exe "ruby -e 'exit 1' > out.txt 2>&1}) { is_expected.to be_falsey }
          with_command(%q{run.exe "ruby -e 'exit 1' < in.txt}) { is_expected.to be_falsey }
          with_command(%q{run.exe "ruby -e 'exit 1' || ruby -e 'exit 0'}) { is_expected.to be_falsey }
          with_command(%q{run.exe "ruby -e 'exit 1' && ruby -e 'exit 0'}) { is_expected.to be_falsey }
          with_command(%q{run.exe "%PATH%}) { is_expected.to be_truthy }
          with_command(%q{run.exe "%A}) { is_expected.to be_falsey }
          with_command(%q{run.exe "B%}) { is_expected.to be_falsey }
          with_command(%q{run.exe "%A B%}) { is_expected.to be_falsey }
          with_command(%q{run.exe "%A B% %PATH%}) { is_expected.to be_truthy }
          with_command(%q{run.exe "%A B% %_PATH%}) { is_expected.to be_truthy }
          with_command(%q{run.exe "%A B% %PATH_EXT%}) { is_expected.to be_truthy }
          with_command(%q{run.exe "%A B% %1%}) { is_expected.to be_falsey }
          with_command(%q{run.exe "%A B% %PATH1%}) { is_expected.to be_truthy }
          with_command(%q{run.exe "%A B% %_PATH1%}) { is_expected.to be_truthy }
        end
      end
    end

    describe ".kill_process_tree" do
      let(:shell_out) { Mixlib::ShellOut.new }
      let(:wmi) { Object.new }
      let(:wmi_ole_object) { Object.new }
      let(:wmi_process) { Object.new }
      let(:logger) { Object.new }

      before do
        allow(wmi).to receive(:query).and_return([wmi_process])
        allow(wmi_process).to receive(:wmi_ole_object).and_return(wmi_ole_object)
        allow(logger).to receive(:debug)
      end

      context "with a protected system process in the process tree" do
        before do
          allow(wmi_ole_object).to receive(:name).and_return("csrss.exe")
          allow(wmi_ole_object).to receive(:processid).and_return(100)
        end

        it "does not attempt to kill csrss.exe" do
          expect(shell_out).to_not receive(:kill_process)
          shell_out.send(:kill_process_tree, 200, wmi, logger)
        end
      end

      context "with a non-system-critical process in the process tree" do
        before do
          allow(wmi_ole_object).to receive(:name).and_return("blah.exe")
          allow(wmi_ole_object).to receive(:processid).and_return(300)
        end

        it "does attempt to kill blah.exe" do
          expect(shell_out).to receive(:kill_process).with(wmi_process, logger)
          expect(shell_out).to receive(:kill_process_tree).with(200, wmi, logger).and_call_original
          expect(shell_out).to receive(:kill_process_tree).with(300, wmi, logger)
          shell_out.send(:kill_process_tree, 200, wmi, logger)
        end
      end
    end
  end

  # Caveat: Private API methods are subject to change without notice.
  # Monkeypatch at your own risk.
  context "#command_to_run" do

    describe "#command_to_run" do
      subject { shell_out.send(:command_to_run, command) }

      # @param cmd [String] command string
      # @param filename [String] the pathname to the executable that will be found (nil to have no pathname match)
      # @param search [Boolean] false: will setup expectation not to search PATH, true: will setup expectations that it searches the PATH
      # @param directory [Boolean] true: will setup an expectation that the search strategy will find a directory
      def self.with_command(cmd, filename: nil, search: false, directory: false, &example)
        context "with #{cmd}" do
          let(:shell_out) { Mixlib::ShellOut.new }
          let(:comspec) { 'C:\Windows\system32\cmd.exe' }
          let(:command) { cmd }
          before do
            if search
              expect(ENV).to receive(:[]).with("PATH").and_return('C:\Windows\system32')
            else
              expect(ENV).not_to receive(:[]).with("PATH")
            end
            allow(ENV).to receive(:[]).with("PATHEXT").and_return(".COM;.EXE;.BAT;.CMD")
            allow(ENV).to receive(:[]).with("COMSPEC").and_return(comspec)
            allow(File).to receive(:executable?).and_return(false)
            if filename
              expect(File).to receive(:executable?).with(filename).and_return(true)
              expect(File).to receive(:directory?).with(filename).and_return(false)
            end
            if directory
              expect(File).to receive(:executable?).with(cmd).and_return(true)
              expect(File).to receive(:directory?).with(cmd).and_return(true)
            end
          end
          it(&example)
        end
      end

      # quoted and unqouted commands that have correct bat and cmd extensions
      with_command("autoexec.bat", filename: "autoexec.bat") do
        is_expected.to eql([ comspec, 'cmd /c "autoexec.bat"'])
      end
      with_command("autoexec.cmd", filename: "autoexec.cmd") do
        is_expected.to eql([ comspec, 'cmd /c "autoexec.cmd"'])
      end
      with_command('"C:\Program Files\autoexec.bat"', filename: 'C:\Program Files\autoexec.bat') do
        is_expected.to eql([ comspec, 'cmd /c ""C:\Program Files\autoexec.bat""'])
      end
      with_command('"C:\Program Files\autoexec.cmd"', filename: 'C:\Program Files\autoexec.cmd') do
        is_expected.to eql([ comspec, 'cmd /c ""C:\Program Files\autoexec.cmd""'])
      end

      # lookups via PATHEXT
      with_command("autoexec", filename: "autoexec.BAT") do
        is_expected.to eql([ comspec, 'cmd /c "autoexec"'])
      end
      with_command("autoexec", filename: "autoexec.CMD") do
        is_expected.to eql([ comspec, 'cmd /c "autoexec"'])
      end

      # unquoted commands that have "bat" or "cmd" in the wrong place
      with_command("autoexecbat", filename: "autoexecbat") do
        is_expected.to eql(%w{autoexecbat autoexecbat})
      end
      with_command("autoexeccmd", filename: "autoexeccmd") do
        is_expected.to eql(%w{autoexeccmd autoexeccmd})
      end
      with_command("abattoir.exe", filename: "abattoir.exe") do
        is_expected.to eql([ "abattoir.exe", "abattoir.exe" ])
      end
      with_command("parse_cmd.exe", filename: "parse_cmd.exe") do
        is_expected.to eql([ "parse_cmd.exe", "parse_cmd.exe" ])
      end

      # quoted commands that have "bat" or "cmd" in the wrong place
      with_command('"C:\Program Files\autoexecbat"', filename: 'C:\Program Files\autoexecbat') do
        is_expected.to eql([ 'C:\Program Files\autoexecbat', '"C:\Program Files\autoexecbat"' ])
      end
      with_command('"C:\Program Files\autoexeccmd"', filename: 'C:\Program Files\autoexeccmd') do
        is_expected.to eql([ 'C:\Program Files\autoexeccmd', '"C:\Program Files\autoexeccmd"'])
      end
      with_command('"C:\Program Files\abattoir.exe"', filename: 'C:\Program Files\abattoir.exe') do
        is_expected.to eql([ 'C:\Program Files\abattoir.exe', '"C:\Program Files\abattoir.exe"' ])
      end
      with_command('"C:\Program Files\parse_cmd.exe"', filename: 'C:\Program Files\parse_cmd.exe') do
        is_expected.to eql([ 'C:\Program Files\parse_cmd.exe', '"C:\Program Files\parse_cmd.exe"' ])
      end

      # empty command
      with_command(" ") do
        expect { subject }.to raise_error(Mixlib::ShellOut::EmptyWindowsCommand)
      end

      # extensionless executable
      with_command("ping", filename: 'C:\Windows\system32/ping.EXE', search: true) do
        is_expected.to eql([ 'C:\Windows\system32/ping.EXE', "ping" ])
      end

      # it ignores directories
      with_command("ping", filename: 'C:\Windows\system32/ping.EXE', directory: true, search: true) do
        is_expected.to eql([ 'C:\Windows\system32/ping.EXE', "ping" ])
      end

      # https://github.com/chef/mixlib-shellout/pull/2 with bat file
      with_command('"C:\Program Files\Application\Start.bat"', filename: 'C:\Program Files\Application\Start.bat') do
        is_expected.to eql([ comspec, 'cmd /c ""C:\Program Files\Application\Start.bat""' ])
      end
      with_command('"C:\Program Files\Application\Start.bat" arguments', filename: 'C:\Program Files\Application\Start.bat') do
        is_expected.to eql([ comspec, 'cmd /c ""C:\Program Files\Application\Start.bat" arguments"' ])
      end
      with_command('"C:\Program Files\Application\Start.bat" /i "C:\Program Files (x86)\NUnit 2.6\bin\framework\nunit.framework.dll"', filename: 'C:\Program Files\Application\Start.bat') do
        is_expected.to eql([ comspec, 'cmd /c ""C:\Program Files\Application\Start.bat" /i "C:\Program Files (x86)\NUnit 2.6\bin\framework\nunit.framework.dll""' ])
      end

      # https://github.com/chef/mixlib-shellout/pull/2 with cmd file
      with_command('"C:\Program Files\Application\Start.cmd"', filename: 'C:\Program Files\Application\Start.cmd') do
        is_expected.to eql([ comspec, 'cmd /c ""C:\Program Files\Application\Start.cmd""' ])
      end
      with_command('"C:\Program Files\Application\Start.cmd" arguments', filename: 'C:\Program Files\Application\Start.cmd') do
        is_expected.to eql([ comspec, 'cmd /c ""C:\Program Files\Application\Start.cmd" arguments"' ])
      end
      with_command('"C:\Program Files\Application\Start.cmd" /i "C:\Program Files (x86)\NUnit 2.6\bin\framework\nunit.framework.dll"', filename: 'C:\Program Files\Application\Start.cmd') do
        is_expected.to eql([ comspec, 'cmd /c ""C:\Program Files\Application\Start.cmd" /i "C:\Program Files (x86)\NUnit 2.6\bin\framework\nunit.framework.dll""' ])
      end

      # https://github.com/chef/mixlib-shellout/pull/2 with unquoted exe file
      with_command('C:\RUBY192\bin\ruby.exe', filename: 'C:\RUBY192\bin\ruby.exe') do
        is_expected.to eql([ 'C:\RUBY192\bin\ruby.exe', 'C:\RUBY192\bin\ruby.exe' ])
      end
      with_command('C:\RUBY192\bin\ruby.exe arguments', filename: 'C:\RUBY192\bin\ruby.exe') do
        is_expected.to eql([ 'C:\RUBY192\bin\ruby.exe', 'C:\RUBY192\bin\ruby.exe arguments' ])
      end
      with_command('C:\RUBY192\bin\ruby.exe -e "print \'fee fie foe fum\'"', filename: 'C:\RUBY192\bin\ruby.exe') do
        is_expected.to eql([ 'C:\RUBY192\bin\ruby.exe', 'C:\RUBY192\bin\ruby.exe -e "print \'fee fie foe fum\'"' ])
      end

      # https://github.com/chef/mixlib-shellout/pull/2 with quoted exe file
      exe_with_spaces = 'C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\Bin\NETFX 4.0 Tools\gacutil.exe'
      with_command("\"#{exe_with_spaces}\"", filename: exe_with_spaces) do
        is_expected.to eql([ exe_with_spaces, "\"#{exe_with_spaces}\"" ])
      end
      with_command("\"#{exe_with_spaces}\" arguments", filename: exe_with_spaces) do
        is_expected.to eql([ exe_with_spaces, "\"#{exe_with_spaces}\" arguments" ])
      end
      long_options = "/i \"C:\Program Files (x86)\NUnit 2.6\bin\framework\nunit.framework.dll\""
      with_command("\"#{exe_with_spaces}\" #{long_options}", filename: exe_with_spaces) do
        is_expected.to eql([ exe_with_spaces, "\"#{exe_with_spaces}\" #{long_options}" ])
      end

      # shell built in
      with_command("copy thing1.txt thing2.txt", search: true) do
        is_expected.to eql([ comspec, 'cmd /c "copy thing1.txt thing2.txt"' ])
      end
    end
  end
end
