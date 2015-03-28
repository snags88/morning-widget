class UserSubway < ActiveRecord::Base
  belongs_to :user
  belongs_to :subway

  validates :user, :subway, :presence => true
end
