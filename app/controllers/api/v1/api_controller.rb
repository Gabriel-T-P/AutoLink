class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_error_404

  private

  def not_found_error_404
    render status: 404, json: { result: "No contact message was found with the given id" }
  end
end
