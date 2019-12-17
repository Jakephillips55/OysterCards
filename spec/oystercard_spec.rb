require 'oystercard'

describe Oystercard do
  let(:entry_station){ double :station }
  let(:exit_station){ double :station }
  let(:journey) { { entry_station: entry_station, exit_station: exit_station } }


  it 'stores the entry station' do
    subject.top_up(1)
    subject.touch_in(station)
    expect(subject.entry_station).to eq station
  end
  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
      it { is_expected.to respond_to(:top_up).with(1).argument }

      it 'can top up the balance' do
        expect{ subject.top_up 1}.to change{ subject.balance }.by 1
      end

      it 'Maximun allowance reached'do
      Oystercard::MAXIMUN.times {subject.top_up(1)}
      expect {subject.top_up(@balance)}.to raise_error(Oystercard::ERROR[:max])
    end


  # describe '#reduce' do
  #   it {is_expected.to respond_to(:reduce).with(1).argument}
  # end
# it 'deducts an amount' do
# subject.top_up(20)
# expect{ subject.reduce(3)}.to change{ subject.balance }.by -3
# end

  describe '#touch_in' do
    it 'raise_error if below min amount' do
      expect {subject.touch_in(station)}.to raise_error(Oystercard::ERROR[:min])
    end

    it 'reduce card amount by min_charge' do
      subject.top_up(5)
      subject.touch_in(station)
      expect{ subject.touch_out(5) }.to change{ subject.balance }.by(-Oystercard::MIN_CHARGE)
    end
  describe '#in_journey' do
  it 'returns true if in journey' do
    allow(subject).to receive(:entry_station).and_return(true)
    expect(subject.in_journey?).to eq(true)
  end

  it 'has an empty list of journeys by default' do
    expect(subject.journeys).to be_empty
  end

  it 'returns false if not in journey' do
    allow(subject).to receive(:entry_station).and_return(false)
    expect(subject.in_journey?).to eq(false)
  end
end

  describe '#touch_out' do
    let(:entry_station) { double :station }
    let(:exit_station) { double :station }
    let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

    it 'stores a journey' do
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journeys).to include journey
  end
end
  it 'reduces by minimum amount' do
    expect {subject.touch_out}.to change { subject.balance }.by -1
end
    it 'stores exit_station' do
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq exit_station
    end

  describe '#journey_history' do
    it 'has a empty history by default' do
      expect(subject.journeys).to be_empty
    end
    it 'has an entry_station' do
      subject.top_up(1)
      subject.touch_in(entry_station)
      subject.touch_out(2, exit_station)
      expect(subject.journeys[0][:Exit_station].to eq(exit_station))
    end
    it 'stores entry & exit station in one journey' do
      subject.top_up(1)
      subject.touch_in(entry_station)
      subject.touch_out(2, exit_station)
      expect(subject.journeys[0]).to include(:Entry_station, :Exit_station)
    end
end
end
end
end
