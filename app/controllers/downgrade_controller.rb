class DowngradeController < ApplicationController

  def new
  end

  def create
    current_user.standard!
    current_user.wikis.where(private: true).all.each do |wiki|
      wiki.update_attribute(:private, false)
      flash[:notice] = "You have successfully downgraded your account. Your private wikis are now all public."
    end

    redirect_to root_path

  end
end
