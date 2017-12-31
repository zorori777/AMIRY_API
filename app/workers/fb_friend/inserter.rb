module FBFriend
  class Inserter
    include Sidekiq::Worker

    def perform(user_id, facebook_friends)
      return unless user_id.present? || facebook_friends.present?

      begin
        facebook_friends.each_slice(::Constant::BULK_INSERT_NUM) do |sliced_facebook_friends|
          sliced_facebook_friends.each do |facebook_friend|
            new_record             = FacebookFriend.new
            new_record.user_id     = user_id
            new_record.facebook_id = facebook_friend['id'].to_i
            new_record.save!
          end
          sleep(::Constant::SLEEP_SEC)
        end
      rescue => error
        logger.info  'Facebook Friends Record Saving Failed. The Reasons are below.'
        logger.debug "Error: #{error}"
      end
    end
  end
end
