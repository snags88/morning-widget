require 'rails_helper'

RSpec.describe Identity, :type => :model do

  context "new identity" do
    context "validation:" do
      it "has a valid factory" do
        expect(create(:identity)).to be_valid
      end

      it "instanciates a new identity" do
        expect(create(:identity)).to be_a(Identity)
      end

      it "is invalid without an email" do
        identity = build(:identity, :email => nil)
        expect(identity).not_to be_valid
      end

      it "is invalid without a name" do
        identity = build(:identity, :name => nil)
        expect(identity).not_to be_valid
      end

      it "is invalid without a password" do
        identity = build(:identity, :password => nil)
        expect(identity).not_to be_valid
      end

      it "is invalid without a matching password confirmation" do
        identity = build(:identity, :password_confirmation => "not my password")
        expect(identity).not_to be_valid
      end

      it "is invalid without a unique email" do
        identity1 = create(:identity)
        identity2 = build(:identity, :email => identity1.email)
        expect(identity2).not_to be_valid
      end

      it "is invalid without a correct email format" do
        identity = build(:identity, :email => "@noname.com")
        expect(identity).not_to be_valid
        identity = build(:identity, :email => "email")
        expect(identity).not_to be_valid
      end
    end

    context "builds a new user" do
      context "::build_user_identity" do
        let(:identity){
          params = attributes_for(:identity)
          Identity.build_user_identity(params)
        }

        it "returns a new identity" do
          expect(identity).to be_a(Identity)
        end

        it "instanciates a new user" do
          expect(identity.user).to be_a(User)
        end

        it "instanciates a new user with the same name" do
          user = identity.user
          expect(identity.name).to eq(user.name)
        end

        it "persists identity and user on save" do
          identity.save
          expect(identity).to eq(Identity.last)
          expect(identity.user).to eq(User.last)
        end
      end
    end
  end

end