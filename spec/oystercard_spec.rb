require 'oystercard'

describe Oystercard do

    it 'should default balance to DEFAULT_BALANCE' do
        expect(subject.balance).to eq(Oystercard::DEFAULT_BALANCE)
    end

    it 'should add :top_up(amount) to :balance' do
        expect { subject.top_up(5) }.to change { subject.balance }.by(5)
    end

    it "should default maximum balance to £90" do
        expect(Oystercard::MAX_BALANCE).to eq 90
    end

    it 'should raise an error when deposit exceeds maximum amount' do
        subject.instance_variable_set(:@balance, Oystercard::MAX_BALANCE)
        expect { subject.top_up(1) }.to raise_error("Balance cannot exceed maximum of £#{Oystercard::MAX_BALANCE}")
    end

    it "should not be in a journey at beginning" do
        expect(Oystercard.new().in_journey?).to eq false
    end

    describe "touches in and out" do
        before do
            subject.top_up(1)
            # subject.instance_variable_set(:in_journey?, false)
        end

        it "touches in" do
            subject.touch_in()
            expect(subject.in_journey?).to eq true
        end

        it "touches out" do
            subject.touch_in
            subject.touch_out
            expect(subject.in_journey?).to eq false
        end
    end

    it 'should set minimum fare to £1' do
        expect(Oystercard::MIN_FARE).to eq 1
    end

    it 'should raise an error if user tries to touch in with a balance less than MIN_FARE' do
        expect { subject.touch_in }.to raise_error("Insufficient balance on card")
    end

    it 'should deduct MIN_FARE when user touches out' do
        subject.top_up(Oystercard::MIN_FARE)
        subject.touch_in
        expect { subject.touch_out }.to change { subject.balance }.by(-Oystercard::MIN_FARE)
    end

    describe 'for user journey' do
        before do
            subject.top_up(Oystercard::MIN_FARE)
            subject.touch_in("waterloo")
        end

        it 'should remember the entry station after touch_in' do
            expect(subject.entry_station).to eq :waterloo
        end

        it 'when touched out - should set entry_station to nil' do
            subject.touch_out
            expect(subject.entry_station).to be_nil
        end
    end

end
