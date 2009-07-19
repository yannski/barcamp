class WelcomeController < ApplicationController

  def index
    @page = Page.first
  end
end
