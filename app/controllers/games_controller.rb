require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
    # @letters = ['a', 'p', 'l', 'e']
  end

  def score
    @letters = params[:letters].split
    @word = params[:word].downcase
    @check_letters = check_letters?(@word, @letters)
    @dictionary = dictionary?(@word)
  end

  # retorna se a palavra é true ou false
  def dictionary?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    results = URI.open(url).read
    data = JSON.parse(results)
    data['found']
  end

  def check_letters?(word, letters)
    # word.chars.all? { |l| letters.include?(l) }
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end
end
