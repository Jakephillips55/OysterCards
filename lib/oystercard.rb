require_relative 'journey'
require_relative 'station'

class Oystercard
  attr_reader :balance, :journey_history, :journey
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  ERROR = { max: "Cannot go over £#{MAX_BALANCE}, card is full",
  min: "Cannot begin journey, not enough on card"
  }

  def initialize(journey = Journey.new)
    @balance = 0
    @journey = journey
    @journey_history = []
  end

  def top_up(value)
    max_error?(value)
    @balance += value
  end

  def touch_in(entry_station)
    complete_journey unless @journey.entry_station.nil?
    min_error?
    @journey.update_entry_station(entry_station)
  end

  def touch_out(exit_station)
    @journey.update_exit_station(exit_station)
    complete_journey
  end

  def in_journey?
    !@entry_station != true
  end


  private

  def update_journey_history

    @journey_history << @journey
    @journey = Journey.new
  end

  def max_error?(value)
    fail ERROR[:max] if
    @balance + value > MAX_BALANCE
  end

  def min_error?
    fail ERROR[:min] if @balance < MIN_BALANCE
  end

  def complete_journey
    deduct(@journey.fare)
    update_journey_history
  end

  def deduct(value)
    @balance -= value
  end
end
