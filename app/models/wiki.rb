class Wiki < ActiveRecord::Base

  belongs_to :user

  scope :visible, -> (user) do
    return all if user && (user.premium? || user.admin?)
    where(private: [false, nil])
  end

  def make_public
    update_attribute(:private, false)
  end
end
