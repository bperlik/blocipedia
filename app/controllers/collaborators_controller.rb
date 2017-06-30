class CollaboratorsController < ApplicationController

  def new
    @users = User.all
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new(collaborator_params)
    authorize @collaborator

    if @collaborator.save
      flash[:notice] = "#{@collaborator.user.email} was successfully added collaborator to your team."
      redirect_to @wiki
    else
      flash[:notice] = "Collaborator was not added due to an error. Please try again."
      redirect_to @wiki
    end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find(params[:id])
    @user = @collaborator.user
    authorize @collaborator
    if @collaborator.destroy
      flash[:notice] = "Collaborator #{@user.email} is no longer a collaborator on this wiki."
      redirect_to @wiki
    else
      flash.now[:alert] = "An error occurred while deleting that collaborator."
      redirect_to @wiki
    end
  end

  private

  def collaborator_params
    params.require(:collaborator).permit(:wiki_id, :user_id)
  end
end
