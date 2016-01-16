class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki, :params

def edit?


  if user.blank?
    false
  elsif record.private? && (user.id != record.user_id && !user.admin? && !Collaborator.find_by(user_id: user.id, wiki_id: record.id))
    false
  else
    true
  end


end

def show?

  if user.blank? && record.private?
    false
  elsif record.private? && (user.id != record.user_id && !user.admin? && !Collaborator.find_by(user_id: user.id, wiki_id: record.id))
    false
  else
    true
  end


end


 def update?

    if record.private_changed?
      if user.admin?
        true
      elsif user.premium? && record.user_id == user.id
        true
      else
        false
      end
   else
      true
   end

 end

 class Scope
     attr_reader :user, :scope

     def initialize(user, scope)
       @user = user
       @scope = scope
     end

     def resolve

       wikis = []
       if !user.blank? && user.role == 'admin'
         wikis = scope.all # if the user is an admin, show them all the wikis
       elsif !user.blank? && user.role == 'premium'
         all_wikis = scope.all
         all_wikis.each do |wiki|
           if wiki.collaborators.find_by(user_id: user.id)
             is_collaborator = true
           else
             is_collaborator = false
           end
           # wiki.collaborators.include? check does not work on activerecords
           if !wiki.private? || wiki.user_id == user.id || is_collaborator
             wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
           end
         end

       else # this is the lowly standard user
         all_wikis = scope.all
         wikis = []
         all_wikis.each do |wiki|
           if !wiki.private? || wiki.collaborators.include?(user)
             wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
           end
         end
       end
       wikis # return the wikis array we've built up
     end
   end


 end
