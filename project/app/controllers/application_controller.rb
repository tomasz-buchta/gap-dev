class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  rescue_from AuthorizationException, with: :unauthorized

  private

  def unauthorized(message)
    render status: 403, json: { message: "Not authorized", error: message }
  end
end
