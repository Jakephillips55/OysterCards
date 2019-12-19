require_relative 'journey'

require_relative 'station'

class Oystercard
  attr_reader :balance, :journey_log
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  ERROR = { max: "Cannot go over £#{MAX_BALANCE}, card is full",
  min: "Cannot begin journey, not enough on card"
  }

  def initialize(journey_log = JourneyLog.new)
    @balance = 0
    @journey_log = journey_log
  end

  def top_up(value)
    max_error?(value)
    @balance += value
  end

  def touch_in(entry_station)
    complete_journey unless @journey_log.entry_station.nil?

    min_error?

    @journey_log.start(entry_station)
  end

  def touch_out(exit_station)
    @journey_log.finish(exit_station)
    complete_journey
  end

  def in_journey?
    @entry_station != true
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
    deduct(@journey_log.current_journey.fare)
  end

  def deduct(value)
    @balance -= value
  end
end
