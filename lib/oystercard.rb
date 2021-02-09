class Oystercard
    DEFAULT_BALANCE = 0
    MAXIMUM_BALANCE = 90
    attr_reader :balance

    def initialize(balance = DEFAULT_BALANCE)
        @balance = balance
        @in_journey = false
    end

    def top_up(amount)
        fail "Balance cannot exceed maximum of £#{MAXIMUM_BALANCE}" unless @balance + amount <= MAXIMUM_BALANCE
        @balance += amount
    end

    def deduct(amount)
        @balance -= amount
    end

    def touch_in
        @in_journey = true
    end

    def touch_out
        @in_journey = false
    end

    def in_journey?
        @in_journey
    end
end
