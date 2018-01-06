module Notifiers
  module Like
    class Approval
      include Sidekiq::Worker
      include NotifierCommonMethods

      def perform_async(like_id)
        like = Like.find_by(id: like_id)

        return unless args_all_present?(like)

        begin
          self.send_push_notification(body: Notification::LIKE_REQUEST_BODY, player_ids: [sender_id, recipient_id])
        rescue => error
          logger.info  'Like Approval Notification Failed. The Reasons are below.'
          logger.debug "Error: #{error}"
        end
      end
    end
  end
end
