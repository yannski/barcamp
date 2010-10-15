class WelcomeController < ApplicationController

  def index
    @page_title = t(:nav_home)
  end
end
