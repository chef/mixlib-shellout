def windows?
  !!(RUBY_PLATFORM =~ /mswin|mingw|windows/)
end

# def jruby?

def unix?
  !windows?
end

if windows?
  LINE_ENDING = "\r\n".freeze
  ECHO_LC_ALL = "echo %LC_ALL%".freeze
else
  LINE_ENDING = "\n".freeze
  ECHO_LC_ALL = "echo $LC_ALL".freeze
end

def root?
  return false if windows?
  Process.euid == 0
end
