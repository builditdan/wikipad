require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end

RSpec.describe SessionsHelper, type: :helper do
=begin
  def create_session(user)
     session[:user_id] = user.id
  end


  def destroy_session(user)
    session[:user_id] = nil
  end

 def current_user
   User.find_by(id: session[:user_id])
 end
=end
end
