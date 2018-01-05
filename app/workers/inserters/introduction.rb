module Inserters
  class Introduction
    include InserterCommonMethods

    def perform_async(sender_id, recipient_id, introduction_id)
      sender    = User.find_by(id: sender_id)
      recipient = User.find_by(id: recipient_id)
      matching  = Matching.find_by(id: introduction_id)

      return unless self.args_all_present?(sender, recipient, matching)

      begin
        [sender_id, recipient_id].each do |user_id|
          notification = Notification.new_matching_notification(user_id: user_id, matching_id: matching_id)
          notification.save!
        end
      rescue => error
        logger.info  'Facebook Friends Record Saving Failed. The Reasons are below.'
        logger.debug "Error: #{error}"
      end
    end
  end
end
