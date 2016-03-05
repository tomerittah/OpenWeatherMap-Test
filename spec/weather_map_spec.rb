require 'spec_helper'
require 'json'

describe Weather do

  before :all do
    ERROR_CITY_NOT_FOUND = JSON.parse(File.read('errors/error_city_not_found.json'))
  end

  before :each do
    @weather = Weather.new
  end

  describe "#new" do
    it "takes no parameters and returns a Weather object" do
      expect(@weather).to be_a Weather
    end

    it "should raise ArgumentError for wrong object initializing" do
        expect(lambda {Weather.new "test"}).to raise_error(ArgumentError)
    end
  end

  describe "#setWeatherByCityName" do
    it "query api with city name and should return the correct city id" do
      expect(@weather.setWeatherByCityName("London")['id']).to eql (2643743)
    end

    it "query api with made up city name and should return an error" do
      expect(@weather.setWeatherByCityName("MyMadeUpCity")['cod']).to eql(ERROR_CITY_NOT_FOUND['cod'])
    end

    # This is a deliberately failed test
    # There is no such city - "123" but for some reason it links me to a city called 'Tapa vald'
    it "query api with numbers instead of city name and I excpect it to return an error" do
      expect(@weather.setWeatherByCityName("123")['cod']).to eql(ERROR_CITY_NOT_FOUND['cod'])
    end
  end

  describe "#setWeatherByCityNameCountryCode" do
    it "query api with city name and country code and should return the correct city id" do
      expect(@weather.setWeatherByCityNameCountryCode("Paris","FR")['id']).to eql (2988507)
    end

    # This is a deliberately failed test
    # I intentionally switched the country code and the city name position and expected the api to return an error
    # For some reason it links me to "West Jerusalem"
    it "query api with switched values of city name and country code and should return an error" do
      expect(@weather.setWeatherByCityNameCountryCode("IL","Jerusalem")['cod']).to eql(ERROR_CITY_NOT_FOUND['cod'])
    end

    # This is a deliberately failed test
    # I intentionally switched the country code and the city name position, and wrote wrong country code
    # Expected the api to return an error
    # For some reason it links me to "Flines-les-Mortagne"
    it "query api with switched values of city name and wrong country code and should return an error" do
      expect(@weather.setWeatherByCityNameCountryCode("FR","Jerusalem")['cod']).to eql(ERROR_CITY_NOT_FOUND['cod'])
    end

    # This is a deliberately failed test
    # I intentionally wrote the wrong country code for the city name and expected the api to return an error
    it "query api with city name and wrong country code and should return an error" do
      expect(@weather.setWeatherByCityNameCountryCode("Milano","IL")['cod']).to eql(ERROR_CITY_NOT_FOUND['cod'])
    end

    # This is a deliberately failed test
    # I intentionally wrote random numbers as city name and country code and excpected the api to return an error
    # For some reason it links me to a city called "Brockton"
    it "query api with random numbers for city name and country code and should return an error" do
      expect(@weather.setWeatherByCityNameCountryCode("321","123")['cod']).to eql(ERROR_CITY_NOT_FOUND['cod'])
    end
  end

  describe "#setWeatherByCityId" do
    it "query api with city id and should return the correcy city name" do
      expect(@weather.setWeatherByCityId("294640")['name']).to eql('State of Israel')
    end

    it "gets wrong city id and should not find the city" do
      expect(@weather.setWeatherByCityId("123321")['cod']).to eql(ERROR_CITY_NOT_FOUND['cod'])
    end

    it "gets negetive city id and should return an error" do
      expect(@weather.setWeatherByCityId("-294640")['cod']).to eql(ERROR_CITY_NOT_FOUND['cod'])
    end

    it "gets a string represent a city id instead of a number and should return an error" do
      expect(@weather.setWeatherByCityId("OneHundredAndTwentyFive")['cod']).to eql(ERROR_CITY_NOT_FOUND['cod'])
    end
  end

  describe "#setWeatherByCoordinates" do
    it "query api with city coordinate and should return the correct city" do
      expect(@weather.setWeatherByCoordinates("48.856461","2.35236")['name']).to eql('Saint-Merri')
    end

    it "gets wrong coordinates and should not find a city matches the coordinates" do
      expect(@weather.setWeatherByCoordinates("123123123","123123123")['cod']).to eql ERROR_CITY_NOT_FOUND['cod']
    end

    it "gets a string instead of pair of numberes represent latitude and longitude and should return an error" do
      expect(@weather.setWeatherByCoordinates("one","three")['cod']).to eql(ERROR_CITY_NOT_FOUND['cod'])
    end
  end

  describe "#setWeatherByZipCode" do

    # This test randomly fails - with different APPID it works
    it "query api with city zip code and country code and should return the correct city name" do
      expect(@weather.setWeatherByZipCode("94041","us")['name']).to eql('Mountain View')
    end

    # This test randomly fails
    # I intentionally switched the zip code and country code and expected the api to return an error
    it "query api with switched values of city zip code and country code and should return an error" do
      expect(@weather.setWeatherByZipCode("us","94041")['cod']).to eql(ERROR_CITY_NOT_FOUND['cod'])
    end

    # This is a deliberately failed test
    # I intentionally wrote string instead of valid zip code and expected the api to return an error
    it "gets a string represent a zip code instead of a number and should return an error code" do
      expect(@weather.setWeatherByZipCode("TenHundredesAndFifty","US")['cod']).to eql(ERROR_CITY_NOT_FOUND['cod'])
    end
  end

end

