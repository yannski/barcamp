class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_default_locale

protected

  def set_default_locale
    params[:locale].present? ? I18n.locale = params[:locale] : I18n.locale = :fr
  end

  def default_url_options(options={})
    I18n.locale == :fr ? {} : { :locale => I18n.locale }
  end
end
