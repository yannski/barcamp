class Admin::AdminController < ApplicationController
  
  before_filter :verify_admin_rights

  layout "admin"

private

  def verify_admin_rights
    !!current_user.admin
  end

public

  def index

  end
end
