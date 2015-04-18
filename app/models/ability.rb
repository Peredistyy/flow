class Ability

  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    alias_action :create, :read, :update, :destroy, :to => :crud

    can :crud, Project, :user_id => user.id
    can :crud, Task, :user_id => user.id
    can :crud, Comment, :user_id => user.id
  end

end
