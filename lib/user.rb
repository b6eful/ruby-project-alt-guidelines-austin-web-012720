class User < ActiveRecord::Base

has_many :models 
validates :name, uniqueness: true

end
