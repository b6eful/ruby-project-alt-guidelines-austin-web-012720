class Stock < ActiveRecord::Base
  has_many :models, through: :stock_models
end
