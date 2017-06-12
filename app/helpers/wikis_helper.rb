module WikisHelper
  def user_is_authorized_to_view?
  end

  def user_is_authorized_to_create?
    current_user
  end

  def user_is_authorized_to_update?
    current_user
  end

  def user_is_authorized_to_delete?
    current_user && current_user.admin?
  end
end
