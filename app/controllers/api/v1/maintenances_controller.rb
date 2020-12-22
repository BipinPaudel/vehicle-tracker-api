module Api
  module V1
    class MaintenancesController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :authenticate_with_token!, only: [:create, :index, :show, :destroy, :update]
      before_action :load_maintenance, only: [:destroy, :update, :show]


      def index
        if user_vehicle?
          maintenances = Maintenance.where(vehicle_id: params[:vehicle_id])
          json_response 'Maintenances loaded successfully', true, maintenances, :ok
        else
          json_response 'Vehicle not found', false, {}, :not_found
        end
      end

      def list_by_vehicle
        if user_vehicle?
          maintenances = Maintenance.where(vehicle_id: params[:vehicle_id])
          json_response 'Maintenances loaded successfully', true, maintenances, :ok
        else
          json_response 'Vehicle not found', false, {}, :not_found
        end
      end

      def show
        if user_vehicle?(@maintenance.vehicle_id)
          json_response 'Show maintenance successfully', true, @maintenance, :ok
        else
          json_response 'Vehicle not found', false, {}, :not_found
        end
      end

      def create
        if user_vehicle?
          maintenance = Maintenance.new maintenance_params
          if maintenance.save
            json_response 'Create maintenance successfully', true, maintenance, :ok
          else
            json_response 'Create maintenance failed', false, maintenance, :unprocessable_entity
          end
        else
          json_response 'Vehicle not found', false, {}, :not_found
        end
      end

      def update
        if @maintenance && user_vehicle?
          if @maintenance.update maintenance_params
            json_response 'Maintenance updated successfully', true, @maintenance, :ok
          else
            json_response 'Maintenance update failed', false, {}, :unprocessable_entity
          end
        else
          json_response 'Maintenance not found', false, {}, :not_found
        end
      end

      def destroy
        if @maintenance && user_vehicle?(@maintenance.vehicle_id)
          if @maintenance.destroy
            json_response 'Deleted maintenance successfully', true, {}, :ok
          else
            json_response 'Delete failed', false, {}, :unprocessable_entity
          end
        else
          json_response 'Maintenance not found', false, {}, :not_found
        end
      end

      private

      def load_maintenance
        @maintenance = Maintenance.find_by('id': params[:id])
        unless @maintenance.present?
          json_response 'Cannot find maintenance', false, {}, :not_found
        end
      end

      def maintenance_params
        params.permit(:km, :date, :price, :description, :vehicle_id)
      end

    end
  end
end