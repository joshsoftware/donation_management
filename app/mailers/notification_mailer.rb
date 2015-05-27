class NotificationMailer < ActionMailer::Base

  default from: "noreply <#{ENV['MAIL_SENDER']}>"
  def send_notification_of_donation(email, text)
    @text = text
    mail(to: email, subject: "Confirmation of donation to sevasahayog ")
  end
end
