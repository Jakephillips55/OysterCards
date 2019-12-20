require 'journey_log'
  describe JourneyLog do

  let(:station1)            { double(:station)}
  let(:station2)            { double(:station)}
  let(:new_journey)         { double(:new_journey, update_entry_station: nil, entry_station: nil, exit_station: nil) }
  let(:complete_journey)    { double(:incomplete_journey, entry_station: station1, exit_station: station2)}
  let(:incomplete_journey)  { double(:incomplete_journey, entry_station: station1, exit_station: nil)}
  #this is for testing when your testing classes that call other classes
  #your telling it what the output should be so that you dont have
  #crashes when looking into multiple classes
  #i.e let this equal this (defined in double)

  it 'should be able to update entry station when a journey is started' do
    log = described_class.new(new_journey)
    #does defining log here matter? is there a better syntax
    #for this that takes up less lines?
    expect(new_journey).to receive :update_entry_station
    log.start(station1)
  end

  it 'should be able to update exit station when a journey is ended' do
    log = described_class.new(new_journey)
    expect(new_journey).to receive :update_exit_station
    #let is defined similar to instance variables as a ()statement.
    log.finish(station2)
  end

  it 'should have a current_journey method that will return a journey if incomplete' do
    log = described_class.new incomplete_journey

    expect(log.current_journey).to eq log.journeys
    #was getting error with incomplete_journey defined uptop
    #this was due to it getting pushed into and array
    #output was correct but other methods were causing the error.
    #lesson learned read your code and see whats interacting with what.
  end

  it 'A journey class method that will reset the journey_class variable if complete' do
    # how to test this with a double??
  
  end

  it 'should have a journeys instance variable that will return a list of all previous journeys' do
    log = described_class.new(new_journey)
    log.current_journey
    expect(log.journeys).to include(new_journey)
  end
end
