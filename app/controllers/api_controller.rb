# Make every controller inherit from this one
class ApiController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::RequestForgeryProtection
  protect_from_forgery unless: -> { request.format.json? }
end
