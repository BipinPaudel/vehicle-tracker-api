# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :validate_login, :create
      before_action :sign_in_params, :load_user, :create
      before_action :valid_token, only: :destroy

      # sign in
      def create
        if @user&.authenticate(sign_in_params[:password])
          json_response 'Signed In Successfully', true, login_response, :ok
        else
          json_response_errors 'Unauthorized', :unauthorized
        end
      end

      # log out
      def destroy
        sign_out @user
        @user.generate_new_authentication_token
        json_response 'Log out Successfully', true, {}, :ok
      end

      private

      def login_response
        token = JsonWebToken.encode(user_id: @user.id)
        time = Time.now + 24.hours.to_i
        {
          token: token,
          exp: time.strftime('%m-%d-%Y %H:%M'),
          username: @user.email,
          id: @user.id
        }
      end

      def sign_in_params
        params.permit(:email, :password)
      end

      def load_user
        @user = User.find_by(email: sign_in_params[:email])
        @user || json_response_errors('Cannot get User', :unauthorized)
      end

      def valid_token
        @user = User.find_by authentication_token: request.headers['AUTH-TOKEN']

        @user || json_response_errors('Invalid Token', :unauthorized)
      end

      def validate_login
        d = Validators::Auths::SessionValidator.new params
        json_response_errors(d.parsed_errors, 400) if d.invalid?
      end
    end
  end
end
