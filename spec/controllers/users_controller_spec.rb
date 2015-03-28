require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  let(:user){create(:user)}

  describe "blocks unauthenticated access" do
    it "redirects the user to the homepage" do
      get :show, id: user
      expect(response).to redirect_to(root_path)
    end
  end

  describe "allow authenticated access" do
    before(:each) do
      allow(controller).to receive(:current_user) {user}
    end

    describe "GET #show" do
      before {get :show, id: user}

      it "assigns the requested user to @user" do
        expect(assigns(:user)).to eq(user)
      end
      it "responds with success" do
        expect(response).to have_http_status(200)
      end
      it "renders the #show view" do
        expect(response).to render_template("show")
      end

    end

    describe "GET #edit" do
      before {get :edit, id: user}

      it "assigns the requested user to @user" do
        expect(assigns(:user)).to eq(user)
      end
      it "responds with success" do
        expect(response).to have_http_status(200)
      end
      it "renders the #edit view" do
        expect(response).to render_template("edit")
      end
    end

    describe "PUT #update" do
      context "with any request" do
        it "locates the correct user" do
          put :update, id: user, user: attributes_for(:user)
          expect(assigns(:user)).to eq(user)
        end
      end

      context "with valid attributes" do
        before(:each) {put :update, id: user, user: attributes_for(:user, :name => "Test User", :zipcode => 12345)}

        it "changes the user attributes" do
          original_name, original_zipcode = user.name, user.zipcode
          user.reload
          expect(user.name).not_to eq(original_name)
          expect(user.zipcode).not_to eq(original_zipcode)
        end
        it "redirects to the user dashboard" do
          expect(response).to redirect_to(dashboard_path)
        end
      end

      context "with invalid attributes" do
        before(:each) {put :update, id: user, user: attributes_for(:invalid_user)}

        it "does not change the user attributes" do
          original_name, original_zipcode = user.name, user.zipcode
          user.reload
          expect(user.name).to eq(original_name)
          expect(user.zipcode).to eq(original_zipcode)
        end

        it "re-renders the edit template" do
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "deletes the user" do
        delete :destroy, id: user
        expect{User.find(user.id)}.to raise_error
      end

      it "redirects to login" do
        delete :destroy, id: user
        expect(response).to redirect_to(root_path)
      end
    end
  end

end