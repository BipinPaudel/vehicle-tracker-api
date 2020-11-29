module Api
  module V1
    class CategoriesController < ApplicationController
      skip_before_action :verify_authenticity_token
      def index
        categories = Category.order('created_at DESC')
        render json: {status: 'SUCCESS', message: 'Loaded categories', data: categories}, status: :ok
      end

      def show
        category = Category.find(params[:id])
        render json: {status: 'SUCCESS', message: 'Loaded categories', data: category}, status: :ok
      end

      def create
        category = Category.new(category_params)
        puts category.inspect
        if category.save
          render json: {status: 'SUCCESS', message: 'Saved categories', data: category}, status: :ok
        else
          render json: {status: 'ERROR', message: 'Could not save', data: category}, status: :unprocessable_entity
        end
      end

      def destroy
        category = Category.find(params[:id])
        category.destroy
        render json: {status: 'SUCCESS', message: 'Deleted category', data: category}, status: :ok
      end

      def update
        category = Category.find(params[:id])
        if category.update_attributes(category_params)
          render json: {status: 'SUCCESS', message: 'Updated category', data: category}, status: :ok
        else
          render json: {status: 'ERROR', message: 'Category not updated', data: category.errors}, status: :unprocessable_entity
        end
      end

      private

      def category_params
        params.permit(:title, :description)
      end
    end
  end
end