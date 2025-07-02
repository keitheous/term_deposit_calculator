# frozen_string_literal: true

require_relative "lib/term_deposit_calculator/version"

Gem::Specification.new do |spec|
  spec.name = "term_deposit_calculator"
  spec.version = TermDepositCalculator::VERSION
  spec.authors = ["keitheous"]
  spec.email = ["i.am.keith.chong@gmail.com"]

  spec.summary = ""
  spec.description = ""
  spec.required_ruby_version = ">= 3.1.0"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
