# frozen_string_literal: true

module Api
  module V1
    class RegistrationsController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :ensure_params_exist, only: :create

      # sign up
      def create
        user = User.new user_params

        if user.save
          token = JsonWebToken.encode(user_id: user.id)
          time = Time.now + 24.hours.to_i
          res = {
            token: token,
            exp: time.strftime('%m-%d-%Y %H:%M'),
            username: user.email,
            id: user.id
          }
          json_response 'Signed Up successfully', true, res, :ok
        else
          json_response 'Something wrong', false, {}, :unprocessable_entity
        end
      end

      private

      def user_params
        params.permit(:email, :password, :password_confirmation)
      end

      def ensure_params_exist
        return if params.present?

        json_response 'Missing Params', false, {}, :bad_request
      end
    end
  end
end
