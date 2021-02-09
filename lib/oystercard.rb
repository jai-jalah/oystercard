class Oystercard
    DEFAULT_BALANCE = 0
    MAXIMUM_BALANCE = 90
    attr_reader :balance

    def initialize(balance = DEFAULT_BALANCE)
        @balance = balance
    end

    def top_up(amount)
        fail "Balance cannot exceed maximum of £#{MAXIMUM_BALANCE}" unless @balance + amount <= MAXIMUM_BALANCE
        @balance += amount
    end

end

