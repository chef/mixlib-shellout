source "https://rubygems.org"

gemspec name: "mixlib-shellout"

gem "win32-process", "~> 0.9"
gem "ffi-win32-extensions", "~> 1.0.4"
gem "wmi-lite", "~> 1.0.7"
# wmi-lite needs win32ole, which stopped being a default gem in Ruby 4.0
gem "win32ole" if Gem.win_platform?
gem "logger"

group :test do
  gem "cookstyle", ">=7.32.8"
  gem "rake"
  gem "rspec", "~> 3.0"
end

group :debug do
  gem "pry"
  gem "pry-byebug"
  gem "rb-readline"
end
