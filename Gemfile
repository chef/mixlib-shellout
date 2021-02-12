source "https://rubygems.org"

gemspec name: "mixlib-shellout"

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
