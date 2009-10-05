class Notifications < ActionMailer::Base
  

  def schedule
    subject    'BarCampAlsace6 : dernières infos'
    recipients Attendee.find(:all, :conditions => ["email IS NOT NULL"]).map(&:email)
    from       'yann.klis@novelys.com'
  end

end
