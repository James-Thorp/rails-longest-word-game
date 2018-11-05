require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    letters = ("A".."Z").to_a
    @size = 10
    @letters = Array.new(@size) { letters.sample }
  end

def score
  @guess = params[:guess]

    if letter_checker?(@guess) && word_checker?(@guess)
      @total = @guess.length
    else
      @total = 0
    end
end

def letter_checker?(attempt)
# attempt = attempt.split("")
@letters = params[:letters]
  attempt.upcase.split("").all? do |letter|
    attempt.upcase.split("").count(letter) <= @letters.count(letter)
  end
end

def word_checker?(attempt)
  file_path = open("https://wagon-dictionary.herokuapp.com/#{attempt}")
  word_checker = JSON.parse(file_path.read)
  word_checker["found"]
end
end
