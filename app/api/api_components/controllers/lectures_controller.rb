module APIComponents
  module Controllers
    class LecturesController < ApiController
      desc 'Return all lectures' do
        http_codes([
          { code: 200, message: 'lecture', model: Entities::Lecture }
        ])
      end
      params do
        optional :page, type: Integer, desc: "Page Num"
      end
      get '/' do
        present Lecture.includes(:user).recent.passed.page(params[:page]), with: Entities::Lecture
      end
    end
  end
end
