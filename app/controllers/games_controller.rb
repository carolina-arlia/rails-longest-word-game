require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = []
    @letters << ("A".."Z").to_a.sample(10)
  end

  def score
    @word = params[:word].upcase
    @word_array = params[:word].upcase.split("")
    @letters = params[:letters].split
    @included = included?(@word_array, @letters)
    @english_word = english_word?(@word)
  end

  private

  def included?(word_array, letters)
    letters_matched = []

    word_array.each do |letter|
      if letters.include?(letter)
        letters_matched << letter
        letters.delete_at(letters.index(letter))
      end
    end
    letters_matched.size == word_array.size
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    my_data_url = URI.open(url).read
    data_json = JSON.parse(my_data_url)
    data_json["found"]
  end
end
