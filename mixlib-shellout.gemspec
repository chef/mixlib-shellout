$:.unshift(File.dirname(__FILE__) + '/lib')
require 'mixlib/shellout/version'

Gem::Specification.new do |s|
  s.name = 'mixlib-shellout'
  s.version = Mixlib::ShellOut::VERSION
  s.platform = Gem::Platform::RUBY
  s.extra_rdoc_files = ["README.md", "LICENSE" ]
  s.summary = "Run external commands on Unix or Windows"
  s.description = s.summary
  s.author = "Opscode"
  s.email = "info@opscode.com"
  s.homepage = "http://wiki.opscode.com/"

  s.required_ruby_version = ">= 1.9.3"

  s.add_dependency "wmi-lite", "~> 1.0"
  s.add_development_dependency "rspec", "~> 3.0"

  s.bindir       = "bin"
  s.executables  = []
  s.require_path = 'lib'
  s.files = %w(LICENSE README.md) + Dir.glob("lib/**/*")
end
