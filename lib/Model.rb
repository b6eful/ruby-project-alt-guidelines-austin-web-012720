
class Model < ActiveRecord::Base
belongs_to :user
#has_many :stocks, through: :stock_models
has_and_belongs_to_many :stocks
require 'gnuplot'


  def make_model
    master = self.organize_data(GetRequester.new.get_stock_body)
    master_time = master[0].map{|h| (h - master[0].min)/60} # in minutes
    choices ={Open: 1, High:2 ,Low:3 ,Close:4 ,Volume:5}





    prompt = TTY::Prompt.new
    input = prompt.enum_select("Corresponding y-value for plot?", choices )

      Gnuplot.open do |gp|
        Gnuplot::Plot.new( gp ) do |plot|
          plot.terminal "svg"
          plot.output File.expand_path("../Graphs/#{self.name}_#{master[8]}.svg", __FILE__)
          plot.title  "Stock Table for #{master[8]} Time zone: #{master[7]}"
          plot.xlabel "Time in minutes. Last point is current real time value corresponding to last refreshed time: #{master[6]}"
          plot.ylabel "#{choices.key(input)} values"

          x = master_time.collect { |v| v }
          y = master[input].collect { |v| v }

          plot.data << Gnuplot::DataSet.new( [x, y] ) do |ds|
            ds.with = "linespoints"
            ds.notitle
          end
        end
      end


      puts "Created model for #{master[8]}"
      self.val = "#{choices.key(input)}"
      self.file_path = "#{self.name}_#{master[8]}.svg"
      self.save
      return
  end



  def organize_data(json_data) #Organizes data into one large array which we can pull into the make_model
      #Master array help list:

      date_time_array = [] #0th index
      open_array = [] #1st index
      high_array = [] #2nd index
      low_array = [] #3rd index
      close_array = [] #4th index
      volume_array = [] #5th index
      if json_data.nil?
        return "Program terminated"
      end
      date_refreshed = json_data.dig("Meta Data")["3. Last Refreshed"] # 6th
      time_zone = json_data.dig("Meta Data")["6. Time Zone"] #7th
      symbol =  json_data.dig("Meta Data")["2. Symbol"] #8th
      json_data.dig("Time Series (1min)").each do |k,v|

        date_time_array << Time.parse(k).strftime("%s").to_i #Unix Time
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
      master_array = [date_time_array.reverse,
        open_array.reverse,
        high_array.reverse,
        low_array.reverse,
        close_array.reverse,
        volume_array.reverse,
        date_refreshed,
        time_zone,
        symbol]
    end




end
