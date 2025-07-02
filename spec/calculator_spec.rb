require 'term_deposit_calculator/calculator'
require 'bigdecimal'

def dollar_amount(big_decimal_dollar)
  "%0.2f" % big_decimal_dollar
end

RSpec.describe TermDepositCalculator::Calculator do
  let(:investment_term_months) { 36 }
  let(:starting_amount) { BigDecimal(10000) }
  let(:interest_rate) { 0.011 }

  let(:calculator) { described_class.new(starting_amount, interest_rate, investment_term_months) }

  describe "#initialize" do
    it "initializes the interest_paid_per_year and investment_term_years in the calculator" do
      expect(dollar_amount(calculator.interest_paid_per_year)).to eq("110.00")
      expect(calculator.investment_term_years).to eq(3)
    end
  end

  describe "calculate_interest_paid_at_maturity" do
    it "returns the interest paid at maturity" do
      expect(dollar_amount(calculator.calculate_interest_paid_at_maturity)).to eq("330.00")
    end
  end

  describe "calculate_interest_paid_per_year" do
    it "returns the interest paid in a year" do
      expect(dollar_amount(calculator.calculate_interest_paid_per_year)).to eq("110.00")
    end
  end

  describe "calculate_interest_paid_per_month" do
    it "returns the interest paid in a month" do
      expect(dollar_amount(calculator.calculate_interest_paid_per_month)).to eq("9.17")
    end
  end

  describe "calculate_interest_paid_per_quarter" do
    it "returns the interest paid in a quarter" do
      expect(dollar_amount(calculator.calculate_interest_paid_per_quarter)).to eq("36.67")
    end
  end
end