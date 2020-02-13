class StockModel < ActiveRecord::Base
  belongs_to :stock
  belongs_to :model

end
