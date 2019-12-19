require 'Journey'

describe Journey do
  let(:station1) { double(:station) }
  let(:station2) { double(:station) }

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
end
