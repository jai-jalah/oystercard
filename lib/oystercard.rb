class Oystercard
    DEFAULT_BALANCE = 0
    MAX_BALANCE = 90
    MIN_FARE = 1

    attr_reader :balance, :deduct

    def initialize(balance = DEFAULT_BALANCE)
        @balance = balance
        @in_journey = false
    end

    def top_up(amount)
        raise "Balance cannot exceed maximum of £#{MAX_BALANCE}" unless @balance + amount <= MAX_BALANCE
        @balance += amount
    end

    def touch_in
        raise "Insufficient balance on card" if @balance < MIN_FARE
        @in_journey = true
    end

    def touch_out
        deduct(MIN_FARE)
        @in_journey = false
    end

    def in_journey?
        @in_journey
    end

    private

    def deduct(amount)
        @balance -= amount
    end

end
