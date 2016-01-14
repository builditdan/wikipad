include ApplicationHelper

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


before_filter :configure_permitted_parameters, if: :devise_controller?
before_action :authenticate_user!, except: [:index, :show]


     protected

     	def configure_permitted_parameters
        	devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation ) }
        	devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password) }
     	end

     private

    	def user_not_authorized
    		flash[:alert] = "You are not authorized to perform this action."
    		redirect_to(root_path)
  		end

end
