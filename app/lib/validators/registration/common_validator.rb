# frozen_string_literal: true

module Validators
  module Registration
    class CommonValidator
      include Validators::Validator

      attr_accessor :email, :password, :password_confirmation

      validates :email,
                presence: { message: 'Email cannot be blank' }
      validates :password,
                presence: { message: 'Password cannot be blank' }
      validates :password,
                confirmation: { case_sensitive: true, message: 'Password confirmation cannot be different' }

      def initialize(params = {})
        @email = params[:email]
        @password = params[:password]
        @password_confirmation = params[:password_confirmation]
      end
    end
  end
end
