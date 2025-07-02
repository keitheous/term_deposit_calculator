# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

require_relative 'lib/term_deposit_calculator'

desc 'Start the Term Deposit Calculator'
task :start do
  ARGV.clear

  TermDepositCalculator::CLI.new(
    TermDepositCalculator::Calculator,
    TermDepositCalculator::Money
  ).run
end
