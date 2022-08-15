require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = []
    @letters << ("A".."Z").to_a.sample until @letters.size == 10
  end

  def score
    @letters
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    my_data_url = URI.open(url).read
    my_data_url_into_hash = JSON.parse(my_data_url)
    @response = my_data_url_into_hash["found"]
  end

end
