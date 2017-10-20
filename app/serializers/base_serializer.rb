
class BaseSerializer < ActiveModel::Serializer
  include ActiveModel::Serialization

  def initialize(object, **option)
    super
    @user_object = option[:user_object]
  end

  def user_format_json
    {
        id:                   @user_object.id,
        university_name:      @user_object.university&.name.to_s,
        circle:               @user_object.circles.pluck(:name).join(', '),
        first_name:           @user_object.first_name,
        last_name:            @user_object.last_name,
        display_name:         @user_object.display_name,
        email:                @user_object.email,
        avatar:               @user_object.avatar.filename&.name.to_s,
        catchcopy:            @user_object.catchcopy&.to_s,
        self_introduction:    @user_object.self_introduction,
        bands_count:          @user_object.bands_count,
        received_likes_count: @user_object.received_likes_count,
        sendable_likes_count: @user_object.sendable_likes_count,
        matchings_count:      @user_object.matchings_count,
        created_at:           @user_object.created_at,
        updated_at:           @user_object.updated_at
    }
  end
end
