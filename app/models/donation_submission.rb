class DonationSubmission
  include Mongoid::Document
  include Mongoid::Timestamps

  field :cash_amount_pending, type: Integer
  field :cheque_amount_pending, type: Integer
  field :amount_collected_by_cash, type: Integer
  field :amount_collected_by_cheque, type: Integer
  
  belongs_to :user
end
