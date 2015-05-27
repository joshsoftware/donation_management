module NotificationService
  #http://sms.smscollection.com/sendsmsv2.asp?user=<user>&password=<password>&sender=<sender_id>
  #&text=This+is+a+sample+sms&PhoneNumber=<phone_number>&track=0

  def send_email_notification
    NotificationMailer.send_notification_of_donation(email, donor_text).deliver_now
    NotificationMailer.send_notification_of_donation(self.user.email, coordinator_text).deliver_now
  end

  def send_sms_notification
    send_sms(mobile_number, donor_text)
    send_sms(self.user.contact_number, coordinator_text)
  end

  private

  def send_sms(phone_number, text)
    url = "http://sms.smscollection.com/sendsmsv2.asp?"
    params = {user: ENV['SMS_USER'], password: ENV['SMS_PASSWORD'], sender: ENV['SMS_SENDER'], text: text, PhoneNumber: phone_number}
    response = RestClient.post url, params, content_type: :json, accept: :json
  end

  def donor_text
    donor_text = "Thanks for donation of Rs #{amount}/-. Your receipt will be processed manually and sent to you within a week over email."
  end

  def coordinator_text
    payment_method = self.by_cash ? 'Cash' : 'Cheque'
    coordinator_text = "Rs #{amount}/- (#{payment_method}) received from #{name}. Contact Number: #{mobile_number}"
  end
end
