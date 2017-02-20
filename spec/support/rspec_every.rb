module RspecEvery
  def every(expected)
    RSpec::Matchers::BuiltIn::All.new(expected)
  end
end
