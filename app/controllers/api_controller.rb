# Make every controller inherit from this one
class ApplicationController < ActionController::API
  protect_from_forgery unless: -> { request.format.json? }
end
