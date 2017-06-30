class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, #:confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis
  has_many :collaborators, dependent: :destroy

  enum role: [:standard, :premium, :admin]
  before_save { self.role ||= :standard }

  after_update :go_public

  def go_public
    if self.role == 'standard'
      user_wikis = self.wikis.where(private: true)
      user_wikis.each do |wiki|
       wiki.update_attributes(private: false)
      end
    end
  end
end
