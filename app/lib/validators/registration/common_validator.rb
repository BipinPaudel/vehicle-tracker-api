# frozen_string_literal: true

module Validators
  module Registration
    class CommonValidator
      include Validators::Validator

      attr_accessor :email, :password, :password_confirmation

      validates :email,
                presence: { message: 'Email cannot be blank' },
                format: { with: URI::MailTo::EMAIL_REGEXP, message: 'Email format is incorrect' }

      validates :password,
                presence: { message: 'Password cannot be blank' },
                length: { minimum: 6, message: 'Password must be 6 characters or more' },
                confirmation: { case_sensitive: true,
                                message: 'Password confirmation cannot be different' }

      def initialize(params = {})
        @email = params[:email]
        @password = params[:password]
        @password_confirmation = params[:password_confirmation]
      end
    end
  end
end
