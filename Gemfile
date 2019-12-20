source "https://rubygems.org"

gemspec name: "mixlib-shellout"

group :docs do
  gem "yard"
  gem "redcarpet"
  gem "github-markup"
end

group :test do
  gem "chefstyle", "~> 0.12.0" # still supports Ruby 2.2 TargetRubyVersion
  gem "rspec", "~> 3.0"
  gem "rake"
end

group :debug do
  gem "pry"
  gem "pry-byebug", "~> 3.6.0" # Pinned for ruby 2.2
  gem "pry-stack_explorer"
  gem "rb-readline"
end

instance_eval(ENV["GEMFILE_MOD"]) if ENV["GEMFILE_MOD"]

# If you want to load debugging tools into the bundle exec sandbox,
# add these additional dependencies into Gemfile.local
eval_gemfile(__FILE__ + ".local") if File.exist?(__FILE__ + ".local")
