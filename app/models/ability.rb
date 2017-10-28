# See the wiki for details:
# https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

class Ability
  include CanCan::Ability

  def initialize(admin_user)

    alias_action :create, :read, :update, :destroy, to: :crud

    if admin_user.super_admin?
      can :manage, :all
      can :manage, ActiveAdmin::Page, name: 'Dashboard'
    elsif admin_user.ordinary?
      can :read, :all
      can :read, ActiveAdmin::Page, name: 'Dashboard'
    end

  end
end
