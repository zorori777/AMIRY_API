module Inserters
  module Like
    class Approval
      include Sidekiq::Worker
      include InserterCommonConstants
      include InserterCommonMethods

      def perform(like_id)
        like = Like.find_by(id: like_id)

        return unless self.args_all_present?(like)

        begin
          [like.sender_id, like.recipient_id].each do |user_id|
            notification = Notification.new_like_approval_notification(user_id: user_id, like_id: like_id)
            notification.save!
          end
        rescue => error
          logger.info  'Like Approval Notification Record Saving Failed. The Reasons are below.'
          logger.debug "Error: #{error}"
        end
      end
    end
  end
end
