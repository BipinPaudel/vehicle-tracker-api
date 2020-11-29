module Api
  module V1
    class CategoriesController < ApplicationController
      def index
        articles = Category.order('created_at DESC')
        render json: {status: 'SUCCESS', message: 'Loaded categories', data: articles}, status: :ok
      end
    end
  end
end