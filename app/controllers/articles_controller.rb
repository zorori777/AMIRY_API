class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]

  def index
    all_articles = Article.all.includes(:user).in_newest_order
    @articles = paginate ArticleDecorator.decorate_collection(all_articles), per_page: Article::PER_PAGE

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @articles, each_serializer: ArticleSerializer }
    end
  end

  def show

  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
    
  end

  private
  def set_article
    article_id = params[:id].to_i

    # レコードが見つからなかったら、404を吐き出すようにする
    # if article_id <= 0
    # end

    @article = Article.find(article_id).decorate
  end
end
