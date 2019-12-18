class Journey
attr_reader :entry_station, :exit_station

MIN_FARE = 3
PENALTY_FARE = 6

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def update_entry_station(entry_station)
    @entry_station = entry_station
  end

  def update_exit_station(exit_station)
    @exit_station = exit_station
  end

  def fare
    @entry_station && @exit_station ? MIN_FARE : PENALTY_FARE

    # also orignally had this as !entry_station or !!exit_station - this is redunant code
    # as nil values defualt to false so they are already boolean. 
# orignally did this true false with (and) thinking it was the same as && :(
# and is the same as && but with lower precedence. They both use short-circuit evaluation.
# WARNING: and even has lower precedence than = so you'll usually want to avoid and.
# An example when and should be used can be found in the Rails Guide under "Avoiding Double Render Errors".
  end
end
