require 'net/http'
require 'open-uri'
require 'json'
class GetRequester
  attr_accessor :url_string
  api_key = 'IR07445BNSQ56179'
  def initialize(url_string = 'https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=')
    @url_string = url_string
  end


  def get_stock_body
    prompt = TTY::Prompt.new

    string_prompt = "Choose stock number for which you want to model:\ndata is more precise for companies whose stocks are constantly changing.\n"
    array = self.parse_search_results
    searchsym = self.search_check(array,string_prompt)
     while  ! array.include?(searchsym) do
       array = self.parse_search_results #array of search results
       searchsym = self.search_check(array,string_prompt)
     end

      uri = URI.parse(self.url_string + searchsym + '&interval=1min&outputsize=compact&apikey=IR07445BNSQ56179' )
      response = Net::HTTP.get_response(uri)

      Stock.create(symbol: "#{searchsym}")
      
      return JSON.parse(response.body)
  end

  def search_check(array, string_prompt)
    prompt = TTY::Prompt.new
    if array.empty?
      searchsym = 'Search again'
    else
      searchsym  = prompt.enum_select(string_prompt, active_color: :blue) do |menu|
        menu.choice array[0]
        menu.choice array[1]
        menu.choice array[2]
        menu.choice 'Search again'
      end
    end
    return searchsym
  end







  def search_for_stock #Search for stock given user input
    url_search_string = 'https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords='

    prompt = TTY::Prompt.new

    input = prompt.ask("Type your search:", active_color: :blue) do |q|
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
