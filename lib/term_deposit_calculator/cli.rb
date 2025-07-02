module TermDepositCalculator
  class CLI
    attr_reader :calculator_class, :money_class

    def initialize(calculator_class, money_class)
      @calculator_class = calculator_class
      @money_class = money_class
    end

    def run
      starting_amount_input = prompt("Enter starting amount (example, enter 3500.00 for $3500.00): ")

      valid_starting_amount = validate_and_convert(
        user_input: starting_amount_input,
        acceptable_type: :float,
        conversionMethod: -> (starting_amount) { money_class.new('%0.2f' % starting_amount.to_f) }
      )
      
      return print_invalid_input_exit_message(starting_amount_input, :float) unless valid_starting_amount

      interest_rate_input = prompt("Enter interest rate (example, enter 1.5 for 1.50%): ")

      valid_interest_rate = validate_and_convert(
        user_input: interest_rate_input,
        acceptable_type: :float,
        conversionMethod: -> (interest_rate) { interest_rate / 100.0 }
      )

      return print_invalid_input_exit_message(interest_rate_input, :float) unless valid_interest_rate

      investment_term_months_input = prompt("Enter the number of months for investment (example, enter 24 for two years): ")

      valid_investment_term_months = validate_and_convert(
        user_input: investment_term_months_input,
        acceptable_type: :integer,
        conversionMethod: -> (months) { months }
      )

      return print_invalid_input_exit_message(investment_term_months_input, :integer) unless valid_investment_term_months
      
      term_deposit = calculator_class.new(
        valid_starting_amount,
        valid_interest_rate,
        valid_investment_term_months
      )

      for period in ['at maturity', 'per year', 'per quarter', 'per month']
        print_interest_paid_message(period, term_deposit.send("calculate_interest_paid_#{period.tr(" ", "_")}"))
      end

      puts "Thank you, have a nice day!"
    end

    private

    def prompt(message)
      print message
      gets.chomp
    end

    def print_interest_paid_message(period, amount)
      puts "Interest paid #{period}: #{amount}"
    end

    def validate_and_convert(user_input:, acceptable_type:, conversionMethod:)
      return false unless validate_input_type(acceptable_type, user_input)

      conversionMethod.call(acceptable_type == :float ? user_input.to_f : user_input.to_i)
    end

    def validate_input_type(acceptable_type, user_input)
      begin
        user_input_converted = acceptable_type == :float ? Float(user_input) : Integer(user_input) 

        user_input_converted > 0
      rescue ArgumentError
        false
      end
    end

    def print_invalid_input_exit_message(user_input, acceptable_type)
      puts "Invalid input (#{user_input}), must be an acceptable positive #{acceptable_type} type. Exiting..."
    end
  end
end