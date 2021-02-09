require 'oystercard'

describe Oystercard do

    it 'should default balance to DEFAULT_BALANCE' do
        expect(subject.balance).to eq(Oystercard::DEFAULT_BALANCE)
    end

    it 'should add :top_up(amount) to :balance' do
        expect { subject.top_up(5) }.to change { subject.balance }.by(5)
    end

    it "default maximum balance is £90" do
        expect(Oystercard::MAXIMUM_BALANCE).to eq 90
    end

    it 'should raise error when deposit exceed maximum amount' do
        subject.instance_variable_set(:@balance, Oystercard::MAXIMUM_BALANCE)
        expect { subject.top_up(1) }.to raise_error("Balance cannot exceed maximum of £#{Oystercard::MAXIMUM_BALANCE}")
    end

    it 'should deduct the given amount from the fare' do
        subject.instance_variable_set(:@balance, 10)
        expect { subject.deduct(6) }.to change { subject.balance }.by(-6)
    end
end
