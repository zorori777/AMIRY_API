class CirclesController < ApplicationController
  before_action :set_circle, only: :show

  def index
    @circles = CircleDecorator.decorate_collection(Circle.all.includes(:university))

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @circles.object, each_serializer: CircleSerializer }
    end
  end

  def show
    respond_to do |format|
      format.html { render :show }
      format.json { render json: CircleSerializer.new(@circle) }
    end
  end

  private
  def set_circle
    circle_id = params[:id].to_i

    # 404 のエラーを出すようにする
    # if circle_id <= 0
    #   return head :bad_request
    # end

    @circle = Circle.find(circle_id).decorate
  end

end
