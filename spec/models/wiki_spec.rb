require 'rails_helper'
include Devise::TestHelpers


RSpec.describe Wiki, type: :model do
  let(:my_user) {User.create!(name: "Bill Smith", email: "bill@example.com", password: "password", confirmed_at: Time.now)}
  let(:my_wiki) {Wiki.create!(title: "My first wiki", body: " This is some cool text to add to my wiki", private: false, user_id: my_user.id)}

  #let(:wiki) {Wiki.create!(title: "My first wiki", body: " This is some cool text to add to my wiki", user_id: 1, private: false)}

  describe "attributes" do

      it "should respond to title" do
        expect(my_wiki).to respond_to(:title)
      end

      it "should repsond to body" do
        expect(my_wiki).to respond_to(:body)
      end

      it "should respond to private" do
        expect(my_wiki).to respond_to(:private)
      end

  end


end
