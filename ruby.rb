class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @articles = Article.all.includes(:user)
    articles_type
    boundary = articles_boundary(0, 20)
    offset = boundary[offset]
    limit = boundary[limit]
    @articles = @articles.order(created_at: :desc).offset(offset).limit(limit)
  end

  def articles_type
    if params[:tag].present?
      @articles = @articles.tagged_with(params[:tag])
    elsif params[:author].present?
      @articles = @articles.authored_by(params[:author])
    elsif params[:favorited].present?
      @articles = @articles.favorited_by(params[:favorited])
    end
  end

  def articles_boundary(offset = nil, limit = nil)
    @articles_count = @articles.count
    offset = params[:offset] if params[:offset]
    limit = params[:limit] if params[:limit]

    { offset: offset, limit: limit }
  end

  def feed
    @articles = Article
                .includes(:user)
                .where(user: current_user.following_users)

    boundary = articles_boundary
    offset = boundary[offset]
    limit = boundary[limit]
    @articles = @articles.order(created_at: :desc).offset(offset).limit(limit)
    render :index
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      render :show
    else
      render json: { errors: @article.errors }, status: 422
    end
  end

  def show
    @article = Article.find_by_slug!(params[:slug])
  end

  def update
    @article = Article.find_by_slug!(params[:slug])

    if @article.user_id == @current_user_id
      @article.update_attributes(article_params)
      render :show
    else
      render json: not_owned, status: :forbidden
    end
  end

  def destroy
    @article = Article.find_by_slug!(params[:slug])

    if @article.user_id == @current_user_id
      @article.destroy

      render json: {}
    else
      render json: not_owned, status: :unprocessable_entity
    end
  end

  def not_owned
    { errors: { article: ['not owned by user'] } }
  end

  protected

  def article_params
    params.require(:article).permit(:title, :body, :description, tag_list: [])
  end
end
