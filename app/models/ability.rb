class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    can :view, :large if user.has_role? :large
    can :view, :medium if user.has_role? :medium
    can :view, :small if user.has_role? :small
    can :view, :free if user.has_role? :free
  end
end
