class AttendeesController < ApplicationController

  def index
    @attendees = Attendee.all
  end

  def new
    @attendee = Attendee.new
    @attendees = Attendee.all
  end

  def create
    @attendee = Attendee.new params[:attendee]

    if @attendee.save
      redirect_to attendees_path
    else
      render :action => "new"
    end
  end
end
