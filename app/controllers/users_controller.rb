class UsersController < ApplicationController


  def show
    @user = current_user
      #@posts = @user.posts.visible_to(current_user)
  end

  def new
  	end
  	
  #### end class
  end
