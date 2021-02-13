module Authenticate
  def current_user
    auth_token = request.headers["AUTH-TOKEN"]
    return unless auth_token
    @current_user = User.find_by authentication_token: auth_token
  end

  def authenticate_with_token!
    return if current_user
    json_response "Unauthenticated", false, {}, :unauthorized
  end

  def correct_user user
    user.id == current_user.id
  end

  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)

      @current_user = User.find(@decoded[:user_id])

    rescue ActiveRecord::RecordNotFound => e
      json_response "Unauthenticated", false, {}, :unauthorized
    rescue JWT::DecodeError => e
      json_response "Unauthenticated", false, {}, :unauthorized
    end
  end
end
