class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def show?    # private admin or self should see all wikis
    user.present? && (!wiki.private || user.admin? || wiki.user_id == user.id)
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
    user.role == 'admin' || wiki.user == user?
  end
end
