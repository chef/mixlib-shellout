gemspec = instance_eval(File.read(File.expand_path("mixlib-shellout.gemspec", __dir__)))

gemspec.platform = Gem::Platform.new(%w{universal mingw32 mingw})

gemspec.add_dependency "win32-process", "~> 0.10"
gemspec.add_dependency "wmi-lite", "~> 1.0"
gemspec.add_dependency "ffi-win32-extensions", "~> 1.0.3"

gemspec
