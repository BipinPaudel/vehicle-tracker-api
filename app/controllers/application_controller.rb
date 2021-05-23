class ApplicationController < ActionController::Base
  include Response
  include Authenticate
  include JsonWebToken

  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  def user_vehicle?(vehicle_id = nil)
    return false if (params[:vehicle_id] || vehicle_id).blank?

    @vehicle = Vehicle.find_by(id: (params[:vehicle_id] || vehicle_id))
    return false if @vehicle.blank?

    @vehicle.user_id == @current_user.id
  end


  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = %w{Origin Accept Content-Type X-Requested-With auth_token X-CSRF-Token}.join(',')
    headers['Access-Control-Max-Age'] = '1728000'
  end

  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = 'http://localhost'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Allow-Headers'] = %w{Origin Accept Content-Type X-Requested-With auth_token X-CSRF-Token}.join(',')
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'
    end
  end
end
