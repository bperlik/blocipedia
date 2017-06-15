class WikisController < ApplicationController

  skip_before_filter :authenticate_user!, only: [:index, :show]

  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
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
      flash[:notice] = "There was an error updating a wiki. Please try again" 
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
