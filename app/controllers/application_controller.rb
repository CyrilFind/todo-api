# Use Base ActionController for compatibility with ActiveAdmin
class ApplicationController < ActionController::Base
        include DeviseTokenAuth::Concerns::SetUserByToken
end
