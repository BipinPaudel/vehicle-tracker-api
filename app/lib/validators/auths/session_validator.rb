# frozen_string_literal: true

module Validators
  module Auths
    class SessionValidator
      include Validators::Validator

      attr_accessor :email, :password

      validates :email, presence: { message: 'Email cannot be blank' }
      validates :password, presence: { message: 'Password cannot be blank' }

      def initialize(params = {})
        @email = params[:email]
        @password = params[:password]
      end
    end
  end
end
