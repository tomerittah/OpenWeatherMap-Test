require 'net/http'
require 'json'

class Weather

  # defining the getter/setter for the object
  attr_accessor :weather_data, :data

    # Constructs a Weather object.
    def initialize
      @weather_data = nil
      @data = nil
      @url = '/data/2.5/weather?'
      @host = 'api.openweathermap.org'
      @appid = '&APPID=50f4012e8c7c01a21a478a0daa960eb5'
    end

  # Returns a JSON format http GET request based on the query
  # Input - a query to the api
  # Output - The weather in the specific city, represented in JSON format data
  def getWeatherFromUrl(query)
    @data = JSON.parse(Net::HTTP.get(@host, @url + query + @appid))
    return @data
  end

  # Returns true if the parameter is a number
  # Input - a string
  # Output - true if its a number
  def checkNumericValue(str)
    Float(str) != nil rescue false
  end

  # Set the weather_data variable by quering the api using the city name
  # Input - a string represent the city name
  def setWeatherByCityName(city_name)
    weather_data = getWeatherFromUrl("q=" + city_name)
  end

  # Set the weather_data variable by quering the api using the city name and country code
  # Input - a string represent the city name and a string represent a country code
  def setWeatherByCityNameCountryCode(city_name, country_code)
    weather_data = getWeatherFromUrl("q=" + city_name + "," + country_code)
  end

  # Set the weather_data variable by quering the api using the city id
  # Input - an integer represent the city id
  def setWeatherByCityId(city_id)

    # Calling checkNumericValue function to check wheter the city_id is a number
    if checkNumericValue(city_id)
      weather_data = getWeatherFromUrl("id=" + city_id)
    end
  end

  # Set the weather_data variable by quering the api using the coordinates of the city
  # Input - an integer represent the city latitude and a an integer represent the city longitude
  def setWeatherByCoordinates(lat, lon)

    # Calling checkNumericValue function to check wheter the latitude and longitude are numberes
    if checkNumericValue(lat) && checkNumericValue(lon)
      weather_data = getWeatherFromUrl("lat=" + lat + "&lon=" + lon)
    end
  end

  # Set the weather_data variable by quering the api using the zip code and country code
  # Input - an integer represent the city zip code and a string represent the country code
  def setWeatherByZipCode(zip_code, country_code)

    # Calling checkNumericValue function to check wheter the zip code is a number
    if checkNumericValue(zip_code)
      weather_data = getWeatherFromUrl("zip=" + zip_code + "," + country_code)
    end
  end

end