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

group :debug do
  gem "pry"
  gem "pry-byebug"
  gem "pry-stack_explorer"
  gem "rb-readline"
end

instance_eval(ENV["GEMFILE_MOD"]) if ENV["GEMFILE_MOD"]

# If you want to load debugging tools into the bundle exec sandbox,
# add these additional dependencies into Gemfile.local
eval_gemfile(__FILE__ + ".local") if File.exist?(__FILE__ + ".local")
