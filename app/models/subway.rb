class Subway < ActiveRecord::Base
  has_many :user_subways
  has_many :users, through: :user_subways

  validates :name, :presence => true, inclusion: {in: ["123","456","7","ACE","BDFM","G", "JZ", "L", "NQR", "S"]}
end
