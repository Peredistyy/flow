class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :export_i18n_messages

  def export_i18n_messages
    SimplesIdeias::I18n.export! if Rails.env.development?
  end

end
