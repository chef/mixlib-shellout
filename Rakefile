require "bundler"
require "rspec/core/rake_task"
require "mixlib/shellout/version"

Bundler::GemHelper.install_tasks name: "mixlib-shellout"

require "chefstyle"
require "rubocop/rake_task"
desc "Run Ruby style checks"
RuboCop::RakeTask.new(:style)

desc "Run all specs in spec directory"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = FileList["spec/**/*_spec.rb"]
end

begin
  require "github_changelog_generator/task"

  GitHubChangelogGenerator::RakeTask.new :changelog do |config|
    config.issues = false
    config.future_release = Mixlib::ShellOut::VERSION
  end
rescue LoadError
  puts "github_changelog_generator is not available. gem install github_changelog_generator to generate changelogs"
end

task default: [:spec, :style]
