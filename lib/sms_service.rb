module SmsService

  class Sms
    #http://sms.smscollection.com/sendsmsv2.asp?user=<user>&password=<password>&sender=<sender_id>
    #&text=This+is+a+sample+sms&PhoneNumber=<phone_number>&track=0
    
    def send_sms_notification(donor_ph_number, coordinator_ph_number, donor_name, amount, payment_method)
      donor_text = "Thanks for donation of Rs #{amount}/-. Your receipt will be processed manually and sent to you within a week over email."
      coordinator_text = "Rs #{amount}/- (#{payment_method}) received from #{donor_name}"
      send_sms(donor_ph_number, donor_text)
      send_sms(coordinator_ph_number, coordinator_text)
    end

    def send_sms(phone_number, text)
      url = "http://sms.smscollection.com/sendsmsv2.asp?"
      params = {user: ENV['user'], password: ENV['password'], sender: ENV['sender'], text: text, PhoneNumber: phone_number}
      response = RestClient.post url, params, content_type: :json, accept: :json
    end
  end
end
