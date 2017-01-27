require "bundler"
require "rspec/core/rake_task"

Bundler::GemHelper.install_tasks name: "mixlib-shellout"

require "chefstyle"
require "rubocop/rake_task"
desc "Run Ruby style checks"
RuboCop::RakeTask.new(:style)

desc "Run all specs in spec directory"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = FileList["spec/**/*_spec.rb"]
end

task default: [:spec, :style]
