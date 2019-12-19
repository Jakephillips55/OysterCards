class JourneyLog

attr_reader :journey_class, :journeys, :entry_station, :exit_station

  def initialize(journey_class = Journey.new)
    @journey_class = journey_class
    @journeys = []
  end

  def start(entry_station)
    @journey_class.update_entry_station(entry_station)
  end

  def finish(exit_station)
    @journey_class.update_exit_station(exit_station)
  end

  def current_journey
    if @journey_class.entry_station.nil? ||
      @journey_class.exit_station.nil?

      @journeys << @journey_class
    else
      @journey_class = Journey.new
    end
  end

  def journeys
    @journeys.dup
#     dup() public
# Produces a shallow copy of obj—the instance variables
# of obj are copied, but not the objects they reference.
# dup copies the tainted state of obj.
  end
end
