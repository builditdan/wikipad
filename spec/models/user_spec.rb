require 'rails_helper'
include RandomData
include Devise::TestHelpers

RSpec.describe User, type: :model do
  # let(:user) {create(:user)} => use when you implement factory girl

  let(:my_user) {User.create!(name: "Bill Smith", email: "bill@example.com", password: "password", confirmed_at: Time.now, role: :standard)}
  

   it { should have_many(:wikis)}

   # Shoulda tests for name
   it { should validate_presence_of(:name) }
   it { should validate_length_of(:name).is_at_least(1) }

   # Shoulda tests for email
   it { should validate_presence_of(:email) }
   it { should validate_uniqueness_of(:email) }
   it { should validate_length_of(:email).is_at_least(3) }
   it { should allow_value("user@bloccit.com").for(:email) }
   it { should_not allow_value("userbloccit.com").for(:email) }

   # Shoulda tests for password
   it { should validate_presence_of(:password) }
   it { should validate_length_of(:password).is_at_least(6) }




  describe "attributes" do
     it "should respond to role" do
       expect(my_user).to respond_to(:role)
     end

     it "should respond to admin?" do
       expect(my_user).to respond_to(:admin?)
     end

     it "should respond to standard?" do
       expect(my_user).to respond_to(:standard?)
     end


     it "should my_user to premium?" do
       expect(my_user).to respond_to(:premium?)
     end

     it "should respond to email" do
       expect(my_user).to respond_to(:email)
     end
  end




   describe "invalid user" do

    let(:user_with_lowercase_name) { User.create!(name: "daniel ediwn schutte", email: "user@bloccit.com", password: "mypassword", confirmed_at: Time.now) }
    let(:user_with_invalid_name) { build(:user, name: "", confirmed_at: Time.now) }
    let(:user_with_invalid_email) { build(:user, email: "", confirmed_at: Time.now) }
    let(:user_with_invalid_email_format) { build(:user, email: "invalid_format", confirmed_at: Time.now) }

	   # could have used a let with a .new and then an expect with a .save!
    it "should be an user name where first letters are capitalized" do
      expect(user_with_lowercase_name.name).to eq("Daniel Ediwn Schutte")
    end

    it "should be an invalid user due to blank name" do
        expect(user_with_invalid_name).to_not be_valid
    end

    it "should be an invalid user due to blank email" do
      expect(user_with_invalid_email).to_not be_valid
    end

    it "should be an invalid user due to incorrectly formatted email address" do
      expect(user_with_invalid_email_format).to_not be_valid
    end
   end


   describe "roles" do

     it "should be standard by default" do
       expect(my_user.role).to eql("standard")
     end

     context "standard user" do
       it "should return ture for #standard?" do
         expect(my_user.standard?).to be_truthy
       end

       it "should return false for @admin?" do
         expect(my_user.admin?).to be_falsey
       end
     end

   end


   context "admin user" do
       before do
         my_user.admin!
       end

       it "should return false for @standard?" do
         expect(my_user.standard?).to be_falsey
       end

       it "should return true for @admin?" do
         expect(my_user.admin?).to be_truthy
       end
    end

    context "premium user" do
       before do
         my_user.premium!
       end

       it "should return false for @premium?" do
         expect(my_user.admin?).to be_falsey
       end

       it "should return true for @moderator?" do
         expect(my_user.premium?).to be_truthy
       end
    end



    describe ".avatar_url" do
     let (:known_user) { create(:user, name: "Mr Bloc Head", password: "Password", email: "blochead@bloc.io", confirmed_at: Time.now)}

     it ":returns the proper Gravatar url for a know email entity" do
       expected_gravatar = "http://gravatar.com/avatar/bb6d1172212c180cfbdb7039129d7b03.png?s=48"
       expect(known_user.avatar_url(48)).to eq(expected_gravatar)
     end
    end

	  describe "#generate_auth_token" do
      before do
         my_user.confirm
      end
      it "create a token" do
         # need to ask Jon how to generate a token in rspec with Devise
        # expect(my_user.confirmation_token).to_not be_nil
      end
  	end

   

#### end rspec
end
