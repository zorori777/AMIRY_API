module APIComponents
  module Controllers
    class ArticleCommentsController < ApiController
      desc 'Return all comments associated with the specific article.' do
        http_codes([
          { code: 200, message: 'Article Comment', model: Entities::ArticleComment }
        ])
      end
      params do
        optional :page,       type: Integer, desc: 'Page Num'
        requires :article_id, type: Integer, desc: 'The id of the article.'
      end
      get '/' do
        article = Article.find(params[:article_id])
        present article.article_comments.includes(:user).newest.page(params[:page]), with: Entities::ArticleComment
      end
    end
  end
end
