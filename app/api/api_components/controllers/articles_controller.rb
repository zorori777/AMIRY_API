module APIComponents
  module Controllers
    class ArticlesController < ApiController
      # index
      desc 'Returns all articles' do
        detail <<~DETAIL
          Returns All Article Objects
        DETAIL
        http_codes([
          { code: 200, message: 'Article', model: Entities::Article }
        ])
      end
      get '' do
        present Article.includes(:user).all, with: Entities::Article
      end

      # show
      desc 'Return an article.' do
        detail <<~DETAIL
          Returns an Article Object
        DETAIL
        http_codes([
          { code: 200, message: 'Article', model: Entities::Article }
        ])
      end
      params do
        requires :id, type: Integer, desc: 'Article id.'
      end
      get '/:id' do
        present Article.find(params[:id]), with: Entities::Article
      end

      # create
      desc 'Create an Article.'
        params do
          requires :title,   type: String, desc: 'title'
          requires :content, type: String, desc: 'content'
          requires :user_id, type: Integer
        end
        post '' do
          article = Article.new({user_id: params[:user_id], content: params[:content], title: params[:title]})
          article.save!
          present article, with: Entities::Article
        end
    end
  end
end
