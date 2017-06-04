class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    if @wiki.save
      flash[:notice] = "Wiki '#{@wiki.title}' was saved."
      redirect_to [@wiki]
    else
      flash.now[:alert] = "There was an error saving the wiki.  Please try again."
      render :new
    end
  end

  def edit
  end

  def wiki_params
    params.require(:wiki).permit(:title,:body, :private)
  end

end
