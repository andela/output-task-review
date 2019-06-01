class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_article, only: %i[show update destroy]

  def index
    @articles = BatchArticlesDecorator.new(
      articles: Article.all.includes(:user),
      params: params
    ).call
    @articles = Paginator.new(
      object: @articles,
      offset: params[:offset],
      limit: params[:limit]
    ).call

    @articles_count = @articles.count
  end

  def feed
    following = current_user.following_users
    @articles = Article.includes(:user).where(user: following)
    @articles = Paginator.new(
      object: @articles,
      offset: params[:offset],
      limit: params[:limit]
    ).call

    @articles_count = @articles.count

    render :index
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      redirect_to articles_show_path(@article), notice: 'Article created!'
    else
      render :new
    end
  end

  def show; end

  def update
    if @article.user_id == current_user.id
      @article.update_attributes(article_params)
      redirect_to articles_show_path(@article)
    else
      render :edit
    end
  end

  def destroy
    current_user.articles.find_by(id: @article.id)&.destroy
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :description, tag_list: [])
  end

  def set_article
    @article = Article.find_by_slug!(params[:slug])
  end
end
