class Api::V1::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token
  before_action :ensure_params_exist, only: :create

  # sign up
  def create
    user = User.new user_params
    if user.save
      json_response "Signed Up successfully", true, user, :ok
    else
      json_response "Something wrong", false, {}, :unprocessable_entity
    end
  end

  def require_no_authentication

  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def ensure_params_exist
    return if params.present?
    json_response "Missing Params", false, {}, :bad_request
  end
end
