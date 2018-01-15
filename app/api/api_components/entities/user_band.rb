module APIComponents
  module Entities
    class UserBand < Grape::Entity
      expose :user_display_name
      expose :band_name
    end
  end
end
