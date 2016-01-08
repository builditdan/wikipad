module SessionsHelper

def create_session(user)
  session[:user_id] = user.id

end

def destroy_session(user)
  session[:user_id] = nil
end

def current_user
  User.find_by(id: session[:user_id])
end


def create_it


  user = User.find_by(email: params[:session][:email].downcase)

  if user && user.authenticate(params[:session][:password])
    create_session user
    flash[:notice] = "Welcome, #{user.name}!"
    redirect_to root_path
  else
    flash.now[:alert] = "Invalid email/passowrd combination"
    render :new
  end

end

end
