require 'net/http'
require 'open-uri'
require 'json'
class GetRequester
  attr_accessor :url_string
  api_key = 'IR07445BNSQ56179'
  def initialize(url_string = 'https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=')
    @url_string = url_string
  end

  other_part = '&interval=1min&outputsize=compact&apikey=IR07445BNSQ56179'
  def get_stock_body
    prompt = TTY::Prompt.new
    array = self.parse_search_results #array of search results

    searchsym  = prompt.enum_select("Choose stock number for which you want to model:\ndata is more precise for companies whose stocks are constantly changing.\n", array)
    uri = URI.parse(self.url_string + searchsym + '&interval=1min&outputsize=compact&apikey=IR07445BNSQ56179' )
    response = Net::HTTP.get_response(uri)

    return JSON.parse(response.body)

  end

  def search_for_stock #Search for stock given user input
    url_search_string = 'https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords='

    prompt = TTY::Prompt.new

    input = prompt.ask("Type your search:") do |q|
      q.required true
    end
    
    keyword_input_string = url_search_string + input +'&apikey=IR07445BNSQ56179'

    uri = URI.parse(keyword_input_string)
    search = Net::HTTP.get_response(uri)

    return search.body

  end


  def parse_search_results # returns array of best fit matches from searchbar
    best_match = self.search_for_stock
    body_parse = JSON.parse(best_match)
    array_of_matches = body_parse["bestMatches"]
    symbols = []
    i = 0
    while i < array_of_matches.length do
      array_of_matches[i].each do |k,v|
        if k == "1. symbol"
          symbols << v
        end
      end
      i += 1
    end
    return symbols

  end

end

#I can just pull the get_search_stocks bc its just a url string that defers
#the search information.
