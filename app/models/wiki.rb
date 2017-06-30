class Wiki < ActiveRecord::Base

  belongs_to :user
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators

  validates :title, uniqueness: {case_sensitive: false },
                                 length: { minimum: 2, maximum: 300 }

  scope :visible, -> (user) { user ? all : where(private: false) }


  def non_collaborators
    User.where.not(id: collaborators.pluck(:id))
  end
end
