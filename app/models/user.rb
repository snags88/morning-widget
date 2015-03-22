class User < ActiveRecord::Base
  has_many :tasks, dependent: :destroy
  has_many :user_subways
  has_many :subways, through: :user_subways

  has_many :identities, dependent: :destroy

  validates :zipcode, :format => {:with => /\d{5}/, :message => "invalid zipcode format" }, numericality: { :only_integer => true }, :unless => Proc.new { |a| a.zipcode.blank? }

  def ordered_subways
    filter = self.subways.pluck(:id)
    Subway.where(:id => filter).order(:id).pluck(:name)
  end

  def ordered_tasks
    filter = self.tasks.pluck(:id)
    Task.where(:id => filter).order(:created_at => "DESC")
  end

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
