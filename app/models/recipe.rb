class Recipe < ActiveRecord::Base
  has_many :comments 
acts_as_rateable
end
