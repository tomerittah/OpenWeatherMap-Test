require 'spec_helper'

describe Weather do

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
    it "query api with city name and should not return a nil value" do
      expect(@weather.setWeatherByCityName("London")).not_to be_nil
    end
  end

  describe "#setWeatherByCityNameCountryCode" do
    it "query api with city name and country code and should not return nil value" do
      expect(@weather.setWeatherByCityNameCountryCode("London","uk")).not_to be_nil
    end
  end

  describe "#setWeatherByCityId" do
    it "query api with city id and should  not return nil value" do
      expect(@weather.setWeatherByCityId("2172797")).not_to be_nil
    end

    it "gets wrong city id and should not find the city" do
      expect(@weather.setWeatherByCityId("123321")).to_json equal '{"cod":"404","message":"Error: Not found city"}'
    end

    it "gets a string instead of a number and returns nil" do
      expect(@weather.setWeatherByCityId("test")).to be_nil
    end
  end

  describe "#setWeatherByCoordinates" do
    it "query api with city coordinate and should not return nil value" do
      expect(@weather.setWeatherByCoordinates("35","139")).not_to be_nil
    end

    it "should get wrong coordinates and not find the city" do
      expect(@weather.setWeatherByCoordinates("1","-1")).to_json equal '{"cod":"404","message":"Error: Not found city"}'
    end

    it "gets a string instead of a number and returns nil value" do
      expect(@weather.setWeatherByCoordinates("one","three")).to be_nil
    end
  end

  describe "#setWeatherByZipCode" do
    it "query api with city zip code and should not return nil value" do
      expect(@weather.setWeatherByZipCode("94040","us")).not_to be_nil
    end

    it "gets a string instead of a number and returns nil value" do
      expect(@weather.setWeatherByZipCode("test","us")).to be_nil
    end
  end

end

