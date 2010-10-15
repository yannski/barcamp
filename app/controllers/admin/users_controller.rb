require 'digest/sha1'

class Admin::UsersController < Admin::AdminController

  before_filter :load_user, :only => %w(edit update destroy update_admin_status)

protected

  def load_user
    @user = User.find params[:id]
  end

public

  def index
    @users = User.paginate :page => params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new params[:user]
    pass = Digest::SHA1.hexdigest('secret')[0,8]
    @user.password = pass
    @user.password_confirmation = pass
    if @user.save
      redirect_to admin_users_path
    else
      render :action => "new"
    end
  end

  def edit
  end

  def update
    if @user.update_attributes params[:user]
      redirect_to admin_users_path
    else
      render :action => "edit"
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  def update_admin_status
    @user.admin = params[:value]
    @user.save

    respond_to do |format|
      format.json{ render :json => {}, :status => :ok }
      format.html{ redirect_to admin_users_path }
    end
  end
end
