module Notifiers
  class Matching
    include Sidekiq::Worker
    include NotifierInterface

    def perform_async(sender_id, recipient_id)
      sender    = User.find_by(id: sender_id)
      recipient = User.find_by(id: recipient_id)

      return unless sender.present? || recipient.present?

      begin
        self.send_push_notification(body: Notification::MATCHING_BODY, player_ids: [sender_id, recipient_id])
      rescue => error
        p error
      end
    end
  end
end
