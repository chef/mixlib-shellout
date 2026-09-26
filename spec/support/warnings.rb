# Fail the run if the library itself emits a Ruby warning (method redefinition,
# unused variables, deprecated APIs, etc). Warnings from other gems are left alone.
module LibWarningsAreErrors
  LIB_DIR = File.expand_path("../../lib", __dir__)

  def warn(message, *args, **kwargs)
    raise "Ruby warning emitted from lib/: #{message}" if message.include?(LIB_DIR)

    super
  end
end

Warning.singleton_class.prepend(LibWarningsAreErrors)
