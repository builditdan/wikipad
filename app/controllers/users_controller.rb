class UsersController < ApplicationController


  def show
    @user = current_user
      #@posts = @user.posts.visible_to(current_user)
  end


  #### end class
  end
