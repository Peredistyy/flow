class Ability

  include CanCan::Ability

  def initialize(user)
    unless user.nil?
      can [:read, :create, :update, :destroy], Project, :user_id => user.id
      can [:read, :create, :update, :destroy], Task, :user_id => user.id
    end
  end

end
