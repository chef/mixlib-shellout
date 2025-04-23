source "https://rubygems.org"

gemspec name: "mixlib-shellout"

gem "win32-process", "~> 0.9"
# for ruby 3.0, install older ffi before
# installing ffi-requiring stuff
if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("3.1")
  gem "ffi", "< 1.17.0"
end
gem "ffi-win32-extensions", "~> 1.0.4"
gem "wmi-lite", "~> 1.0.7"
gem "logger"

group :test do
  gem "cookstyle", ">=7.32.8"
  gem "rake"
  gem "rspec", "~> 3.0"
end

group :debug do
  gem "pry"
  # version lock for old ruby 3.0 - once we're off
  # of 3.0, remove this line, let pry-byebug pull
  # in whatever it wants
  if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("3.1")
    gem "byebug", "~> 11.1"
  end
  gem "pry-byebug"
  gem "rb-readline"
end
