$:.unshift(File.dirname(__FILE__) + "/lib")
require "mixlib/shellout/version"

Gem::Specification.new do |s|
  s.name = "mixlib-shellout"
  s.version = Mixlib::ShellOut::VERSION
  s.platform = Gem::Platform::RUBY
  s.extra_rdoc_files = ["README.md", "LICENSE" ]
  s.summary = "Run external commands on Unix or Windows"
  s.description = s.summary
  s.author = "Chef Software Inc."
  s.email = "info@chef.io"
  s.homepage = "https://github.com/chef/mixlib-shellout"

  s.required_ruby_version = ">= 2.2"

  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "chefstyle"

  s.require_path = "lib"
  s.files = %w{LICENSE README.md} +
    Dir.glob("lib/**/*", File::FNM_DOTMATCH).reject { |f| File.directory?(f) }
end
