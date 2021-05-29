# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV['BIPIN_EMAIL']
  layout 'mailer'
end
