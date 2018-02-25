module APIComponents
  module Controllers
    class ArticlesController < ApiController
      format :json

      before do
        if user_debug_id = headers['User-Debug-Id']
          @current_user = User.find(user_debug_id)
        else
          jwt_token = headers['JWT_token']
          @current_user = External::Jwt::JwtHandler.new.user_by(token: jwt_token)
        end
      end

      resources :articles do
        # index
        desc 'Returns all articles' do
          detail <<~DETAIL
            Returns Article Objects.
          DETAIL
          http_codes([
            { code: 200, message: 'Article', model: Entities::Article }
          ])
          headers(
            facebook_id:    { description: 'The id of the user on facebook',             required: false },
            facebook_token: { description: 'The access token provided by Facebook SDK.', required: false },
            user_debug_id:  { description: 'Debug id.',                                  required: false }
          )
        end
        params do
          optional :page, type: Integer, desc: 'Page Num'
        end
        get '' do
          articles = Article.includes(:user).page(params[:page])
          present_success articles, Entities::Article
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
          headers(
            facebook_id:    { description: 'The id of the user on facebook',             required: false },
            facebook_token: { description: 'The access token provided by Facebook SDK.', required: false },
            user_debug_id:  { description: 'Debug id.',                                  required: false }
          )
        end
        params do
          requires :id, type: Integer, desc: 'Article Primary id.'
        end
        get '/:id' do
          article = Article.find_by(id: params[:id])
          error_404! unless article.present?
          present_success article, Entities::Article
        end

        # create
        desc 'Create an Article.' do
          headers(
            facebook_id:    { description: 'The id of the user on facebook',             required: false },
            facebook_token: { description: 'The access token provided by Facebook SDK.', required: false },
            user_debug_id:  { description: 'Debug id.',                                  required: false }
          )
        end
        params do
          requires :title,   type: String, desc: 'title'
          requires :content, type: String, desc: 'content'
        end
        post '' do
          article = Article.new(content: params[:content], title: params[:title])
          article.user = @user
          if article.save
            present article, with: Entities::Article
          else
            error_400! article
          end
        end

        # update
        desc 'Update an Article.' do
          detail <<~DETAIL
            Update an Article Object
          DETAIL
          http_codes([
            { code: 200, message: 'Article', model: Entities::Article },
            { code: 400, message: 'Error',   model: Entities::Error }
          ])
          headers(
            facebook_id:    { description: 'The id of the user on facebook',             required: false },
            facebook_token: { description: 'The access token provided by Facebook SDK.', required: false },
            user_debug_id:  { description: 'Debug id.',                                  required: false }
          )
        end
        params do
          requires :id,      type: Integer, desc: 'The id of the article.'
          requires :title,   type: String,  desc: 'The title of the article.'
          requires :content, type: String,  desc: 'The content of the article.'
        end
        put '/:id' do
          article = Article.find_by(id: params[:id])
          error_404! article.present?

          if article.save
            present_success article, Entities::Article
          else
            error_400! article
          end
        end

        # destroy
        desc 'Destroy an Article.' do
          detail <<~DETAIL
            Destroy an Article Object
          DETAIL
          http_codes([
            { code: 200, message: 'Article', model: Entities::Article },
            { code: 400, message: 'Error',   model: Entities::Error }
          ])
          headers(
            facebook_id:    { description: 'The id of the user on facebook',             required: false },
            facebook_token: { description: 'The access token provided by Facebook SDK.', required: false },
            user_debug_id:  { description: 'Debug id.',                                  required: false }
          )
        end
        params do
          requires :id, type: Integer, desc: 'The id of the article.'
        end
        delete '/:id' do
          article = Article.find_by(id: params[:id])
          error_404! unless article.present?
          error_403! unless article.created_by?(@user)

          article.destroy ? present_ok : error_500!
        end

        route_param :article_id do
          resource :article_comments do
            # index
            desc 'Returns all article_comments associated with the article.' do
              detail <<~DETAIL
                Returns Article Objects.
              DETAIL
              http_codes([
                { code: 200, message: 'Article', model: Entities::ArticleComment }
              ])
              headers(
                facebook_id:    { description: 'The id of the user on facebook',             required: false },
                facebook_token: { description: 'The access token provided by Facebook SDK.', required: false },
                user_debug_id:  { description: 'Debug id.',                                  required: false }
              )
            end
            params do
              optional :page, type: Integer, desc: 'Page Num'
            end
            get '/' do
              article = Article.find_by(id: params[:article_id])
              error_404! unless article.present?
              present_success article.article_comments.page(params[:page]), Entities::ArticleComment
            end

            # create
            desc 'Returns all article_comments associated with the article.' do
              detail <<~DETAIL
                Returns Article Objects.
              DETAIL
              http_codes([
                { code: 200, message: 'Article', model: Entities::ArticleComment }
              ])
              headers(
                facebook_id:    { description: 'The id of the user on facebook',             required: false },
                facebook_token: { description: 'The access token provided by Facebook SDK.', required: false },
                user_debug_id:  { description: 'Debug id.',                                  required: false }
              )
            end
            params do
              requires :article_id, type: Integer, desc: 'The id of the article.'
              requires :content,    type: String, desc: 'The content of the comment.'
            end
            post '/' do
              article = Article.find_by(id: params[:article_id])
              error_404! unless article.present?
              article_comment = ArticleComment.new(content: params[:content])
              article_comment.user = @current_user
              article_comment.article = article

              if article_comment.save
                present_success article_comment, Entities::ArticleComment
              else
                error_400! article_comment
              end
            end
          end
        end
      end
    end
  end
end
