class ArticlesController < ApplicationController

  def index
    @articles = Article.paginate(page: params[:page])
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = "Статья успешно создана!"
      redirect_to @article
    else
      render 'new'
    end
  end

  def destroy
    Article.find(params[:id]).destroy
    flash[:success] = "Статья успешно удалена"
    redirect_to articles_url
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      flash[:success] = "Статья успешно обновлена"
      redirect_to @article
    else
      render 'edit'
    end
  end

   private

    def article_params
      params.require(:article).permit(:title, :description, :content)
    end

end
