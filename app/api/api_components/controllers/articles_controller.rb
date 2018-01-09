module APIComponents
  module Controllers
    class ArticlesController < ApiController
      format :json

      resources :articles do
        # index
        desc 'Returns all articles' do
          detail <<~DETAIL
            Returns Article Objects.
          DETAIL
          http_codes([
            { code: 200, message: 'Article', model: Entities::Article }
          ])
        end
        params do
          optional :page, type: Integer, desc: 'Page Num'
        end
        get '' do
          present Article.includes(:user).page(params[:page]), with: Entities::Article
        end

        # show
        desc 'Return an article.' do
          detail <<~DETAIL
            Returns an Article Object
          DETAIL
          http_codes([
            { code: 200, message: 'Article', model: Entities::Article },
            { code: 400, message: 'Error',   model: Entities::Error }
           ])
        end
        params do
          requires :id, type: Integer, desc: 'Article Primary id.'
        end
        get '/:id' do
          article_id = params[:id].to_i
          article = Article.find_by(id: article_id)
          unless article.present?
            Errors::RecordNotFoundError.new(id: article_id, model: 'Article')
          end
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
          article = Article.new({ user_id: params[:user_id], content: params[:content], title: params[:title] })
          article.save!
          present article, with: Entities::Article
        end

        route_param :article_id do
          resource :article_comments do
            desc 'Returns all articles' do
              detail <<~DETAIL
                Returns Article Objects.
              DETAIL
              http_codes([
                { code: 200, message: 'Article', model: Entities::ArticleComment }
              ])
            end
            params do
              optional :page, type: Integer, desc: 'Page Num'
            end
            get '/' do
              article = Article.find_by(id: params[:article_id])
              unless article.present?
                Errors::RecordNotFoundError.new(id: params[:article_id], model: 'Article')
              end
              present article.article_comments.page(params[:page]), with: Entities::ArticleComment
            end
          end
        end
      end
    end
  end
end
