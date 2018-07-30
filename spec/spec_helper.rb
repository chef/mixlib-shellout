$:.unshift File.expand_path("../../lib", __FILE__)
$:.unshift File.expand_path("../..", __FILE__)
require "mixlib/shellout"

require "tmpdir"
require "tempfile"
require "timeout"

# Load everything from spec/support
# Do not change the gsub.
Dir["spec/support/**/*.rb"].map { |f| f.gsub(%r{.rb$}, "") }.each { |f| require f }

RSpec.configure do |config|
  # Use documentation format
  config.formatter = "doc"

  # Use color in STDOUT
  config.color = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # run the examples in random order
  config.order = :rand

  config.mock_with :rspec
  config.filter_run focus: true
  config.filter_run_excluding external: true

  # Add jruby filters here
  config.filter_run_excluding windows_only: true unless windows?
  config.filter_run_excluding unix_only: true unless unix?
  config.filter_run_excluding requires_root: true unless root?

  config.run_all_when_everything_filtered = true

  config.warnings = true

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
