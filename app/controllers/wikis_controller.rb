class WikisController < ApplicationController
  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    unless @topic.public || current_user
      flash[:alert] = "You must be signed in to view your private topics"
      redirect_to new_session_path
    end
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.user = current_user
    @wiki.public = params[:wiki][:public]

    if @wiki.save
      flash[:notice] = "Wiki saved"
      redirect_to @wiki
    else
      flash.now[:alert]= "There was an error saving"
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.public = params[:wiki][:public]

    if @wiki.save
      flash[:notice] = "Wiki was updated"
      redirect_to @wiki
    else
      flash.now[:alertl] = "There was an error saving"
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully"
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting this wiki"
      render :show
    end
  end

  private
  def wiki_params
    params.require(:wiki).permit(:title, :body, :public)
end
