class Subway < ActiveRecord::Base
  has_many :user_subways
  has_many :users, through: :user_subways
end
