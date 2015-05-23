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
  field :cheque_date, type: Date

  field :pan_number, type: String

  validates :name, :email, :mobile_number, :amount, :user, presence: true
  validates_format_of :email, with: Devise.email_regexp 
  validates :cheque_number, :bank, :cheque_date, presence: true, if: -> {by_cash == false} 

  belongs_to :user

  after_create do
    if self.by_cash
      collection = self.user.total_collection_by_cash
      collection += self.amount
      self.user.set(:total_collection_by_cash, collection)
    else
      collection = self.user.total_collection_by_cheque
      collection += self.amount
      self.user.set(:total_collection_by_cheque, collection)
    end

    SmsService::Sms.send_sms_notification.new(self.mobile_number, self.user.contact_number, self.name, self.amount, self.by_cash ? 'Cash' : 'Cheque')
  end

end
