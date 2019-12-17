class Oystercard
  MAXIMUN = 90
  MINIMUM = 1
  MIN_CHARGE = 1
  ERROR = {
    max: 'Maximun allowance reached'.freeze,
    min: 'raise_error if below min amount'
   }
  attr_reader :balance, :entry_station, :journey_history, :entry_station, :exit_station

  @journeys = [ ]

    def initialize
      @balance = 0
      @entry_station = nil
      @exit_station = nil
      @journey_history = []
    end

    def top_up amount
      fail ERROR[:max] if @balance >= MAXIMUN

      @balance += amount
    end

    def touch_in station
      fail ERROR[:min] if @balance < MINIMUM

      @entry_station = entry_station


#this was failing due to not having a amount
#to succcssfully test top_up(1)

    end

    def touch_out(exit_station)
      reduce(MIN_CHARGE)

      @exit_station = exit_station

      update_journey_history
    end

    def total_balance
      "You have a total balance of £#{@balance}"
    end

    def in_journey?
      !entry_station !=true
    end

    def update_journey_history()
      journey = {
        Entry_station: @entry_station,
        Exit_station: @exit_station
      }
      @journey_history << journey
      @entry_station = nil
      @exit_station = nil 
    end

    def num
      i = @journeys.count + 1
      journey + i
    end

private
    def reduce amount
      @balance -= amount
    end

end
