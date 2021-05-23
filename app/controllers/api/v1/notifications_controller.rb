# frozen_string_literal: true

module Api
  module V1
    class NotificationsController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :authorize_request, only: %i[create index show destroy update user_notifications]
      before_action :load_notification_by_vehicle, only: %i[create update]
      before_action :load_notification, only: %i[update destroy]

      def index; end

      def user_notifications
        notifications = Notification.user_notifications(current_user.id)
        json_response 'Notification list', true, notifications, :ok
      end

      def show
        if user_vehicle?
          notification = Notification.where(vehicle_id: params[:vehicle_id])
          if notification
            json_response 'Notification loaded successfully', true, notification, :ok
          else
            json_response_errors 'Notification not found', :not_found
          end
        else
          json_response_errors 'Vehicle not found', :not_found
        end
      end

      def destroy
        if @notification && user_vehicle?(@notification.vehicle_id)
          if @notification.destroy
            json_response 'Notification deleted successfully', true, {}, :ok
          else
            json_response_errors 'Notification delete failed', :unprocessable_entity
          end
        else
          json_response_errors 'Vehicle not found', :not_found
        end
      end

      def update
        if user_vehicle? && @notification
          if @notification.update notification_params
            json_response 'Notification updated successfully', true, @notification, :ok
          else
            json_response_errors @notification.errors, :unprocessable_entity
          end
        else
          json_response_errors 'Vehicle not found', :not_found
        end
      end

      def create
        if user_vehicle?
          if @notification.present?
            json_response 'Only one notification for a vehicle', false, { }, :unprocessable_entity
          else
            notification = Notification.create notification_params
            if notification.valid?
              json_response 'Created notification successfully', true, notification, :ok
            else
              json_response_errors notification.errors, :unprocessable_entity
            end
          end
        else
          json_response_errors 'Vehicle not found', :not_found
        end
      end

      private

      def load_notification
        @notification = Notification.find_by(id: params[:id])
      end

      def load_notification_by_vehicle
        if params[:vehicle_id].present?
          @notification = Notification.find_by(vehicle_id: params[:vehicle_id])
        end
      end

      def load_vehicles
        @vehicles = Vehicle.where(user_id: current_user.id)
      end

      def notification_params
        params.permit(:km, :day, :vehicle_id)
      end
    end
  end
end
