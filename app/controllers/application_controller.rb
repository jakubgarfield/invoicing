class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :redirect_if_not_google_authenticated
end
