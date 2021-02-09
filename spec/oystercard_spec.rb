require 'oystercard'

describe Oystercard do
    it 'should default balance to 0' do
        expect(subject.balance).to eq 0
    end
end
