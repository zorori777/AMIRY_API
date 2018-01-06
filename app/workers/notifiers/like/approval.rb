module Notifiers
  module Matching
    class Approval
      include Sidekiq::Worker
      include NotifierCommonMethods

      def perform_async(like_id)
        like = Like.find_by(id: like_id)

        return unless self.args_all_present?(like)

        begin
          self.send_push_notification(
            body: Notification::LIKE_APPROVAL_BODY,
            player_ids: [like.sender_id, like.recipient_id]
          )
        rescue => error
          logger.info  'Like Approval Notification Record Saving Failed. The Reasons are below.'
          logger.debug "Error: #{error}"
        end
      end
    end
  end
end
