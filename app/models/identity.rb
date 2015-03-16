class Identity < ActiveRecord::Base
  belongs_to :user

  has_secure_password

  validates :email, :uniqueness => true
  validates :email, :name, :presence => true
  validates :email, :format => {:with => /\A^[A-Za-z0-9_+\.]+\@([A-Za-z0-9]+\.)+[A-Za-z0-9]{2,4}\Z/, :message => "Invalid Email"}

  def self.build_user_identity(params_hash)
    identity = self.new(params_hash)
    identity.user = User.new(:name => identity.name)
    identity
  end
end
