class Ability
  include CanCan::Ability

  def initialize(user)
    if user.has_role? :admin
      can :manage, :all
    else
      can :read, :all
      can :manage, Datapoint
      can :manage, User
    end
  end
end
