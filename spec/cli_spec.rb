require 'term_deposit_calculator/cli'

RSpec.describe TermDepositCalculator::CLI do
  let(:fake_money_class) do
    Class.new do
      def self.new(value); value end
    end
  end

  let(:fake_calculator_class) do
    Class.new do
      def initialize(starting, rate, years)
        @starting = starting
        @rate = rate
        @years = years
      end

      def calculate_interest_paid_at_maturity; "330.00" end
      def calculate_interest_paid_per_year;    "110.00" end
      def calculate_interest_paid_per_quarter; "110.00" end
      def calculate_interest_paid_per_month;   "110.00" end
    end
  end

  let(:cli) { described_class.new(fake_calculator_class, fake_money_class) }

  # valid user inputs
  let(:starting_amount) { "10000" }
  let(:interest_rate) { "1.1" }
  let(:investment_months) { "36" }

  before do
    allow(cli).to receive(:puts)
    allow(cli).to receive(:print)

    allow(cli).to receive(:gets).and_return(starting_amount, interest_rate, investment_months)
  end

  context "with all valid user inputs" do
    before do
      allow(cli).to receive(:gets).and_return("10000", "1.1", "36")
    end

    it "runs and prints all the output" do
      expect(cli).to receive(:puts).with("Interest paid at maturity: 330.00")
      expect(cli).to receive(:puts).with("Interest paid per year: 110.00")
      expect(cli).to receive(:puts).with("Interest paid per quarter: 110.00")
      expect(cli).to receive(:puts).with("Interest paid per month: 110.00")
      expect(cli).to receive(:puts).with("Thank you, have a nice day!")

      cli.run
    end
  end

  context "with invalid user input for starting amount" do
    before do
      allow(cli).to receive(:gets).and_return(starting_amount, "1.1", "36")
    end

    describe "when starting amount is a word" do
      let(:starting_amount) { "Hello!!" }

      it "prints an error message and exits" do
        expect(cli).to receive(:puts).with("Invalid input (Hello!!), must be an acceptable positive float type. Exiting...")
        cli.run
      end
    end

    describe "when starting amount is a negative number" do
      let(:starting_amount) { "-1.00" }

      it "prints an error message and exits" do
        expect(cli).to receive(:puts).with("Invalid input (-1.00), must be an acceptable positive float type. Exiting...")
        cli.run
      end
    end
  end

  context "with invalid user input for interest rate" do
    describe "when starting amount is a word" do
      let(:interest_rate) { "My name is Keith!!" }

      it "prints an error message and exits" do
        expect(cli).to receive(:puts).with("Invalid input (My name is Keith!!), must be an acceptable positive float type. Exiting...")
        cli.run
      end
    end

    describe "when starting amount is a negative number" do
      let(:interest_rate) { "-1" }

      it "prints an error message and exits" do
        expect(cli).to receive(:puts).with("Invalid input (-1), must be an acceptable positive float type. Exiting...")
        cli.run
      end
    end
  end

  context "with invalid user input for interest rate" do
    describe "when interest rate  is a word" do
      let(:interest_rate) { "My name is Keith!!" }

      it "prints an error message and exits" do
        expect(cli).to receive(:puts).with("Invalid input (My name is Keith!!), must be an acceptable positive float type. Exiting...")
        cli.run
      end
    end

    describe "when interest rate is a negative number" do
      let(:interest_rate) { "-1" }

      it "prints an error message and exits" do
        expect(cli).to receive(:puts).with("Invalid input (-1), must be an acceptable positive float type. Exiting...")
        cli.run
      end
    end
  end

  context "with invalid user input for investment months" do
    describe "when investment months is a word" do
      let(:investment_months) { "Bye, have a nice day" }

      it "prints an error message and exits" do
        expect(cli).to receive(:puts).with("Invalid input (Bye, have a nice day), must be an acceptable positive integer type. Exiting...")
        cli.run
      end
    end

        describe "when investment months is a negative number" do
      let(:investment_months) { "-3000" }

      it "prints an error message and exits" do
        expect(cli).to receive(:puts).with("Invalid input (-3000), must be an acceptable positive integer type. Exiting...")
        cli.run
      end
    end
  end
end