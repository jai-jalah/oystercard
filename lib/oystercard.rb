class Oystercard
    DEFAULT_BALANCE = 0
    MAX_BALANCE = 90
    MIN_FARE = 1

    attr_reader :balance, :deduct, :entry_station

    def initialize(balance = DEFAULT_BALANCE)
        @balance = balance
    end

    def top_up(amount)
        raise "Balance cannot exceed maximum of £#{MAX_BALANCE}" unless @balance + amount <= MAX_BALANCE
        @balance += amount
    end

    def touch_in(entry_station = "default")
        raise "Insufficient balance on card" if @balance < MIN_FARE
        @entry_station = entry_station.to_sym
    end

    def touch_out
        deduct(MIN_FARE)
        @entry_station = nil
    end

    def in_journey?
        !!entry_station
    end

    private

    def deduct(amount)
        @balance -= amount
    end

end
