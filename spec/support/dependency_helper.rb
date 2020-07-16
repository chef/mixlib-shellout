class DependencyProc < Proc
  attr_accessor :present

  def self.with(present)
    provided = Gem::Version.new(present.dup)
    new do |required|
      !Gem::Requirement.new(required).satisfied_by?(provided)
    end.tap { |l| l.present = present }
  end

  def inspect
    "\"#{present}\""
  end
end
