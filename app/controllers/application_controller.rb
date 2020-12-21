class ApplicationController < ActionController::Base
  include Response
  include Authenticate

  def user_vehicle?(vehicle_id = nil)
    return false if (params[:vehicle_id] || vehicle_id).blank?
    @vehicle = Vehicle.find_by(id: (params[:vehicle_id] || vehicle_id))

    return false if @vehicle.blank?
    @vehicle.user_id == current_user.id
  end
end
