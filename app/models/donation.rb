require 'csv'
class Donation
  include Mongoid::Document
  include Mongoid::Timestamps
  include NotificationService 

  field :name, type: String
  field :email, type: String 
  field :mobile_number, type: String
  field :by_cash, type: Boolean
  field :amount, type: Integer
  field :submitted_to_office, type: Boolean, default: false

  field :cheque_number, type: String
  field :bank, type: String
  field :cheque_date, type: String, default: Date.today.strftime('%d/%m/%Y') 

  field :pan_number, type: String
  field :unique_identifier

  validates :name, :email, :mobile_number, :amount, :user, :unique_identifier, presence: true
  validates_format_of :email, with: Devise.email_regexp 

  validates :cheque_number, :bank, :cheque_date, presence: true, if: -> {by_cash == false} 
  validates_numericality_of :cheque_number, only_integer: true, if: -> {by_cash == false} 

  validates :mobile_number, numericality: true, format: {with: /\A\d{10}\z/, message: "is invalid, enter mobile number without 0 or +91"}
  validates :cheque_date, format: {with: /\A(0?[1-9]|[12][0-9]|3[01])[\/](0?[1-9]|1[012])[\/](\d{4})\z/, message: "is invalid, enter date in dd/mm/yyyy format", allow_blank: false}, if: -> {by_cash == false} 

  belongs_to :user

  before_validation do
    self.unique_identifier = DateTime.now.to_i
  end

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

    Thread.new do
      self.send_email_notification
      self.send_sms_notification
    end
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << ["Uniq Id", "Date", "Donor Name", "Donor Email", "Donor Mobile" ,"Amount", "Cash/Cheque", 
              "Cheque date", "Cheque number", "Bank", "Collected By"]
      Donation.all.each do |donation|
        payment_mode = donation.by_cash ? 'Cash' : 'Cheque'
        csv << [donation.unique_identifier, donation.created_at.to_date, donation.name, donation.email, 
                donation.mobile_number, donation.amount, payment_mode, donation.cheque_date, 
                donation.cheque_number, donation.bank, donation.user.name ]
      end
    end
  end

end
