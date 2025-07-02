# frozen_string_literal: true

module TermDepositCalculator
  class Calculator
    attr_reader :interest_paid_per_year, :investment_term_years

    def initialize(starting_amount, interest_rate, investment_term_months)
      @interest_paid_per_year = starting_amount * interest_rate
      @investment_term_years = investment_term_months / 12.0
    end

    def calculate_interest_paid_per_year
      interest_paid_per_year
    end

    def calculate_interest_paid_per_month
      interest_paid_per_year / 12
    end

    def calculate_interest_paid_per_quarter
      interest_paid_per_year / 3
    end

    def calculate_interest_paid_at_maturity
      interest_paid_per_year * investment_term_years
    end
  end
end