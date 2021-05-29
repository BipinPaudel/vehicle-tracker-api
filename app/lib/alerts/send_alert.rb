# frozen_string_literal: true

module Alerts
  class SendAlert
    def self.send_alerts
      new.send_alerts
    end

    def send_alerts
      records = Vehicle.records_to_send
      options = prepare_options(records)
      UserMailer.simple_message(options).deliver_now! if options.present?
    end

    def prepare_options(records)
      recipients = prepare_recipients(records)
      return nil if recipients.blank?

      subject = 'Vehicle maintenance notification'
      body = '<html><strong>Some vehicles need maintenance. Please check!</strong></html>'
      {
        recipients: recipients,
        subject: subject,
        body: body
      }
    end

    def prepare_recipients(records)
      records.map { |rec| rec['email'] }.uniq.compact.join(',')
    end
  end
end
