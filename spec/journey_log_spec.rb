require 'journey_log'
  describe JourneyLog do

  let(:station1)            { double(:station) }
  let(:station2)            { double(:station) }
  let(:new_journey)         { double(:new_journey, update_entry_station: nil, entry_station: nil, exit_station: nil) }
  let(:complete_journey)    { double(:incomplete_journey, entry_station: station1, exit_station: station2)}
  let(:incomplete_journey)  { double(:incomplete_journey, entry_station: station1, exit_station: nil)}

  it 'should be able to update entry station when a journey is started' do
    log = described_class.new(new_journey)
    expect(new_journey).to receive :update_entry_station
    log.start(station1)
  end

  it 'should be able to update entry station when a journey is started' do
    log = described_class.new(new_journey)
    expect(new_journey).to receive :update_exit_station
    log.finish(station2)
  end

  it 'should have a current_journey method that will return a journey if incomplete' do
    log = described_class.new(incomplete_journey)
    expect(log.current_journey).to eq incomplete_journey
  end

  it 'should have a journey class method that will reset the journey_class variable if complete' do
    # how to test this with a double??
  end

  it 'should have a journeys instance variable that will return a list of all previous journeys' do
    log = described_class.new(new_journey)
    log.current_journey
    expect(log.journeys).to include(new_journey)
end
end 
