source "https://rubygems.org"

gemspec name: "mixlib-shellout"

group :docs do
  gem "yard"
  gem "redcarpet"
  gem "github-markup"
end

# added to its own group so we can exclude for Ruby 2.2
group :style do
  gem "chefstyle"
end

group :test do
  gem "rspec", "~> 3.0"
  gem "rake"
end

group :development do
  gem "pry"
  gem "pry-byebug"
  gem "pry-stack_explorer"
  gem "rb-readline"
end
