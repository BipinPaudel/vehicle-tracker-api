module Api
  module V1
    class NotificationsController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :authorize_request, only: [:create, :index, :show, :destroy, :update, :user_notifications]
      before_action :load_notification, only: [:destroy, :update]

      def index

      end

      def user_notifications
        notifications = Notification.user_notifications(current_user.id)
        json_response 'Notification list', true, notifications, :ok
      end

      def show
        if user_vehicle?
          notification = Notification.find_by(vehicle_id: params[:vehicle_id])
          if notification
            json_response 'Notification loaded successfully', true, notification, :ok
          end
          json_response 'Notification not found', false, {}, :not_found
        end
      end

      def destroy

      end

      def update

      end

      def create
        if user_vehicle?
          notification = Notification.new notification_params
          if notification.save
            json_response 'Create notification successfully', true, notification, :ok
          else
            json_response 'Create notification failed', false, notification, :unprocessable_entity
          end
        else
          json_response 'Vehicle not found', false, {}, :not_found
        end
      end

      private

      def load_notification

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