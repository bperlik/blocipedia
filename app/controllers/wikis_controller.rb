class WikisController < ApplicationController

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    unless @wiki.private == false || current_user.id == @wiki.user_id || current_user.premium? || current_user.admin?
      flash[:alert] = "You do not have the permission to see this private wiki."
      redirect_to root_path
    end
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    if @wiki.save
      flash[:notice] = "Wiki '#{@wiki.title}' was saved."
      redirect_to [@wiki]
    else
      flash.now[:alert] = "An error occurred whilst saving the wiki.  Please try again."
      render :new
    end
    authorize @wiki
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Wiki was updated sucessfully"
      redirect_to @wiki
    else
      flash[:notice] = "There was an error updating this wiki. Please try again"
      render "edit"
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.destroy
      flash[:notice] = "Wiki was deleted successfully"
      redirect_to wikis_path
    else
      flash[:notice] = "There was an error deleting a wiki. Please try again"
      render "show"
    end
  end

  private
  def wiki_params
    params.require(:wiki).permit(:title,:body, :private)
  end

end
