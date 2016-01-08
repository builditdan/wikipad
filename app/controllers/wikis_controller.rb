include SessionsHelper
class WikisController < ApplicationController


  #before_action :require_sign_in, except: :show
  #before_action :authorize_user, except: [:show, :new, :create]
  #before_action :authorize_moderator, except: [:show, :new,]

    def index
      @wikis = Wiki.all

    end

    def show
      @wiki = Wiki.find(params[:id])
    end

    def new
      @wiki = Wiki.new
    end

    def edit
      @wiki = Wiki.find(params[:id])
    end

    def create
      @wiki = Wiki.new(wiki_params)
      @wiki.user_id = current_user.id
      if @wiki.save
        redirect_to @wiki, notice: "Wiki was saved successfully."
      else
        flash.now[:alert] = "There was an error saving the wiki. Please try again."
        render :new
      end
    end


    def update
      @wiki = Wiki.find(params[:id])
      @wiki.assign_attributes(wiki_params)
      @wiki.user_id = current_user.id
      if @wiki.save
        redirect_to @wiki, notice: "Wiki was updated successfully."
      else
        flash.now[:alert] = "There was an error updating the wiki. Please try again."
        render :new
      end
    end

    def destroy
      @wiki = Wiki.find(params[:id])
      if @wiki.destroy
        flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
        redirect_to action: :index
      else
        flash.now[:alert] = "There was an error deleting the wiki."
        render :show
      end
    end


    private

      def wiki_params
        params.require(:wiki).permit(:title, :body, :private, :user_id)
      end


end
