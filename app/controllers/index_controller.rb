class IndexController < ApplicationController
  def index
    cities = Cities.cities_in_country('BO')
    puts cities
  end
end
