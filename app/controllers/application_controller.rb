# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  helper_method :current_user_session, :current_user
  filter_parameter_logging :password, :password_confirmation
  before_filter :set_locale, :set_gmaps_links

private
 
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_gmaps_links
    @gmaps_link = "http://maps.google.fr/maps?f=q&amp;source=embed&amp;hl=fr&amp;geocode=&amp;q=17+rue+des+magasins+67000+Strasbourg&amp;sll=48.590958,7.74019&amp;sspn=0.007196,0.017595&amp;ie=UTF8&amp;hq=&amp;hnear=17+Rue+des+Magasins,+67000+Strasbourg,+Bas-Rhin,+Alsace&amp;ll=48.598125,7.744417&amp;spn=0.007196,0.017595&amp;z=14"
    @embed_gmaps_link = @gmaps_link + "&amp;output=embed"
  end

  # Catches special exceptions in all controllers
  def rescue_action(e)
    case e
    when ActionController::NotImplemented
      render_optional_error_file "method_not_allowed".to_sym    
    when ActiveRecord::RecordNotFound
      render_optional_error_file "not_found".to_sym
    else
      super
    end
  end 

  def render_optional_error_file(status_code)
    status_number = ActionController::StatusCodes::SYMBOL_TO_STATUS_CODE[status_code]
    status = interpret_status(status_code)

    respond_to do |type|
      type.html { render :template => "/shared/#{status_number}", :status => status }
      type.all  { render :nothing => true, :status => status }
    end
  end

  def new_usersession
    @user_session = UserSession.new
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to login_path
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to root_path
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

end
