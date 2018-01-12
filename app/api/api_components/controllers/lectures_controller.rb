module APIComponents
  module Controllers
    class LecturesController < ApiController
      before do
        if user_debug_id = headers['User-Debug-Id']
          @user = User.find(user_debug_id)
        else
          jwt_token = headers['JWT_token']
          @user = External::Jwt::JwtHandler.new.user_by(token: jwt_token)
        end
      end

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

      # create
      desc 'Create a Lecture Object.' do
        http_codes([
          { code: 200, message: 'lecture', model: Entities::Lecture }
        ])
      end
      params do
        requires :title,       type: String,   desc: 'The title of the lecture.'
        requires :description, type: String,   desc: 'The description of the lecture.'
        requires :address,     type: String,   desc: 'Where the address .'
        requires :hold_at,     type: DateTime, desc: 'When the lecture is to held at.'
        requires :image_file,  type: File,     desc: 'The file for the lecture.'
      end
      post '/' do
        lecture = Lecture.new(title: params[:title], description: params[:description],
                              address: params[:address], hold_at: params[:hold_at])
        lecture.user = @user
        lecture.lecture_files.build(name: params[:image_file])

        begin
          ActiveRecord::Base.transaction do
            lecture.save!
            present lecture, with: Entities::Lecture
          end
        rescue => error
          Errors::InternalServerError.new(detail: error)
        end
      end
    end
  end
end
