module APIComponents
  module UserBand
    class UserBand < Grape::Entity
      expose :user_display_name
      expose :band_name
    end
  end
end
