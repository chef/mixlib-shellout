source "https://rubygems.org"

gemspec name: "mixlib-shellout"

gem "win32-process", "~> 0.9"
gem "ffi-win32-extensions", "~> 1.0.4"
gem "ffi", "< 1.17.0"
gem "wmi-lite", "~> 1.0.7"

group :test do
  gem "chefstyle", "1.6.2"
  gem "rake"
  gem "rspec", "~> 3.0"
end

group :debug do
  gem "pry"
  gem "pry-byebug"
  gem "rb-readline"
end

if Gem.ruby_version < Gem::Version.new("2.6")
  # 16.7.23 required ruby 2.6+
  gem "chef-utils", "< 16.7.23" # TODO: remove when we drop ruby 2.4/2.5
end
