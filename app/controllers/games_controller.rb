require "open-uri"
class GamesController < ApplicationController

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  # The new action will be used to display a new random grid and a form.
  # The form will be submitted (with POST) to the score action.
  def score
  @word = params[:word]
  @letters = params[:letter]
  @included = included?(@word, @letters)

  if english_word?(@word)
    @message = "it is an english word!"
  else
    @message = "IT IS NOT AN ENGLISH WORD"
  end
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= @letters.count(letter) }
  end


  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    result = URI.open(url).read
    dictionary_hash = JSON.parse(result)
    dictionary_hash["found"]
  end
end
