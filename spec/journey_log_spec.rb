require 'journey_log'

describe JourneyLog do
let(:station1) { double :station}
let(:station2) { double :station}
  it 'should have the journey class paramenter when we initialize a journey log' do
    expect { subject.journey_class }.to_not raise_error
  end

    it 'should start a new journey with an entry station when calling the start method' do

    end
end
