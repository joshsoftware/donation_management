require 'csv'
class Donation
  include Mongoid::Document
  include Mongoid::Timestamps
  include SmsService 

  field :name, type: String
  field :email, type: String 
  field :mobile_number, type: String
  field :by_cash, type: Boolean
  field :amount, type: Integer
  field :submitted_to_office, type: Boolean, default: false

  field :cheque_number, type: String
  field :bank, type: String
  field :cheque_date, type: String 

  field :pan_number, type: String

  validates :name, :email, :mobile_number, :amount, :user, presence: true
  validates_format_of :email, with: Devise.email_regexp 
  validates :cheque_number, :bank, :cheque_date, presence: true, if: -> {by_cash == false} 

  belongs_to :user

  after_create do
    if self.by_cash
      collection = self.user.total_collection_by_cash
      collection += self.amount
      self.user.set(total_collection_by_cash: collection)
    else
      collection = self.user.total_collection_by_cheque
      collection += self.amount
      self.user.set(total_collection_by_cheque: collection)
    end

    sms = SmsService::Sms.new
    sms.delay.send_sms_notification(self.mobile_number, self.user.contact_number, self.name, self.amount, self.by_cash ? 'Cash' : 'Cheque')
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << ["Date", "Donor Name", "Donor Email", "Donor Mobile" ,"Amount", "Cash/Cheque", "Cheque date", "Cheque number", "Bank", "Collected By"]
      Donation.all.each do |donation|
        payment_mode = donation.by_cash ? 'Cash' : 'Cheque'
        csv << [donation.created_at.to_date, donation.name, donation.email, donation.mobile_number, donation.amount, payment_mode, donation.cheque_date, 
          donation.cheque_number, donation.bank, donation.user.name ]
      end
    end
  end

end
