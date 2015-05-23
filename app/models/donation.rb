class Donation
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :email, type: String 
  field :mobile_number, type: String
  field :amount, type: Float
  field :by_cash, type: Boolean
  field :submitted_to_office, type: Boolean, default: false

  field :cheque_number, type: String
  field :bank, type: String
  field :cheque_date, type: Date

  field :pan_number, type: String

  validates :name, :email, :mobile_number, :amount, presence: true
  validates_format_of :email, with: Devise.email_regexp 
  validates :cheque_number, :bank, :cheque_date, presence: true, if: -> {by_cash == false} 

end
