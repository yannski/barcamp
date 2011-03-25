class AttendeesController < ApplicationController

  def index
    @attendees = Attendee.all.asc(:created_at)

    respond_to do |format|
      format.html
      format.csv {
        csv_string = FasterCSV.generate do |csv|
          columns = %w(first_name last_name email organization website tshirt_size is_eating)
          # header row
          csv << columns
          
          # data rows
          @attendees.each do |attendee|
            csv << columns.map{|column| attendee.send column.to_sym}
          end
        end
        
        # send it to the browsah
        send_data csv_string,
          :type => 'text/csv; charset=iso-8859-1; header=present',
          :disposition => "attachment; filename=attendees.csv"
      }
    end
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
