#include SessionsHelper
class WikisController < ApplicationController


  #before_action :require_sign_in, except: :show
  #before_action :authorize_user, except: [:show, :new, :create]
  #before_action :authorize_moderator, except: [:show, :new,]

    def index
      #@wikis = Wiki.show_by_role(current_user)
      @wikis = policy_scope(Wiki)
      #authorize @wikis
    end

    def show
      @wiki = Wiki.find(params[:id])
      authorize @wiki
    end

    def new
      @wiki = Wiki.new
      authorize @wiki
    end

    def edit
      user_data = Struct.new(:user_id, :name, :email, :collaborator)
      @wiki = Wiki.find(params[:id])
      authorize @wiki
      @collaborator_list = []
      i = 0
      User.all.each do |u|
         @collaborator_list[i] = user_data.new
         @collaborator_list[i].user_id = u.id
         @collaborator_list[i].name = u.name
         @collaborator_list[i].email = u.email
         if Collaborator.find_by(user_id: u.id, wiki_id: @wiki.id)
            @collaborator_list[i].collaborator = true
          else
            @collaborator_list[i].collaborator = false
         end
         i += 1
      end

    end


    def create
      @wiki = Wiki.new(wiki_params)
      @wiki.user_id = current_user.id
      authorize @wiki
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

      authorize @wiki
      if @wiki.save
        selected_colabs = params[:selected_collaborators]
        if !selected_colabs.blank?
          Collaborator.delete_all(wiki_id: @wiki.id)

          selected_colabs.each { |c|
              new_colaborator = Collaborator.new
              new_colaborator.user_id = c
              new_colaborator.wiki_id = @wiki.id
              new_colaborator.save # add for a failure check
          }
        end
        redirect_to @wiki, notice: "Wiki was updated successfully."
      else
        flash.now[:alert] = "There was an error updating the wiki. Please try again."
        render :new
      end
    end

    def destroy
      @wiki = Wiki.find(params[:id])
      authorize @wiki
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
