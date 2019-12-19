require 'oystercard'

describe Oystercard do

  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { { entry_station: entry_station, exit_station: exit_station } }

  describe '#initialize' do
    it 'should initialize with a balance of zero' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'card can be topped up' do
      subject.top_up(4)
      expect(subject.balance).to eq(4)
    end

    it 'should not allow user to go over Max balance' do
      subject.top_up(87)
      expect { subject.top_up(5) }.to raise_error Oystercard::ERROR[:max]
    end
  end

  describe '#touch_in' do
    # it "should update a card as 'in use' when touching in" do
    #   subject.top_up(5)
    #   subject.touch_in(:station)
    #   expect(subject.in_journey?).to eq true
    # end

    it 'should raise an error if attempting to touch when balance too low' do
      expect { subject.touch_in(entry_station) }.to raise_error Oystercard::ERROR[:min]
    end

    # it 'should store the entry station when touching in' do
    #   subject.top_up(5)
    #   subject.touch_in(:station)
    #   expect(subject.entry_station).to eq :station
    # end
  end

  # describe '#touch_out' do
  #   it "should update a card as 'not in use' when touching out" do
  #     subject.touch_out(:station)
  #     expect(subject.in_journey?).to eq false
  #   end

    #***** it 'should deduct the fare when touching out' do
    #   subject.top_up(5)
    #   subject.touch_in(:entry_station)
    #   expect { subject.touch_out(:exit_station) }.to change { subject.balance }.by(-3)
    # end

    # it 'should forget the entry station on touch out' do
    #   subject.top_up(5)
    #   subject.touch_in(:station)
    #   subject.touch_out(:station)
    #   expect(subject.entry_station).to eq nil
    # end
    #
    # it 'should add the journey to journey history' do
    #   travel = Journey.new
    #   card = Oystercard.new(travel)
    #   card.top_up(5)
    #   card.touch_in(:entry_station)
    #   card.touch_out(:exit_station)
    #   expect(card.journey_history).to include(travel)
    # end
  end
