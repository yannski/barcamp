class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_default_locale

protected

  def set_default_locale
    params[:locale].present? ? I18n.locale = params[:locale] : I18n.locale = :en
  end

  def default_url_options(options={})
    I18n.locale == :en ? {} : { :locale => I18n.locale }
  end
end
