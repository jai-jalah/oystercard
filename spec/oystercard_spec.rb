require 'oystercard'

describe Oystercard do

    it 'should default balance to DEFAULT_BALANCE' do
        expect(subject.balance).to eq(Oystercard::DEFAULT_BALANCE)
    end

    it 'should add :top_up(amount) to :balance' do
        expect { subject.top_up(5) }.to change { subject.balance }.by(5)
    end
end
