class Api::V1::VehiclesController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :load_user, only: :index
  before_action :load_vehicle, only: [:show]
  before_action :authenticate_with_token!, only: [:create]
  def index
    @vehicles = @user.vehicles
    json_response 'Vehicles loaded successfully', true, @vehicles, :ok
  end

  def show
    json_response 'Show vehicle successfully', true, @vehicle, :ok
  end

  def create
    vehicle = Vehicle.new vehicle_params
    vehicle.user_id = current_user.id
    if vehicle.save
      json_response 'Created vehicle successfully', true, vehicle, :ok
    else
      json_response 'Create vehicle failed', false, vehicle, :unprocessable_entity
    end
  end

  def update

  end

  def destroy

  end

  private

  def load_category

  end

  def load_user

  end

  def load_vehicle
    @vehicle = Vehicle.find_by('id': params[:id])
    unless @vehicle.present?
      json_response 'Cannot find a review', false, {}, :not_found
    end
  end

  def vehicle_params
    params.permit(:description, :price, :make_year, :buy_date, :category_id)
  end
end