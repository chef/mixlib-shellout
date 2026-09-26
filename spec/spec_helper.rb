require_relative "support/warnings"
require "mixlib/shellout"

require "tmpdir"
require "tempfile"
require "timeout"

# Load everything from spec/support
Dir[File.join(__dir__, "support", "**", "*.rb")].sort.each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
    c.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.disable_monkey_patching!
  config.warnings = true

  config.filter_run_when_matching :focus
  config.filter_run_excluding external: true
  config.filter_run_excluding windows_only: true unless windows?
  config.filter_run_excluding unix_only: true unless unix?
  config.filter_run_excluding linux_only: true unless linux?
  config.filter_run_excluding requires_root: true unless root?

  # Enables `rspec --only-failures` and `rspec --next-failure`
  config.example_status_persistence_file_path = "spec/examples.txt"

  config.order = :random
  Kernel.srand config.seed
end
