require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
    # or you can use @letters = Array.new(10)
  end

  def score
    @letters = params[:letters].split
    @word = params[:word].upcase
    @valid_word = valid_word?(@word, @letters)
    @english_word = english_word?(@word)
    raise
  end

  private

  # method to check to see if it exist in the grid and does it have the right amount of characters
  def valid_word?(word, letters)
    word.chars.all? do |letter| # here we are breaking up our word into letters
      word.count(letter) <= letters.count(letter) # is the count of each individual letter less than or equal to the count in the letters array
    end
  end

  # method to check if it's an english word
  # use the API to perform checks on our word
  def english_word?
    response = URI.open("https://dictionary.lewagon.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
