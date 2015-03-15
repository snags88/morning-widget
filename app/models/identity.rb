class Identity < OmniAuth::Identity::Models::ActiveRecord
  has_one :user

  validates :email, :uniqueness => true
  validates :email, :name, :presence => true
  validates :email, :format => {:with => /\A^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\Z/, :message => "Invalid Email"}

  def self.build_user_identity(params_hash)
    identity = self.new(params_hash)
    user = User.create(:name => identity.name)
    identity.user_id = user.id
    identity
  end
end
