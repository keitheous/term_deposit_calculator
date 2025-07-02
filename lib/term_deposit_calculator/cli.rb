# frozen_string_literal: true

module TermDepositCalculator
  class CLI
    PROMPTS = {
      starting_amount: {
        message: 'Enter starting amount (example, enter 3500.00 for $3500.00): ',
        type: :float,
        convert: ->(val, money_class) { money_class.new(format('%0.2f', val.to_f)) }
      },
      interest_rate: {
        message: 'Enter interest rate (example, enter 1.5 for 1.50%): ',
        type: :float,
        convert: ->(val, _) { val.to_f / 100.0 }
      },
      investment_term_months: {
        message: 'Enter the number of months for investment (example, enter 24 for two years): ',
        type: :integer,
        convert: ->(val, _) { val.to_i }
      }
    }.freeze

    attr_reader :calculator_class, :money_class

    def initialize(calculator_class, money_class)
      @calculator_class = calculator_class
      @money_class = money_class
    end

    def run
      results = {}

      PROMPTS.each do |key, config|
        input = prompt(config[:message])

        validated = validate_and_convert(
          user_input: input,
          acceptable_type: config[:type],
          conversion_method: ->(value) { config[:convert].call(value, money_class) }
        )

        return print_invalid_input_exit_message(input, config[:type]) unless validated

        results[key] = validated
      end

      term_deposit = calculator_class.new(
        results[:starting_amount],
        results[:interest_rate],
        results[:investment_term_months]
      )

      ['at maturity', 'per year', 'per quarter', 'per month'].each do |period|
        print_interest_paid_message(period, term_deposit.send("calculate_interest_paid_#{period.tr(' ', '_')}"))
      end

      puts 'Thank you, have a nice day!'
    end

    private

    def prompt(message)
      print message
      gets.chomp
    end

    def print_interest_paid_message(period, amount)
      puts "Interest paid #{period}: #{amount}"
    end

    def validate_and_convert(user_input:, acceptable_type:, conversion_method:)
      return false unless validate_input_type(acceptable_type, user_input)

      conversion_method.call(acceptable_type == :float ? user_input.to_f : user_input.to_i)
    end

    def validate_input_type(acceptable_type, user_input)
      user_input_converted = acceptable_type == :float ? Float(user_input) : Integer(user_input)

      user_input_converted.positive?
    rescue ArgumentError
      false
    end

    def print_invalid_input_exit_message(user_input, acceptable_type)
      puts "Invalid input (#{user_input}), must be an acceptable positive #{acceptable_type} type. Exiting..."
    end
  end
end
