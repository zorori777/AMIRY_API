module APIComponents
  module Controllers
    class LecturesController < ApiController
      # index
      desc 'Return all lectures.' do
        http_codes([
          { code: 200, message: 'lecture', model: Entities::Lecture }
        ])
      end
      params do
        optional :page, type: Integer, desc: 'Page Num'
      end
      get '/' do
        present Lecture.includes(:user).recent.passed.page(params[:page]), with: Entities::Lecture
      end

      # show
      desc 'Return a Single Lecture Object.' do
        http_codes([
          { code: 200, message: 'lecture', model: Entities::Lecture }
        ])
      end
      params do
        requires :id, type: Integer, desc: 'The id of the lecture.'
      end
      get '/:id' do
        lecture = Lecture.find_by(id: params[:id])
        unless lecture.present?
          Errors::RecordNotFoundError.new(id: params[:id], model: 'lecture')
        end

        present lecture, with: Entities::Lecture
      end
    end
  end
end
