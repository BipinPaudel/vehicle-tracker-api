# frozen_string_literal: true

module Api
  module V1
    class RegistrationsController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :validate_add_registration, :create

      # sign up
      def create
        user = User.new user_params
        if user.save
          json_response 'Signed Up successfully', true, registration_success_response(user), :ok
        else
          json_response_errors 'Something wrong', :unprocessable_entity
        end
      end

      private

      def registration_success_response(user)
        token = JsonWebToken.encode(user_id: user.id)
        time = Time.now + 24.hours.to_i
        {
          token: token,
          exp: time.strftime('%m-%d-%Y %H:%M'),
          username: user.email,
          id: user.id
        }
      end

      def user_params
        params.permit(:email, :password, :password_confirmation)
      end

      def ensure_params_exist
        return if params.present?

        json_response_errors 'Missing Params', :bad_request
      end

      def validate_add_registration
        validator = Validators::Registration::AddValidator.new user_params
        json_response_errors(validator.parsed_errors, 400) if validator.invalid?
      end
    end
  end
end
