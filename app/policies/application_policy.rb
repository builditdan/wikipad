class ApplicationPolicy
  attr_reader :user, :record, :params

  def initialize(user, record)

    @user = user
    @record = record
  
  end

  def index?
  
    true

  end

  def show?
  
    true

  end

  def create?

    user_logged_in?

  end

  def new?
   
    if user == nil
      false
    else
      true
    end
  
  end
  
  def update?

    # wiki_policy.rb is handling policy validations 
  
  end

  def edit?

    user_logged_in?
     
  end

  def destroy?
   
    if !user_logged_in?
      false
    elsif user.admin? 
       return true
    false
       false
    end

  end        
  
  
  
  def scope
    Pundit.policy_scope!(user, record.class)
  end


  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end

  private  

  def user_logged_in?
  
    if user == nil
      false
    else
      true
    end
  
  end  


end
