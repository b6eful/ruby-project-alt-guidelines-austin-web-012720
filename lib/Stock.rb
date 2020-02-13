class Stock < ActiveRecord::Base
  has_many :models, through: :stock_models
  validates :symbol, uniqueness: true
end
