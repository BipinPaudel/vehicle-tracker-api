# frozen_string_literal: true

module Validators
  module Validator

    def self.included klass
      klass.class_eval do
        include ActiveModel::Validations
      end
    end

    def parsed_errors
      errors.messages.map { |k, v| v }.flatten
    end
  end
end

