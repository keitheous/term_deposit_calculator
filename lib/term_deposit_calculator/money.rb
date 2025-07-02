# frozen_string_literal: true

require 'bigdecimal'

module TermDepositCalculator
  class Money
    attr_reader :amount

    def initialize(amount)
      @amount = BigDecimal(amount.to_s)
    end

    def *(other)
      Money.new(@amount * other)
    end

    def /(other)
      Money.new(@amount / other)
    end

    def to_s
      format('%.2f', @amount)
    end
  end
end
