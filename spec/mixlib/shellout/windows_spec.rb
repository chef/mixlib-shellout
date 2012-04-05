require 'spec_helper'

describe 'Mixlib::ShellOut::Windows', :windows_only do

  describe 'Utils' do
    describe '.should_run_under_cmd?' do
      subject { Mixlib::ShellOut::Windows::Utils.should_run_under_cmd?(command) }

      def self.with_command(_command, &example)
        context "with command: #{_command}" do
          let(:command) { _command }
          it(&example)
        end
      end

      context 'when unquoted' do
        with_command(%q{ruby -e 'prints "foobar"'}) { should_not be_true }

        # https://github.com/opscode/mixlib-shellout/pull/2#issuecomment-4825574
        with_command(%q{"C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\Bin\NETFX 4.0 Tools\gacutil.exe" /i "C:\Program Files (x86)\NUnit 2.6\bin\framework\nunit.framework.dll"}) { should_not be_true }

        with_command(%q{ruby -e 'exit 1' | ruby -e 'exit 0'}) { should be_true }
        with_command(%q{ruby -e 'exit 1' > out.txt}) { should be_true }
        with_command(%q{ruby -e 'exit 1' > out.txt 2>&1}) { should be_true }
        with_command(%q{ruby -e 'exit 1' < in.txt}) { should be_true }
        with_command(%q{ruby -e 'exit 1' || ruby -e 'exit 0'}) { should be_true }
        with_command(%q{ruby -e 'exit 1' && ruby -e 'exit 0'}) { should be_true }
        with_command(%q{@echo TRUE}) { should be_true }

        with_command(%q{echo %PATH%}) { should be_true }
        with_command(%q{run.exe %A}) { should be_false }
        with_command(%q{run.exe B%}) { should be_false }
        with_command(%q{run.exe %A B%}) { should be_false }
        with_command(%q{run.exe %A B% %PATH%}) { should be_true }
        with_command(%q{run.exe %A B% %_PATH%}) { should be_true }
        with_command(%q{run.exe %A B% %PATH_EXT%}) { should be_true }
        with_command(%q{run.exe %A B% %1%}) { should be_false }
        with_command(%q{run.exe %A B% %PATH1%}) { should be_true }
        with_command(%q{run.exe %A B% %_PATH1%}) { should be_true }

        context 'when outside quotes' do
          with_command(%q{ruby -e "exit 1" | ruby -e "exit 0"}) { should be_true }
          with_command(%q{ruby -e "exit 1" > out.txt}) { should be_true }
          with_command(%q{ruby -e "exit 1" > out.txt 2>&1}) { should be_true }
          with_command(%q{ruby -e "exit 1" < in.txt}) { should be_true }
          with_command(%q{ruby -e "exit 1" || ruby -e "exit 0"}) { should be_true }
          with_command(%q{ruby -e "exit 1" && ruby -e "exit 0"}) { should be_true }
          with_command(%q{@echo "TRUE"}) { should be_true }

          context 'with unclosed quote' do
            with_command(%q{ruby -e "exit 1" | ruby -e "exit 0}) { should be_true }
            with_command(%q{ruby -e "exit 1" > "out.txt}) { should be_true }
            with_command(%q{ruby -e "exit 1" > "out.txt 2>&1}) { should be_true }
            with_command(%q{ruby -e "exit 1" < "in.txt}) { should be_true }
            with_command(%q{ruby -e "exit 1" || "ruby -e "exit 0"}) { should be_true }
            with_command(%q{ruby -e "exit 1" && "ruby -e "exit 0"}) { should be_true }
            with_command(%q{@echo "TRUE}) { should be_true }

            with_command(%q{echo "%PATH%}) { should be_true }
            with_command(%q{run.exe "%A}) { should be_false }
            with_command(%q{run.exe "B%}) { should be_false }
            with_command(%q{run.exe "%A B%}) { should be_false }
            with_command(%q{run.exe "%A B% %PATH%}) { should be_true }
            with_command(%q{run.exe "%A B% %_PATH%}) { should be_true }
            with_command(%q{run.exe "%A B% %PATH_EXT%}) { should be_true }
            with_command(%q{run.exe "%A B% %1%}) { should be_false }
            with_command(%q{run.exe "%A B% %PATH1%}) { should be_true }
            with_command(%q{run.exe "%A B% %_PATH1%}) { should be_true }
          end
        end
      end

      context 'when quoted' do
        with_command(%q{run.exe "ruby -e 'exit 1' || ruby -e 'exit 0'"}) { should be_false }
        with_command(%q{run.exe "ruby -e 'exit 1' > out.txt"}) { should be_false }
        with_command(%q{run.exe "ruby -e 'exit 1' > out.txt 2>&1"}) { should be_false }
        with_command(%q{run.exe "ruby -e 'exit 1' < in.txt"}) { should be_false }
        with_command(%q{run.exe "ruby -e 'exit 1' || ruby -e 'exit 0'"}) { should be_false }
        with_command(%q{run.exe "ruby -e 'exit 1' && ruby -e 'exit 0'"}) { should be_false }
        with_command(%q{run.exe "%PATH%"}) { should be_true }
        with_command(%q{run.exe "%A"}) { should be_false }
        with_command(%q{run.exe "B%"}) { should be_false }
        with_command(%q{run.exe "%A B%"}) { should be_false }
        with_command(%q{run.exe "%A B% %PATH%"}) { should be_true }
        with_command(%q{run.exe "%A B% %_PATH%"}) { should be_true }
        with_command(%q{run.exe "%A B% %PATH_EXT%"}) { should be_true }
        with_command(%q{run.exe "%A B% %1%"}) { should be_false }
        with_command(%q{run.exe "%A B% %PATH1%"}) { should be_true }
        with_command(%q{run.exe "%A B% %_PATH1%"}) { should be_true }

        context 'with unclosed quote' do
          with_command(%q{run.exe "ruby -e 'exit 1' || ruby -e 'exit 0'}) { should be_false }
          with_command(%q{run.exe "ruby -e 'exit 1' > out.txt}) { should be_false }
          with_command(%q{run.exe "ruby -e 'exit 1' > out.txt 2>&1}) { should be_false }
          with_command(%q{run.exe "ruby -e 'exit 1' < in.txt}) { should be_false }
          with_command(%q{run.exe "ruby -e 'exit 1' || ruby -e 'exit 0'}) { should be_false }
          with_command(%q{run.exe "ruby -e 'exit 1' && ruby -e 'exit 0'}) { should be_false }
          with_command(%q{run.exe "%PATH%}) { should be_true }
          with_command(%q{run.exe "%A}) { should be_false }
          with_command(%q{run.exe "B%}) { should be_false }
          with_command(%q{run.exe "%A B%}) { should be_false }
          with_command(%q{run.exe "%A B% %PATH%}) { should be_true }
          with_command(%q{run.exe "%A B% %_PATH%}) { should be_true }
          with_command(%q{run.exe "%A B% %PATH_EXT%}) { should be_true }
          with_command(%q{run.exe "%A B% %1%}) { should be_false }
          with_command(%q{run.exe "%A B% %PATH1%}) { should be_true }
          with_command(%q{run.exe "%A B% %_PATH1%}) { should be_true }
        end
      end
    end
  end

  # Caveat: Private API methods are subject to change without notice.
  # Monkeypatch at your own risk.
  context 'for private API methods' do

    describe '::IS_BATCH_FILE' do
      subject { candidate =~ Mixlib::ShellOut::Windows::IS_BATCH_FILE }

      def self.with_candidate(_context, _options = {}, &example)
        context "with #{_context}" do
          let(:candidate) { _options[:candidate] }
          it(&example)
        end
      end

      with_candidate('valid .bat file', :candidate => 'autoexec.bat') { should be_true }
      with_candidate('valid .cmd file', :candidate => 'autoexec.cmd') { should be_true }
      with_candidate('valid quoted .bat file', :candidate => '"C:\Program Files\autoexec.bat"') { should be_true }
      with_candidate('valid quoted .cmd file', :candidate => '"C:\Program Files\autoexec.cmd"') { should be_true }

      with_candidate('invalid .bat file', :candidate => 'autoexecbat') { should_not be_true }
      with_candidate('invalid .cmd file', :candidate => 'autoexeccmd') { should_not be_true }
      with_candidate('bat in filename', :candidate => 'abattoir.exe') { should_not be_true }
      with_candidate('cmd in filename', :candidate => 'parse_cmd.exe') { should_not be_true }

      with_candidate('invalid quoted .bat file', :candidate => '"C:\Program Files\autoexecbat"') { should_not be_true }
      with_candidate('invalid quoted .cmd file', :candidate => '"C:\Program Files\autoexeccmd"') { should_not be_true }
      with_candidate('quoted bat in filename', :candidate => '"C:\Program Files\abattoir.exe"') { should_not be_true }
      with_candidate('quoted cmd in filename', :candidate => '"C:\Program Files\parse_cmd.exe"') { should_not be_true }
    end

    describe '#command_to_run' do
      subject { stubbed_shell_out.send(:command_to_run, cmd) }

      let(:stubbed_shell_out) { fail NotImplemented, 'Must declare let(:stubbed_shell_out)' }
      let(:shell_out) { Mixlib::ShellOut.new(cmd) }

      let(:utils) { Mixlib::ShellOut::Windows::Utils }
      let(:with_valid_exe_at_location) { lambda { |s| utils.stub!(:find_executable).and_return(executable_path) } }
      let(:with_invalid_exe_at_location) { lambda { |s| utils.stub!(:find_executable).and_return(nil) } }

      context 'with empty command' do
        let(:stubbed_shell_out) { shell_out }
        let(:cmd) { ' ' }

        it 'should return with a nil executable' do
          should eql([nil, cmd])
        end
      end

      context 'with batch files' do
        let(:stubbed_shell_out) { shell_out.tap(&with_valid_exe_at_location) }
        let(:cmd_invocation) { "cmd /c \"#{cmd}\"" }
        let(:cmd_exe) { "C:\\Windows\\system32\\cmd.exe" }
        let(:cmd) { "#{executable_path}" }

        context 'with .bat file' do
          let(:executable_path) { '"C:\Program Files\Application\Start.bat"' }

          # Examples taken from: https://github.com/opscode/mixlib-shellout/pull/2#issuecomment-4825574
          context 'with executable path enclosed in double quotes' do

            it 'should use specified batch file' do
              should eql([cmd_exe, cmd_invocation])
            end

            context 'with arguments' do
              let(:cmd) { "#{executable_path} arguments" }

              it 'should use specified executable' do
                should eql([cmd_exe, cmd_invocation])
              end
            end

            context 'with quoted arguments' do
              let(:cmd) { "#{executable_path} /i \"C:\Program Files (x86)\NUnit 2.6\bin\framework\nunit.framework.dll\"" }

              it 'should use specified executable' do
                should eql([cmd_exe, cmd_invocation])
              end
            end
          end
        end

        context 'with .cmd file' do
          let(:executable_path) { '"C:\Program Files\Application\Start.cmd"' }

          # Examples taken from: https://github.com/opscode/mixlib-shellout/pull/2#issuecomment-4825574
          context 'with executable path enclosed in double quotes' do

            it 'should use specified batch file' do
              should eql([cmd_exe, cmd_invocation])
            end

            context 'with arguments' do
              let(:cmd) { "#{executable_path} arguments" }

              it 'should use specified executable' do
                should eql([cmd_exe, cmd_invocation])
              end
            end

            context 'with quoted arguments' do
              let(:cmd) { "#{executable_path} /i \"C:\Program Files (x86)\NUnit 2.6\bin\framework\nunit.framework.dll\"" }

              it 'should use specified executable' do
                should eql([cmd_exe, cmd_invocation])
              end
            end
          end

        end
      end

      context 'with valid executable at location' do
        let(:stubbed_shell_out) { shell_out.tap(&with_valid_exe_at_location) }

        context 'with executable path' do
          let(:cmd) { "#{executable_path}" }
          let(:executable_path) { 'C:\RUBY192\bin\ruby.exe' }

          it 'should use specified executable' do
            should eql([executable_path, cmd])
          end

          context 'with arguments' do
            let(:cmd) { "#{executable_path} arguments" }

            it 'should use specified executable' do
              should eql([executable_path, cmd])
            end
          end

          context 'with quoted arguments' do
            let(:cmd) { "#{executable_path} -e \"print 'fee fie foe fum'\"" }

            it 'should use specified executable' do
              should eql([executable_path, cmd])
            end
          end
        end

        # Examples taken from: https://github.com/opscode/mixlib-shellout/pull/2#issuecomment-4825574
        context 'with executable path enclosed in double quotes' do
          let(:cmd) { "#{executable_path}" }
          let(:executable_path) { '"C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\Bin\NETFX 4.0 Tools\gacutil.exe"' }

          it 'should use specified executable' do
            should eql([executable_path, cmd])
          end

          context 'with arguments' do
            let(:cmd) { "#{executable_path} arguments" }

            it 'should use specified executable' do
              should eql([executable_path, cmd])
            end
          end

          context 'with quoted arguments' do
            let(:cmd) { "#{executable_path} /i \"C:\Program Files (x86)\NUnit 2.6\bin\framework\nunit.framework.dll\"" }

            it 'should use specified executable' do
              should eql([executable_path, cmd])
            end
          end
        end

      end
    end
  end
end
