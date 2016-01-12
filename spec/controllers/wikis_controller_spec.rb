require 'rails_helper'
include RandomData
include Devise::TestHelpers


RSpec.describe WikisController, type: :controller do
  let(:my_user) {User.create!(name: "Bill Smith", email: "bill@example.com", password: "password", confirmed_at: Time.now)}
  let(:my_wiki) {Wiki.create!(title: "My first wiki", body: " This is some cool text to add to my wiki", private: false, user_id: my_user.id)}

  context "standard user" do

  #Sign in the new user and confirm there email response
  before do
    sign_in my_user
    # my_user.confirm ==> not needed since I update the confirmed_at field
  end

  describe "GET show" do

    it "returns http success" do
      get :show, id: my_wiki.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, id: my_wiki.id
      expect(response).to render_template :show
    end

    it "assigns my_wiki to @wiki" do
      get :show, id: my_wiki.id
      expect(assigns(:wiki)).to eq(my_wiki)
    end
  end

  describe "GET new" do
    it "returns http redirect" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

    it "instantiates @wiki" do
      get :new
      expect(assigns(:wiki)).not_to be_nil
    end
  end

  describe "POST create" do
    it "increases the number of Wikis by 1" do
      expect{ post :create, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph} }.to change(Wiki,:count).by(1)
    end

    it "assigns the new wiki to @wiki" do
      post :create, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(assigns(:wiki)).to eq Wiki.last
    end

    it "redirects to the new wiki" do
      post :create, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(response).to redirect_to Wiki.last
    end
  end

  describe "GET edit" do
    it "returns http redirect" do
      get :edit, id: my_wiki.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT update" do
    it "returns http redirect" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body}
      expect(response).to redirect_to my_wiki
    end
  end

  describe "DELETE destroy" do
   
    it "returns http redirect" do
       #can only be done by admin
      my_user.admin!
      delete :destroy, {id: my_wiki.id}
      expect(response).to redirect_to wikis_path
    end
  end

 end


#### end rspec
end
