# frozen_string_literal: true

require_relative "term_deposit_calculator/money"
require_relative "term_deposit_calculator/calculator"
require_relative "term_deposit_calculator/cli"
require_relative "term_deposit_calculator/version"

module TermDepositCalculator
  class Error < StandardError; end
end
