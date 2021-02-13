class Api::V1::VehiclesController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :authorize_request, only: [:create, :index, :show, :destroy, :update]
  before_action :load_user, only: [:index, :update, :destroy]
  before_action :load_vehicle, only: [:show, :destroy, :update]

  def index
    vehicles = @current_user.vehicles.joins(:category)
                .select("vehicles.*, categories.id as category_id, categories.title as category_title")
    json_response 'Vehicles loaded successfully', true, vehicles, :ok
  end

  def show
    json_response 'Show vehicle successfully', true, @vehicle, :ok
  end

  def create
    vehicle = Vehicle.new vehicle_params
    vehicle.user_id = @current_user.id
    if vehicle.save
      json_response 'Created vehicle successfully', true, vehicle, :ok
    else
      json_response 'Create vehicle failed', false, vehicle, :unprocessable_entity
    end
  end

  def update
    if @vehicle
      if @vehicle.update vehicle_params
        json_response 'Vehicle updated successfully', true, @vehicle, :ok
      else
        json_response 'Vehicle update failed', false, {}, :unprocessable_entity
      end
    else
      json_response 'Vehicle not found', false, {}, :not_found
    end
  end

  def destroy
    if @vehicle
      if @vehicle.destroy
        json_response 'Deleted vehicle successfully', true, {}, :ok
      else
        json_response 'Delete vehicle failed', false, {}, :unprocessable_entity
      end
    else
      json_response 'Vehicle not found',false, {}, :not_found
    end
  end

  private

  def load_category

  end

  def load_user

  end

  def load_vehicle
    @vehicle = Vehicle.find_by('id': params[:id], 'user_id': @current_user.id)
    unless @vehicle.present?
      json_response 'Cannot find a vehicle', false, {}, :not_found
    end
  end

  def vehicle_params
    params.permit(:title, :description, :price, :make_year, :buy_date, :category_id, :images => [])
  end
end