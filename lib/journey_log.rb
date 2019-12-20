require_relative 'journey.rb'
class JourneyLog

attr_reader :journey_class, :journeys
#confused as to why I need entry_station / exit_station @'s here as they are defined
#in journey.rb so why when calling the class here does the code break if they
#are not included.

  def initialize(journey_class = Journey.new)
    @journey_class = journey_class
    @journeys = []
  end

  def start(entry_station)
    @journey_class.update_entry_station(entry_station)
    #calls the update_entry_station with args entry_station
    #on the the @journey_class
  end

  def finish(exit_station)
    @journey_class.update_exit_station(exit_station)
    add_to_journey
    @journey_class.fare 
  end

  def current_journey
    if @journey_class.entry_station.nil? ||
      @journey_class.exit_station.nil?
  #     #if either entry_station or exit_station == nil push journey_class
  #     #into journeys otherwise create a new instance of journey in journey_class
      is_in_journey
  #     @journeys << @journey_class
    else
      @journey_class = Journey.new
    end
  end

  def is_in_journey
      @journey_class.entry_station != true

    end

  def journeys
    @journeys.dup
#     dup() public
# Produces a shallow copy of obj—the instance variables
# of obj are copied, but not the objects they reference.
# dup copies the tainted state of obj.
  end

  def add_to_journey
    @journeys << @journey_class
  end

  def reset_journey
    @journey_class = Journey.new
  end
end
