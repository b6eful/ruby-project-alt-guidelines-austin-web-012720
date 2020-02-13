class User < ActiveRecord::Base

has_many :models
has_many :models, through: :stocks

end
