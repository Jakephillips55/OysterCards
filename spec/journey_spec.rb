require 'Journey'

describe Journey do
  let(:station1) { double(:station, zone: 1) }
  let(:station2) { double(:station, zone: 1) }

  it "is nil when a new Journey object" do
    expect(subject.entry_station).to eq nil
  end

  it "is nil when a new Journey object" do
    expect(subject.exit_station).to eq nil

  end

  it "should accept updates for entry station" do
    subject.update_entry_station(station1)
    expect(subject.entry_station).to eq station1
  end

  it "should accept updates for exit station" do
    subject.update_exit_station(station2)
    expect(subject.exit_station).to eq station2
  end

  it 'should charge MIN_FARE' do
    subject.update_entry_station(station1)
    subject.update_exit_station(station2)
    expect(subject.fare).to eq Journey::MIN_CHARGE
  end

  it 'charges PENALTY_FARE if user Journey !complete' do
    subject.update_exit_station(station1)
    expect(subject.fare).to eq Journey::PENALTY_CHARGE
  end
  it 'charges PENALTY_FARE if user Journey !complete' do
    subject.update_entry_station(station2)
    expect(subject.fare).to eq Journey::PENALTY_CHARGE
  end


  context 'given an exit station' do
    let(:other_station) { double :other_station }

    before do
      subject.finish(other_station)
    end
    it 'calculates a fare for zone 1 to zone 1' do
      update_zones(1,1)
      expect(subject.fare).to eq 1
    end
    it 'calculates a fare for zone 1 to zone 2' do
      update_zones(1,2)
      expect(subject.fare).to eq 2
    end
    it 'calculates a fare for zone 6 to zone 5' do
      update_zones(6,5)
      expect(subject.fare).to eq 2
    end
    it 'calculates a fare for zone 6 to zone 1' do
      update_zones(6,1)
      expect(subject.fare).to eq
    end
    it 'knows if a Journey if complete' do
      expect(subject).to be_complete
    end

    def update_zones(entry_station, exit_zone)
      allow(station).to receive(:zone).and_return(entry_zone)
      allow(other_station).to receive(:zone).and_return(exit_zone)
    end
end
end
