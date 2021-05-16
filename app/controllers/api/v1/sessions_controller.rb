# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :sign_in_params, :load_user, only: :create
      before_action :valid_token, only: :destroy

      # sign in
      def create
        if @user&.authenticate(sign_in_params[:password])
          token = JsonWebToken.encode(user_id: @user.id)
          time = Time.now + 24.hours.to_i
          res = {
            token: token,
            exp: time.strftime('%m-%d-%Y %H:%M'),
            username: @user.email,
            id: @user.id
          }
          json_response 'Signed In Successfully', true, res, :ok
        else
          json_response 'Unauthorized', false, {}, :unauthorized
        end
      end

      # log out
      def destroy
        sign_out @user
        @user.generate_new_authentication_token
        json_response 'Log out Successfully', true, {}, :ok
      end

      private

      def sign_in_params
        params.permit(:email, :password)
      end

      def load_user
        @user = User.find_by(email: sign_in_params[:email])
        @user || json_response('Cannot get User', false, {}, :unauthorized)
      end

      def valid_token
        @user = User.find_by authentication_token: request.headers['AUTH-TOKEN']

        @user || json_response('Invalid Token', false, {}, :unauthorized)
      end
    end
  end
end
