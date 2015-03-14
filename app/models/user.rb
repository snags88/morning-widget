class User < ActiveRecord::Base
  has_many :lists
  has_many :tasks, through: :lists
  has_many :user_subways
  has_many :subways, through: :user_subways

  validates :email, :name, :zipcode, :presence => true
  validates :zipcode, length: { is: 5 }, numericality: { :only_integer => true }
  validates :email, :uniqueness => true

  has_secure_password
end
