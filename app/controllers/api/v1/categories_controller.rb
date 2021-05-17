# frozen_string_literal: true

module Api
  module V1
    class CategoriesController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :authorize_request, except: [:index, :show]
      def index
        categories = Category.order('created_at DESC')
        json_response 'Loaded categories', true, categories, :ok
      end

      def show
        category = Category.find(params[:id])
        json_response 'Loaded category', true, category, :ok
      end

      def create
        category = Category.new(category_params)
        puts category.inspect
        if category.save
          json_response 'Saved categories', true, category, :ok
        else
          json_response_errors 'Could not save', :unprocessable_entity
        end
      end

      def destroy
        category = Category.find(params[:id])
        category.destroy
        json_response 'Deleted', true, category, :ok
      end

      def update
        category = Category.find(params[:id])
        if category.update_attributes(category_params)
          json_response 'Updated', true, category, :ok
        else
          json_response_errors 'Category not updated', :unprocessable_entity
        end
      end

      private

      def category_params
        params.permit(:title, :description)
      end
    end
  end
end
