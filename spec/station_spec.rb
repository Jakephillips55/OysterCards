require 'station'

describe 'station' do
    it 'adds a name to station, when new object' do
      station = Station.new('a station' ,1)
      #creating a new instance of the station class
      #and valuing it to 'a station' once. 
      expect(station.name).to eq 'a station'
  end
end
