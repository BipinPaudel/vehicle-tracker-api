# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def simple_message(options)
    mail(
      to: options[:recipients],
      subject: options[:subject],
      content_type: 'text/html',
      body: options[:body]
    )
  end
end
