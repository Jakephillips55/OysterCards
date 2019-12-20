require 'journey_log'
  describe JourneyLog do

  let(:station1)            { double(:station)}
  let(:station2)            { double(:station)}
  let(:new_journey)         { double(:new_journey, update_entry_station: nil, entry_station: nil, exit_station: nil, fare: 3) }
  let(:complete_journey)    { double(:incomplete_journey, entry_station: station1, exit_station: station2)}
  let(:incomplete_journey)  { double(:incomplete_journey, entry_station: station1, exit_station: nil)}
  #this is for testing when your testing classes that call other classes
  #your telling it what the output should be so that you dont have
  #crashes when looking into multiple classes
  #i.e let this equal this (defined in double)

  it 'starts a journey' do
    log = described_class.new(new_journey)
    # If the first argument to an example group is a class, the class is exposed to
    # each example in that example group via the described_class() method.
    #does defining log here matter? is there a better syntax
    #for this that takes up less lines?
    expect(new_journey).to receive :update_entry_station
    log.start(station1)
  end

  it 'ends a journey' do
    log = described_class.new(new_journey)
    expect(new_journey).to receive :update_exit_station
    #let is defined similar to instance variables as a ()statement.
    log.finish(station2)
  end

  it 'should have a current_journey method that will return a journey if incomplete' do
    log = described_class.new incomplete_journey

    expect(log.current_journey).to be_truthy
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
    allow(new_journey).to receive(:update_exit_station).and_return(station1)
    log.finish(station1)
    expect(log.journeys).to include(new_journey)
    #pretty sure this only works if user is
    #currently in a journey will check in irb
  end
end
