class User < ActiveRecord::Base
  has_many :lists
  has_many :tasks, through: :lists
  has_many :user_subways
  has_many :subways, through: :user_subways

  validates :zipcode, length: { is: 5 }, numericality: { :only_integer => true }, :unless => Proc.new { |a| a.zipcode.blank? }

  def self.set_user(auth)
    User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.token = auth["credentials"]["token"]
      user.secret = auth["credentials"]["secret"]
    end
  end

end
