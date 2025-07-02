# frozen_string_literal: true

RSpec.describe TermDepositCalculator::Money do
  let(:money) { described_class.new(100.00) }

  describe "#initialize" do
    it "initializes with a BigDecimal amount" do
      expect(money.amount).to be_a(BigDecimal)
      expect("%0.2f" % money.amount).to eq("100.00")
    end

    it "accepts specified amount as string, float or integer (defensively)" do
      money_with_integer_amount = described_class.new(100)
      money_with_string_amount = described_class.new("100.001")
      money_with_float_amount = described_class.new(100.001)

      expect(money_with_integer_amount.to_s).to eq("100.00")
      expect(money_with_string_amount.to_s).to eq("100.00")
      expect(money_with_float_amount.to_s).to eq("100.00")
    end

    it "rounds the amount up to two significant figures" do
      money_with_carry_forward = described_class.new(100.09999)
      money_without_carry_forward = described_class.new(100.0111111)

      expect(money_with_carry_forward.to_s).to eq("100.10")
      expect(money_without_carry_forward.to_s).to eq("100.01")
    end
  end

  describe "#to_s" do
    it "returns the amount as a formatted string" do
      expect(money.to_s).to eq("100.00")
    end
  end

  describe "#*" do
    let(:money_multiplied) { money * 10 * 10 }

    it "returns the multiplication of the original amount" do
      expect(money_multiplied.to_s).to eq("10000.00")
    end

    it "returns another instance of Money" do
      expect(money_multiplied).to be_a(described_class)
    end
  end

  describe "#/" do
    let(:money_divided) { money / 100 }

    it "returns the division of the original amount" do
      expect(money_divided.to_s).to eq("1.00")
    end

    it "returns another instance of Money" do
      expect(money_divided).to be_a(described_class)
    end
  end
end

