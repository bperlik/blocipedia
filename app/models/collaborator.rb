class Collaborator < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki

  def current_collaborators
    User.where(id: collaborator.pluck(:user.id))
  end

  def not_current_collaborators
    User.where.not(id: collaborator.pluck(:user.id))
  end

end
