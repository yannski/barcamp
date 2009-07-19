class AttendeesController < ApplicationController

  def index
    @attendees = Attendee.all
  end

  def create
    @attendee = Attende.new params[:attendee]

    if @attendee.save
      respond_to do |format|
        format.json { @attendee.to_json }
      end
    else
      respond_to do |format|
        format.json {
          @attendeee.errors.to_json
        }
      end
    end
  end
end
