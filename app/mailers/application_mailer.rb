class ApplicationMailer < ActionMailer::Base
  default from: "noreply@#{ENV['MAILGUN_DOMAIN']}"
  layout 'mailer'
end
