module APIComponents
  module Controllers
    class ArticlesController < ApiController
      format :json

      before do
        if user_debug_id = headers['User-Debug-Id']
          @user = User.find(user_debug_id)
        else
          jwt_token = headers['JWT_token']
          @user = External::Jwt::JwtHandler.new.user_by(token: jwt_token)
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
        end
        post '' do
          article = Article.new(content: params[:content], title: params[:title])
          article.user = @user
          begin
            article.save!
            present article, with: Entities::Article
          rescue => error
            Errors::InternalServerError.new(message: error)
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
        end
        params do
          requires :id,      type: Integer, desc: 'The id of the article.'
          requires :title,   type: String,  desc: 'The title of the article.'
          requires :content, type: String,  desc: 'The content of the article.'
        end
        put '/' do
          article = Article.find_by(id: params[:id])
          unless article.present?
            Errors::RecordNotFoundError.new(id: params[:id], model: 'Article')
          end
          begin
            article.save!
            present article, with: Entities::Article
          rescue => error
            Errors::InternalServerError.new(message: error)
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
        end
        params do
          requires :id, type: Integer, desc: 'The id of the article.'
        end
        delete '/' do
          article = Article.find_by(id: params[:id])
          unless article.present?
            Errors::RecordNotFoundError.new(id: params[:id], model: 'Article')
          end
          unless article.created_by?(@user)
            Errors::UnauthorizedError.new(message: 'The user doesn\'t own the article.')
          end
          begin
            article.destroy!
            present :ok
          rescue => error
            Errors::InternalServerError.new(message: error)
          end
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

            # create
            desc 'Returns all article_comments associated with the article.' do
              detail <<~DETAIL
                Returns Article Objects.
              DETAIL
              http_codes([
                { code: 200, message: 'Article', model: Entities::ArticleComment }
              ])
            end
            params do
              requires :article_id, type: Integer, desc: 'The id of the article.'
              requires :content,    type: String, desc: 'The content of the comment.'
            end
            post '/' do
              article = Article.find_by(id: params[:article_id])
              unless article.present?
                Errors::RecordNotFoundError.new(id: params[:article_id], model: 'Article')
              end
              article_comment = ArticleComment.new(content: params[:content])
              article_comment.user = @user
              article_comment.article = article
              begin
                article_comment.save!
                present article_comment, with: Entities::ArticleComment
              rescue => error
                Errors::InternalServerError.new(message: error)
              end
            end
          end
        end
      end
    end
  end
end
