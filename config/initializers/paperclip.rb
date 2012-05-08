Paperclip::Attachment.default_options[:storage] = :fog
Paperclip::Attachment.default_options[:fog_credentials] = {
  :aws_access_key_id => ENV['AWS_ACCESS_KEY_ID'],
  :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  :provider => 'AWS'
}
Paperclip::Attachment.default_options[:fog_directory] = ENV['S3_BUCKET_NAME']
Paperclip::Attachment.default_options[:fog_file] = {'Cache-Control' => 'max-age=315576000', 'Expires' => 1.years.from_now.httpdate}
Paperclip::Attachment.default_options[:fog_host] = "http://" + ENV['S3_BUCKET_NAME'] + ".s3.amazonaws.com"
Paperclip::Attachment.default_options[:fog_public] = true

Paperclip::Attachment.default_options[:path] = ":class/:attachment/:id/:style/:filename"

class String
  def without_host
    if Rails.env.development?
      self
    else
      self.gsub /http:\/\/epra3-(.*).s3.amazonaws.com/, ""
    end
  end
end
