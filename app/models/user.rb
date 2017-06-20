class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, #:confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis
  before_save { self.role ||= :standard }
  enum role: [:standard, :premium, :admin]

  def go_public
    self.wikis.each { |wiki| puts wiki.make_public }
  end
end
