module <%= class_name %>
  class Ability
    include CanCan::Ability

    def initialize(user)
      user ||= User.new # guest user (not logged in)

      can :show, :public_home
    end
  end
end
