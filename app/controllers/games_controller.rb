require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @grid = ('a'..'z').to_a.shuffle[0..9]
  end

  def check?
    @answer.split("").all? { |char| @grid.count(char) >= @answer.count(char) }
  end

  def score
    @answer = params[:word]
    @words = fetch?(@answer)
    check?
  end


  def fetch?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    api_response = URI.open(url).read
    json = JSON.parse(api_response)
    json["found"]
  end
end
