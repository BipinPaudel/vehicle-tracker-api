module Response
  def json_response(messages, is_success, data, status)
    render json: {
      messages: messages,
      is_success: is_success,
      data: data
    }, status: status
  end

  def json_response_errors(errors, status)
    render json: {
      errors: map_errors(errors),
      is_success: false
    }, status: status
  end

  private

  def map_errors(errors)
    return [] if errors.blank?

    return [errors] if errors.is_a?(String)

    return errors.messages.map { |k, v| v }.flatten if errors.is_a?(ActiveModel::Errors)

    errors
  end
end
