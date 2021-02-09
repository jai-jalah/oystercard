require 'oystercard'

describe Oystercard do

    it 'should default balance to DEFAULT_BALANCE' do
        expect(subject.balance).to eq(Oystercard::DEFAULT_BALANCE)
    end

    it 'should add :top_up(amount) to :balance' do
        expect { subject.top_up(5) }.to change { subject.balance }.by(5)
    end

    it "should default maximum balance to £90" do
        expect(Oystercard::MAXIMUM_BALANCE).to eq 90
    end

    it 'should raise an error when deposit exceed maximum amount' do
        subject.instance_variable_set(:@balance, Oystercard::MAXIMUM_BALANCE)
        expect { subject.top_up(1) }.to raise_error("Balance cannot exceed maximum of £#{Oystercard::MAXIMUM_BALANCE}")
    end

    it 'should deduct the given amount from the fare' do
        subject.instance_variable_set(:@balance, 10)
        expect { subject.deduct(6) }.to change { subject.balance }.by(-6)
    end

    context "touches in and out" do
        it "is not in a journey initially" do
            expect(Oystercard.new().in_journey?).to eq false
        end

        before (:each) do
            subject.instance_variable_set(:@in_journey, false)
        end

        it "touches in" do
            subject.touch_in
            expect(subject.in_journey?).to eq true
        end

        it "touches out" do
            subject.touch_in
            subject.touch_out
            expect(subject.in_journey?).to eq false
        end
    end
end
