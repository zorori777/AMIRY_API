module APIComponents
  module Controllers
    class IntroductionsController < ApiController
      # index
      desc 'Returns all introductions' do
        detail <<~DETAIL
          Returns All Introduction Objects
        DETAIL
        http_codes([
          { code: 200, message: 'Introduction', model: Entities::Introduction }
        ])
      end
      params do
        optional :page, type: Integer, desc: "Page Num"
        requires :recipient_id, type: Integer, desc: 'The id of the article.'
      end
      get '' do
        user = User.find(params[:recipient_id])
        present user.introductions, with: Entities::Introduction
      end
    end
  end
end
