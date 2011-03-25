class Admin::AdminController < ApplicationController
  
  before_filter :verify_admin_rights

  layout "admin"

private

  def verify_admin_rights
    !current_user.admin? && render(:text => "You're not authorized to view this page", :status => 301)
  end

public

  def index

  end
end
