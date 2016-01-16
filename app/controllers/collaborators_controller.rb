class CollaboratorsController < ApplicationController
  def show
    
  end

  def create # POST params[:collaborator][:wiki_id] and :user_id
  end

  def destroy # DELETE id is Collaborator id
  end

### you can refactor this using your belong to models
  def add_user_to_wiki
    byebug
      collaborator = Collaborator.new
      collaborator.user_id = params[:user_id]
      collaborator.wiki_id = params[:wiki_id]
      collaborator.save
      redirect_to :back
  end

  def remove_user_from_wiki #(user_id, wiki_id)
      #Post.delete_all("person_id = 5 AND (category = 'Something' OR category = 'Else')")
      Collaborator.delete(user_id: params[:user_id], wiki_id: params[:wiki_id])
      redirect_to :back
  end


end
