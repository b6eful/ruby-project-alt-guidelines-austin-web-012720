class Stock < ActiveRecord::Base
  has_and_belongs_to_many :models
  #has_many :models, through: :stock_models
  validates :symbol, uniqueness: true
end
