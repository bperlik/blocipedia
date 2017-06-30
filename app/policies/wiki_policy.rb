class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def show?    # private admin or self should see all wikis
    user.present? && ( wiki.private == false || user.admin? || wiki.user_id == user.id)
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    user.present?
  end

  def edit?
    update?
  end

  def destroy?
    user.present? && (user.role == 'admin' || wiki.user == user?)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.role == 'admin'
        wikis = scope.all # if the user is an admin, show all wikis
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.private ==false || wiki.user == user || wiki.collaborators.pluck(:user_id).include?(user.id) == user || wiki.collaborators.include?(user)
            wikis << wiki # if user is premium, show public, self-authored, and private/appointed-as-collaborator wikis
          end
        end
      else # this is the standard user
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if wiki.private == false || wiki.collaborators.include?(user.id)
            wikis << wiki # if user is standard, show public and private/appointed-as-collaborator wikis
          end
        end
      end
      wikis # return the wikis array built in this resolve
    end
  end
end
