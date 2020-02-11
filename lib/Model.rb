require_relative './GetRequests.rb'
class Model < GetRequester
require 'gnuplot'



  def make_model
    master = self.organize_data(GetRequester.new.get_stock_body)

    value_pair_array = []
    i = 0
    while i < master[0].length do
      pair = []

      pair[0] = master[0][i]
      pair[1] = master[1][i]
      value_pair_array << pair
        i += 1
      end
      Gnuplot.open do |gp|
        Gnuplot::Plot.new( gp ) do |plot|

          plot.title  "Stock Table"
          plot.xlabel "Time"
          plot.ylabel "Open values"

          x = master[0].collect { |v| v }
          y = master[1].collect { |v| v }

          plot.data << Gnuplot::DataSet.new( [x, y] ) do |ds|
            ds.with = "linespoints"
            ds.notitle
          end
        end
      end




  end

  def value_pairs # This will take from master_array and make vlaue pairs for each index

  end

  def organize_data(json_data) #Organizes data into one large array which we can pull into the make_model
      #Master array help list:

      date_time_array = [] #0th index
      open_array = [] #1st index
      high_array = [] #2nd index
      low_array = [] #3rd index
      close_array = [] #4th index
      volume_array = [] #5th index
      json_data.dig("Time Series (1min)").each do |k,v|
        date_time_array << Time.parse(k).to_f
        v.each_pair do |key,val|
          if key == "1. open"
            open_array << val.to_f
          elsif key == "2. high"
            high_array << val.to_f
          elsif key == "3. low"
            low_array << val.to_f
          elsif key == "4. close"
            close_array << val.to_f
          elsif key == "5. volume"
            volume_array << val.to_i
          end
        end
      end
      master_array = [date_time_array.reverse,open_array.reverse,high_array.reverse,low_array.reverse,close_array.reverse,volume_array.reverse]
    end




end
