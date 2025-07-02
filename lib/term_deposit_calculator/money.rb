require 'bigdecimal'

module TermDepositCalculator
  class Money
    attr_reader :amount

    def initialize(amount)
      @amount = BigDecimal(amount.to_s)
    end

    def *(multiplier)
      Money.new(@amount * multiplier)
    end

    def /(divisor)
      Money.new(@amount / divisor)
    end

    def to_s
      format('%.2f', @amount)
    end
  end
end